import 'package:flutter/material.dart';
import 'package:music_app/router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: (){
        router.navigateTo(context,  "/favourite");
      }, child: Text("go favourite")),
    );
  }
}