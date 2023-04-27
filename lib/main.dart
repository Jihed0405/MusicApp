import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:music_app/pages/home.dart';
import 'package:music_app/router.dart';
import 'package:music_app/router.dart';
import 'package:flutter/services.dart';
void main() {
    setupRouter(router);
  runApp(
  
     const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const Home(),
    );
  }
}
