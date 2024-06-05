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

          return FutureBuilder<ImageProvider?>(
            future: ArtworkCache.getArtwork(
              currentSongDetails.songs[currentIndex].id,
              ArtworkType.AUDIO,
            ),
            builder: (context, snapshot) {
              final artworkImage = snapshot.data;

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.83,
                child: NeuBoxWidget(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: artworkImage != null
                                ? DecorationImage(
                                    image: artworkImage,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: artworkImage == null
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Icon(Icons.music_note, size: 250),
                                )
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      currentSongDetails
                                          .songs[currentIndex].title
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
                                              .songs[currentIndex].artist ??
                                          'Unknown Artist',
                                      style: Styles.textStyle14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SongLikeButton(
                              songDetails: currentSongDetails,
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
            },
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

class ArtworkCache {
  static final Map<int, ImageProvider> _artworkCache = {};
  static final OnAudioQuery _audioQuery = OnAudioQuery();

  static Future<ImageProvider?> getArtwork(int id, ArtworkType type) async {
    if (!_artworkCache.containsKey(id)) {
      var artwork = await _audioQuery.queryArtwork(id, type);
      if (artwork != null) {
        _artworkCache[id] = MemoryImage(artwork);
      }
    }
    return _artworkCache[id];
  }
}
