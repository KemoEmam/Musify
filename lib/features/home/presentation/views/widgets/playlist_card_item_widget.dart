import 'package:flutter/material.dart';
import 'package:musicfy/core/utils/styles.dart';

import 'package:on_audio_query/on_audio_query.dart';

class PlaylistCardItemWidget extends StatelessWidget {
  const PlaylistCardItemWidget(
      {super.key,
      required this.songName,
      required this.artistName,
      required this.id,
      required this.type});

  final String songName;
  final String artistName;
  final int id;
  final ArtworkType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Row(
        children: [
          QueryArtworkWidget(
              id: id,
              type: type,
              nullArtworkWidget: const Icon(Icons.music_note, size: 50)),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(songName,
                    style: Styles.textStyle16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
              Opacity(
                opacity: 0.4,
                child: Text(artistName, style: Styles.textStyle14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
