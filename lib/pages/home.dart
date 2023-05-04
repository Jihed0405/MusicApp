import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/data/data_state_notifier.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/pages/song_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/playlist_card.dart';
import '../widgets/section_headers.dart';
import '../widgets/song_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class Home extends ConsumerStatefulWidget {

   Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;
    List<Playlist> playlists = Playlist.playlists;
  
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 154, 204, 233).withOpacity(0.8),
            Color.fromARGB(255, 211, 215, 218).withOpacity(0.8),
          ])),
      child: Scaffold(
        
        backgroundColor: Colors.transparent,
        appBar: const _CustomAppbar(),
        bottomNavigationBar: const _CustomNavBar(),
        body: Stack(
          children: [SingleChildScrollView(
              child: Column(
            children: [
              _DiscoverMusic(),
              _TrendingMusic(songs: songs),
              _PlaylistMusic(playlists: playlists)
            ],
          ),
          ),
          Positioned(bottom: 10,
          left: 4,
          right: 4,
          child: InkWell(
            onTap: () {
                Get.toNamed('/song', arguments: ref.watch(songSelect));
                
            },
            child: PlayerHome(currentSong:ref.watch(songSelect))),)
          ]
        ),
          
      ),
    );
  }
}
class PlayerHome extends StatefulWidget {
  
  const PlayerHome({super.key, required this.currentSong});
final Song currentSong;
  @override
  State<PlayerHome> createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding:const EdgeInsets.all(8) ,
      decoration: const BoxDecoration(
        color: Color(0xff4b6f99),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(8))),
                    height: 40,width: 50,
                    child: ClipRRect(
                       borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(imageUrl: widget.currentSong.coverUrl))),
            const SizedBox(width: 10,),
            Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.currentSong.title,
                    style: const TextStyle(color: Colors.white,fontSize: 18,
                    fontWeight: FontWeight.bold ),
                    ),
                    Text(widget.currentSong.singer,
                    style: const TextStyle(color: Colors.white54, ),
                    ),
                  ],
            ),
                ],
              ),
            Row(
            children: [
              const Icon(Icons.favorite_border,color: Colors.white,size:25),
              const SizedBox(width: 10),
           StreamBuilder<PlayerState>(
            stream: SongScreenState.audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playerState = snapshot.data;
                final processingState = playerState!.processingState;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    width: 5.0,
                    height: 5.0,
                    margin: const EdgeInsets.all(10.0),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2 ,
                    ),
                  );
                } else if (!SongScreenState.audioPlayer.playing) {
                  return IconButton(
                    onPressed: SongScreenState.audioPlayer.play,
                    
                    icon: const Icon(
                      Icons.play_arrow_sharp,
                      color: Colors.white,
                    ),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: SongScreenState.audioPlayer.pause,
                    
                    icon: const Icon(
                      Icons.pause_sharp,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () => SongScreenState.audioPlayer.seek(Duration.zero,
                        index: SongScreenState.audioPlayer.effectiveIndices!.first),
                    iconSize: 20,
                    icon: const Icon(
                      Icons.replay_circle_filled_outlined,
                      color: Colors.white,
                    ),
                  );
                }
              } else {
                return Container(
                  width: 2, height: 2,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            }),
              
            ],
          )
            ],
          ),
          
        ],
      ),
    );
  }
}

class _PlaylistMusic extends StatelessWidget {
  const _PlaylistMusic({
    super.key,
    required this.playlists,
  });

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SectionHeader(title: "Playlists"),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top:20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: playlists.length,
            itemBuilder: ((context,index){
              return PlaylistCard(playlist: playlists[index]);
            }),
          ),
        ],  
      ),
    );
  }
}


class _TrendingMusic  extends StatefulWidget {
  
  const _TrendingMusic({super.key, required this.songs});
final List<Song> songs;

  @override
  State<_TrendingMusic> createState() => _TrendingMusicState();
}

class _TrendingMusicState extends State<_TrendingMusic> {


  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,top:20.0,bottom: 20.0),
      child: Column(
        children:  [
          const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: SectionHeader(title:"Trending Music",),
          ),
           const SizedBox(height: 20),
          SizedBox(
          height:MediaQuery.of(context).size.height * 0.27,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.songs.length,
            itemBuilder: (context,index){
              return SongCard(  song: widget.songs[index],
             );
            }
            ),
             )
        ],
      ),
    );
  }
}



class _DiscoverMusic extends StatelessWidget {
  const _DiscoverMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 5),
          Text(
            'Enjoy your favorite music',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey.shade400),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none),
            ),
          )
        ],
      ),
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Profile',
          )
        ]);
  }
}

class _CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.grid_view_rounded),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
