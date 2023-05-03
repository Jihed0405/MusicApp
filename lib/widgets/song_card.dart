import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/data/data_state_notifier.dart';
import 'package:music_app/pages/song_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/song_model.dart';


 class SongCard extends ConsumerStatefulWidget {
 const SongCard({
  Key? key ,
    
    required this.song, 
  }):super(key: key);
 
  final Song song;

  @override
  ConsumerState<SongCard> createState() => SongCardState();
}

class SongCardState extends ConsumerState<SongCard> {



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/song', arguments: widget.song);
        ref.read(songSelect.notifier).state=widget.song;
        SongScreenState.audioPlayer.setAudioSource(
           preload: false,
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
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.46,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(imageUrl: widget.song.coverUrl,
             height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.65,
              fit: BoxFit.fill,),
            ),
             
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.38,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                            widget.song.title,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                            widget.song.description,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        )
                      ]),
                  IconButton(
                    icon: Icon(
                      Icons.play_circle,
                      color: Colors.lightBlue.shade800,
                    ),
                    onPressed: (){
                        ref.read(songSelect.notifier).state=widget.song;
                         SongScreenState.audioPlayer.setAudioSource(
                           preload: false,
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${ref.watch(songSelect).url}'),
            tag: MediaItem(
              title: ref.watch(songSelect).title,
              artist:ref.watch(songSelect).singer,
              artUri: Uri.parse(ref.watch(songSelect).coverUrl),
              id:'1',
            )
            
            
          ),
          
        ],
      ),
    );
    SongScreenState.audioPlayer.play();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
