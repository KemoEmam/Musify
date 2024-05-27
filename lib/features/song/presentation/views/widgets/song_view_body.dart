import 'package:flutter/material.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/song/presentation/views/widgets/playback_actions_widget.dart';
import 'package:musicfy/features/song/presentation/views/widgets/song_slide_bar_widget.dart';
import 'package:musicfy/features/song/presentation/views/widgets/songs_app_bar_widget.dart';
import 'package:musicfy/features/song/presentation/views/widgets/songs_item_widget.dart';

class SongViewBody extends StatelessWidget {
  const SongViewBody({
    super.key,
    required this.songDetails,
  });

  final SongDetailsModel songDetails;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            const SongsAppBarWidget(),
            SongsItemWidget(
              songDetails: songDetails,
            ),
            const SizedBox(height: 20), // Added spacing
            const SongSlideBarWidget(),
            PlaybackActionsWidget(
              songDetails: songDetails,
            ),
          ],
        ),
      ),
    );
  }
}
