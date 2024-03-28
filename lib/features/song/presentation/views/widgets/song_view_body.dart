import 'package:flutter/material.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/song/presentation/views/widgets/playback_actions_widget.dart';
import 'package:musicfy/features/song/presentation/views/widgets/song_slide_bar_widget.dart';
import 'package:musicfy/features/song/presentation/views/widgets/songs_app_bar_widget.dart';
import 'package:musicfy/features/song/presentation/views/widgets/songs_item_widget.dart';

class SongViewBody extends StatelessWidget {
  const SongViewBody({
    super.key,
    required this.sonngDetails,
  });

  final SongDetailsModel sonngDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SongsAppBarWidget(),
        SongsItemWidget(
          songDetails: sonngDetails,
        ),
        const SongSlideBarWidget(),
        PlaybackActionsWidget(
          songDetails: sonngDetails,
        )
      ],
    );
  }
}
