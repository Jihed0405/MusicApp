import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../data/data_state_notifier.dart';
import '../models/playlist_model.dart';
import 'home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class PlaylistScreen extends ConsumerStatefulWidget {
  const PlaylistScreen({super.key});

  @override
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    Playlist playlist = Playlist.playlists[0];
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
                      const _PlayOrShuffleSwitch(),
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

class _PlaylistSongs extends StatelessWidget {
  const _PlaylistSongs({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlist.songs.length,
      itemBuilder: (context,index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading:ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child:CachedNetworkImage(imageUrl: playlist.songs[index].coverUrl,
                  height: 50,width: 50,
                  fit: BoxFit.cover,),
                ),
                title: Text(
                  playlist.songs[index].title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(playlist.songs[index].singer),
                trailing: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          );
      },);
  }
}

class _PlayOrShuffleSwitch extends StatefulWidget {
  const _PlayOrShuffleSwitch({
    super.key,
  });
  @override
  State<_PlayOrShuffleSwitch> createState() => _PlayOrShuffleSwitchState();
}

class _PlayOrShuffleSwitchState extends State<_PlayOrShuffleSwitch> {
  bool isPlay = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isPlay ? 0 : width * 0.45,
              child: Container(
                height: 50,
                width: width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade400,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                              color: isPlay ? Colors.white : Colors.lightBlue,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.play_circle,
                        color: isPlay ? Colors.white : Colors.lightBlue,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                              color: isPlay ? Colors.lightBlue : Colors.white,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.shuffle,
                        color: isPlay ? Colors.lightBlue : Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
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
