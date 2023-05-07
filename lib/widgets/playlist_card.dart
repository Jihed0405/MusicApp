import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:music_app/data/data_state_notifier.dart';

import '../models/playlist_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaylistCard extends ConsumerStatefulWidget {
  const PlaylistCard({
    super.key,
    required this.playlist, required  this.id,
  });
final id;
  final  playlist;
 @override
  ConsumerState<PlaylistCard> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          ref.read(docSelectedId.notifier).state=widget.id;
        ref.read(playlistSelect.notifier).state=widget.playlist;
          Get.toNamed('/playlist', arguments: widget.playlist);
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Color.fromARGB(255, 114, 132, 165).withOpacity(0.6),
        borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child:CachedNetworkImage(imageUrl: widget.playlist['imageUrl'],
              height: 50,width: 50,
              fit: BoxFit.cover,),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                    widget.playlist['title'],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                  ),
                   Text(
                    '${widget.playlist['songs'].length} songs',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall,                     ),
                 ], 
              ),
            ),
            IconButton(onPressed: (){}, icon: const Icon(
              Icons.play_circle,color: Colors.white,
            ))
          ],
        ),
      ),
    );
  }
}
