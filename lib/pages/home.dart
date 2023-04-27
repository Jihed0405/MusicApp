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
      decoration:BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.lightBlue.shade800.withOpacity(0.8),
            Colors.lightBlue.shade200.withOpacity(0.8),
        ])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:const _CustomAppbar(),
        bottomNavigationBar:  const _CustomNavBar(),
        body:Container(),
      ),
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.lightBlue.shade200,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels:false,
      items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline),
        label: 'favorites',
      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.play_circle_outline),
        label: 'Play',
      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.people_outline),
        label: 'Profile',
      )
      
    ]);
  }
}

class _CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:16.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon (Icons.grid_view_rounded),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
              ),
            ),)
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}