

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/song_model.dart';

final songSelect = StateProvider((ref) {
  return  Song(title: 'Easy on me', description: 'Easy on me',
      singer: 'Adele',
       url:'assets/music/Adele - Easy On Me.mp3',
        coverUrl: 'assets/images/Adele - Easy On Me.jpg');
});

