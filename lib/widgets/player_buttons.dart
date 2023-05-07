import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/data/data_state_notifier.dart';
import 'package:music_app/pages/song_screen.dart';
import 'dart:developer';
import '../models/song_model.dart';

class PlayerButtons extends ConsumerStatefulWidget {
  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;
  @override
 ConsumerState<PlayerButtons> createState() => _PlayerButtonState();
 }
 class _PlayerButtonState extends ConsumerState<PlayerButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: SongScreenState.audioPlayer.sequenceStateStream,
          builder: (context, index) {
          
            return IconButton(
              onPressed:
              (){
                  SongScreenState.audioPlayer.hasPrevious ? SongScreenState.audioPlayer.seekToPrevious() : null;
                 var indexPrevious=SongScreenState.audioPlayer.currentIndex!-1;
                  if(indexPrevious>=0) {
                    ref.read(songSelect.notifier).state=ref.watch(playlistSelect)['songs'][indexPrevious];
                  }
                  if(SongScreenState.audioPlayer.shuffleModeEnabled){
                           var currentIndex=SongScreenState.audioPlayer.currentIndex??0;
                      var indexOfNext = SongScreenState.audioPlayer.effectiveIndices?.indexOf(currentIndex);
                      var prevElement=indexOfNext!-1;
                     if(prevElement>=0){ prevElement= SongScreenState.audioPlayer.effectiveIndices![prevElement];
                      log("nrxt indice is ${prevElement}");
                    ref.read(songSelect.notifier).state=ref.watch(playlistSelect)['songs'][prevElement];
                     }
                  }
                   },
             iconSize: 45,
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
            );
          },
        ),
        StreamBuilder<PlayerState>(
            stream: SongScreenState.audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playerState = snapshot.data;
                final processingState = playerState!.processingState;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    width: 64.0,
                    height: 64.0,
                    margin: const EdgeInsets.all(10.0),
                    child: const CircularProgressIndicator(),
                  );
                } else if (!SongScreenState.audioPlayer.playing) {
                  return IconButton(
                    onPressed: SongScreenState.audioPlayer.play,
                    iconSize: 75,
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    ),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: SongScreenState.audioPlayer.pause,
                    iconSize: 75,
                    icon: const Icon(
                      Icons.pause_circle,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () => SongScreenState.audioPlayer.seek(Duration.zero,
                        index: SongScreenState.audioPlayer.effectiveIndices!.first),
                    iconSize: 75,
                    icon: const Icon(
                      Icons.replay_circle_filled_outlined,
                      color: Colors.white,
                    ),
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            }),
            StreamBuilder<SequenceState?>(
          stream: SongScreenState.audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed:() {
                SongScreenState.audioPlayer.hasNext ? SongScreenState.audioPlayer.seekToNext() : null;
                if(SongScreenState.audioPlayer.hasNext) {
                   
                    log("the indice is ${SongScreenState.audioPlayer.effectiveIndices}");
                    
                        var currentIndex=SongScreenState.audioPlayer.currentIndex??0;
                      var indexOfNext = SongScreenState.audioPlayer.effectiveIndices?.indexOf(currentIndex);
                      var nextElement=indexOfNext!+1;
                      nextElement= SongScreenState.audioPlayer.effectiveIndices![nextElement];
                      log("nrxt indice is ${nextElement}");
                    ref.read(songSelect.notifier).state=ref.watch(playlistSelect)['songs'][nextElement];
                  //ref.read(songSelect.notifier).state=ref.watch(playlistSelect).songs[SongScreenState.audioPlayer.currentIndex!+1];
                }
              
              },
                  
             iconSize: 45,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}
