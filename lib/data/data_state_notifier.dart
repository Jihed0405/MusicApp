

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/playlist_model.dart';

import '../models/song_model.dart';

final songSelect = StateProvider((ref) {
  return <String, dynamic>{};/*  Song(title: 'Easy on me', description: 'Easy on me',
      singer: 'Adele',
       url:'assets/music/Adele - Easy On Me.mp3',
        coverUrl: 'https://i3.ytimg.com/vi/9MogWz-LHXI/maxresdefault.jpg'); */
});
final playlistSelect = StateProvider((ref) {
  return    <String, dynamic>{}; 
  //Playlist.playlists[0];
});
final isPlaying = StateProvider<bool>((ref)=>false);
final docSelectedId = StateProvider<String>((ref)=>'');
final songsOfList = StateProvider((ref) {
  return   List<DocumentSnapshot<Object?>>;
  //Playlist.playlists[0];
});

