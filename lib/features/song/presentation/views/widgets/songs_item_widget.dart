import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/core/utils/styles.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/song/presentation/manager/update_song_details_cubit/update_song_details_cubit.dart';
import 'package:musicfy/features/song/presentation/views/widgets/neu_box_widget.dart';
import 'package:musicfy/features/song/presentation/views/widgets/song_like_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsItemWidget extends StatelessWidget {
  const SongsItemWidget({super.key, required this.songDetails});
  final SongDetailsModel songDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateSongDetailsCubit, UpdateSongDetailsState>(
      builder: (context, state) {
        if (state is UpdateSongDetailsSuccess) {
          final currentSongDetails = state.songDetails;
          final currentIndex = currentSongDetails.selectedIndex;
          final isLiked =
              context.read<UpdateSongDetailsCubit>().isSongLiked(currentIndex);
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.83,
            child: NeuBoxWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QueryArtworkWidget(
                    artworkHeight: MediaQuery.of(context).size.height * 0.35,
                    format: ArtworkFormat.PNG,
                    artworkWidth: double.infinity,
                    artworkQuality: FilterQuality.high,
                    artworkBorder: BorderRadius.circular(12),
                    id: currentSongDetails
                        .songs[currentSongDetails.selectedIndex].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Icon(Icons.music_note, size: 250),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 4, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                currentSongDetails
                                    .songs[currentSongDetails.selectedIndex]
                                    .title
                                    .toString(),
                                style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.4,
                              child: Text(
                                currentSongDetails
                                        .songs[currentSongDetails.selectedIndex]
                                        .artist ??
                                    'Unknown Artist',
                                style: Styles.textStyle14,
                              ),
                            ),
                          ],
                        ),
                        SongLikeButton(
                          isLiked: isLiked,
                          currentIndex: currentIndex,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is UpdateSongDetailsFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
