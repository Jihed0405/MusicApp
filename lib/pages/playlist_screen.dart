import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/pages/song_screen.dart';
import '../data/data_state_notifier.dart';
import '../models/playlist_model.dart';
import 'home.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer'as develop;
class PlaylistScreen extends ConsumerStatefulWidget {
  const PlaylistScreen({super.key});

  @override
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    Playlist playlist = ref.watch(playlistSelect)?? Playlist.playlists[0];

    return SafeArea(
      top: true,
      left: true,
      bottom: true,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              const Color.fromARGB(255, 173, 165, 241).withOpacity(0.8),
              const Color.fromARGB(255, 137, 183, 204).withOpacity(0.8),
            ])),
        child: Padding(
          padding: const EdgeInsets.only(top:8),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
               preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Container(margin: const EdgeInsets.only(left: 100),
                    child: const Text('Playlist')),
                ),
              ),
            ),
            body: Stack(
              children:[ RawScrollbar(
                thumbColor:Color.fromARGB(115, 66, 4, 238),
                thickness:5,
                minOverscrollLength:2,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      _PlaylistInformation(playlist: playlist),
                      const SizedBox(
                        height: 20,
                      ),
                       _PlayOrShuffleSwitch(playlist: playlist),
                      const SizedBox(
                        height: 20,
                      ),
                      _PlaylistSongs(playlist: playlist),
                
                    ],
                  ),
                )),
              ),
               Positioned(bottom: 65,
          left: 4,
          right: 4,
          child: InkWell(
            onTap: () {
                Get.toNamed('/song', arguments: ref.watch(songSelect));
                
            },
            child: PlayerHome(currentSong:ref.watch(songSelect))),)]
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaylistSongs extends ConsumerStatefulWidget {
  const _PlaylistSongs({
    super.key,
    required this.playlist,
  });
    final Playlist playlist;
 @override
  ConsumerState<_PlaylistSongs> createState() => _PlaylistSongState();
}

class _PlaylistSongState extends ConsumerState<_PlaylistSongs> {


  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.playlist.songs.length,
      itemBuilder: (context,index){
          return InkWell(
        onTap: () {
       // Get.toNamed('/song', arguments: widget.song);
        ref.read(songSelect.notifier).state=widget.playlist.songs[index];
        SongScreenState.audioPlayer.setAudioSource(
        //   preload: false,
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            
            Uri.parse('asset:///${ref.watch(songSelect).url}'),
            tag: MediaItem(
              title: ref.watch(songSelect).title,
              artist: ref.watch(songSelect).singer,
              artUri: Uri.parse(ref.watch(songSelect).coverUrl),
              id:'1',
            )
            
            
          ),
          
        ],
      ),
    );
    SongScreenState.audioPlayer.play();
      },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading:ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child:CachedNetworkImage(imageUrl: widget.playlist.songs[index].coverUrl,
                    height: 50,width: 50,
                    fit: BoxFit.cover,),
                  ),
                  title: Text(
                    widget.playlist.songs[index].title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(widget.playlist.songs[index].singer),
                  trailing: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
      },);
  }
}

class _PlayOrShuffleSwitch extends ConsumerStatefulWidget {
  const _PlayOrShuffleSwitch({
    super.key,
 required this.playlist,
  });
    final Playlist playlist;
  
  @override
  ConsumerState<_PlayOrShuffleSwitch> createState() => _PlayOrShuffleSwitchState();
}

class _PlayOrShuffleSwitchState extends ConsumerState<_PlayOrShuffleSwitch> {
  bool isPlay = false;
   var audioSourceChildren=ConcatenatingAudioSource(children: []);
  @override
  void initState() {
  
   
   
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlay=true;
                    });
                    ref.read(songSelect.notifier).state=ref.watch(playlistSelect).songs[0];
        
        SongScreenState.audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: ref.watch(playlistSelect).songs.map((e) => 
       AudioSource.uri(
            
            Uri.parse('asset:///${e.url}'),
            tag: MediaItem(
              title: e.title,
              artist: e.singer,
              artUri: Uri.parse(e.coverUrl),
              id:'1',
            )
            
            
          ),).toList()),

    );
  
    SongScreenState.audioPlayer.play();

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                              color: isPlay ? Colors.lightBlue : Colors.black,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.play_circle,
                        color: isPlay ? Colors.lightBlue : Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlay=false;
                    });
                   
        
        SongScreenState.audioPlayer.setAudioSource(
          initialIndex: 0,
      ConcatenatingAudioSource(children: ref.watch(playlistSelect).songs.map((e){ 
      var index=-1;
      return  AudioSource.uri(
            
            Uri.parse('asset:///${e.url}'),
            tag: MediaItem(
              title: e.title,
              artist: e.singer,
              artUri: Uri.parse(e.coverUrl),
              id:'${index+1}',
            )
            
            
          );}).toList()),

    );
      SongScreenState.audioPlayer.shuffle();
     SongScreenState.audioPlayer.setShuffleModeEnabled(true);
  
    SongScreenState.audioPlayer.play();
   
     ref.read(songSelect.notifier).state=ref.watch(playlistSelect).songs[SongScreenState.audioPlayer.effectiveIndices![0]];
                  
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                              color: isPlay ? Colors.black : Colors.lightBlue,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.shuffle,
                        color: isPlay ? Colors.black : Colors.lightBlue,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaylistInformation extends StatelessWidget {
  const _PlaylistInformation({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CachedNetworkImage( imageUrl:
            playlist.imageUrl,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          playlist.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
