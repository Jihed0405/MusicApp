import 'package:flutter/material.dart';
import 'package:music_app/router.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ElevatedButton(onPressed: (){
        router.navigateTo(context,'/');
      }, child: Text('go home'))
       );
  }
}