import 'package:flutter/material.dart';
import 'package:music_app/router.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ElevatedButton(onPressed: (){
        router.navigateTo(context,'/');
      }, child: Text('go home'))
       );
  }
}