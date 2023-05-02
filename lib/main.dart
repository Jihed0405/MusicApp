
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/pages/home.dart';
import 'package:music_app/pages/playlist_screen.dart';
import 'package:music_app/pages/song_screen.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.music_app.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
 runApp(
   
  const ProviderScope(child:  MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return GetMaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home:  Home(),
      getPages: [
        GetPage(name: '/', page: ()=>  Home()),
        GetPage(name: '/song', page: ()=> const SongScreen()),
        GetPage(name: '/playlist', page: ()=> const PlaylistScreen()),
        
      ],
    );
  }
}
