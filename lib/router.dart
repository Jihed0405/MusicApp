
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:music_app/main.dart';
import 'package:music_app/pages/playlist_screen.dart';
import 'package:music_app/pages/song_screen.dart';
import 'package:music_app/pages/home.dart';
final router = FluroRouter();
var songHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return SongScreen();
});
  var homeHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return Home();
});
  var mainHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return MyApp();
});

  var playListHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return PlaylistScreen();
});
void setupRouter(FluroRouter router) {
  router.define("/", handler: mainHandler);
  router.define("/song", handler: songHandler);
   router.define("/home", handler: homeHandler);
     router.define("/playlist", handler: playListHandler);
  }

