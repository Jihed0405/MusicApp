import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:music_app/data/data_state_notifier.dart';

import '../models/song_model.dart';


 class SongCard extends ConsumerStatefulWidget {
 const SongCard({
  Key? key ,
    
    required this.song, 
  }):super(key: key);
 
  final Song song;

  @override
  ConsumerState<SongCard> createState() => SongCardState();
}

class SongCardState extends ConsumerState<SongCard> {



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Get.toNamed('/song', arguments: widget.song);
        ref.read(songSelect.notifier).state=widget.song;
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.46,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.song.coverUrl,
                    ),
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.38,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.song.title,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          widget.song.description,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                        )
                      ]),
                  Icon(
                    Icons.play_circle,
                    color: Colors.lightBlue.shade800,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
