
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:music_app/main.dart';
import 'package:music_app/pages/favourite.dart';
import 'package:music_app/pages/home.dart';
final router = FluroRouter();
var usersHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return Favourite();
});
  var homeHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return Home();
});
  var mainHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return MyApp();
});

void setupRouter(FluroRouter router) {
  router.define("/", handler: mainHandler);
  router.define("/favourite", handler: usersHandler);
   router.define("/home", handler: homeHandler);
  }

