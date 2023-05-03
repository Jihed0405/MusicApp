
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../models/song_model.dart';
import '../widgets/player_buttons.dart';
import '../widgets/seekbar.dart';

class SongScreen extends StatefulWidget {
 

  
  const SongScreen( {super.key, 
  });
  

  @override
  State<SongScreen> createState() => SongScreenState();
}

class SongScreenState extends State<SongScreen> {

  Song song =Get.arguments ?? Song.songs[0];
 static AudioPlayer audioPlayer = AudioPlayer();
  


  
  @override
   void initState()  {
    super.initState();
   
  }

  @override
  void dispose() {
   // SongScreenState.audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          SongScreenState.audioPlayer.positionStream, SongScreenState.audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position,
          duration ?? Duration.zero,
        );
      });

  @override
  Widget build(BuildContext context) {
    
    return Container(decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 28, 70, 117).withOpacity(0.8),
            Color.fromARGB(255, 104, 115, 121).withOpacity(0.8),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
       
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    song.coverUrl,
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 1,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1 ,),
            _MusicPlayer(
                song: song,
                audioPlayer: SongScreenState.audioPlayer, 
                seekBarDataStream: _seekBarDataStream)
            ],
          ),
          
          
        ),
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  const _MusicPlayer({
    super.key,
    required this.song,
    required this.audioPlayer,
    required Stream<SeekBarData> seekBarDataStream,
  }) : _seekBarDataStream = seekBarDataStream;
  final Song song;
  final AudioPlayer audioPlayer;
  final Stream<SeekBarData> _seekBarDataStream;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0, 
      vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(song.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          ),
          const SizedBox(height: 10,),
          Text(song.description,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.white,
            
          ),
          ),
          const SizedBox(height: 30),
          StreamBuilder<SeekBarData>(
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChangeEnd: audioPlayer.seek,
              );
            },
            stream: _seekBarDataStream,
          ),
          PlayerButtons(audioPlayer: audioPlayer),
          
        ],
      ),
    );
  }
}




