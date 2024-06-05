import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/song/presentation/manager/pause_resume_cubit/pause_resume_cubit.dart';
import 'package:musicfy/features/song/presentation/manager/song_slider_cubit/song_slider_cubit.dart';
import 'package:musicfy/features/song/presentation/manager/update_song_details_cubit/update_song_details_cubit.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<UpdateSongDetailsCubit, UpdateSongDetailsState>(
      builder: (context, updateState) {
        if (updateState is UpdateSongDetailsSuccess) {
          final songDetails = updateState.songDetails;
          final songId = songDetails.songs[updateState.currentIndex].id;

          return FutureBuilder<ImageProvider?>(
            future: ArtworkCache.getArtwork(songId, ArtworkType.AUDIO),
            builder: (context, snapshot) {
              final artworkImage = snapshot.data;

              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.inversePrimary.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    artworkImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image(
                              image: artworkImage,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Container(
                              width: 50,
                              height: 50,
                              color: theme.colorScheme.background,
                              child: const Icon(Icons.music_note, size: 50),
                            ),
                          ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            songDetails.songs[updateState.currentIndex].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onBackground
                                  .withOpacity(.8),
                            ),
                          ),
                          Text(
                            songDetails
                                    .songs[updateState.currentIndex].artist ??
                                'Unknown Artist',
                            style: TextStyle(
                              color: theme.colorScheme.onBackground
                                  .withOpacity(.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        size: 29,
                        color: colorScheme.inversePrimary.withOpacity(.8),
                      ),
                      onPressed: () {
                        context.read<PauseResumeCubit>().nextSong(songDetails);
                      },
                    ),
                    _buildPlayPauseButton(context, colorScheme, songDetails),
                  ],
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildPlayPauseButton(BuildContext context, ColorScheme colorScheme,
      SongDetailsModel songDetails) {
    return BlocBuilder<SongSliderCubit, SongSliderState>(
      builder: (context, sliderState) {
        if (sliderState is SongSliderSuccess) {
          final durationInSeconds =
              sliderState.totalDuration.inSeconds.toDouble();
          final positionInSeconds =
              sliderState.currentDuration.inSeconds.toDouble();
          final progress = durationInSeconds != 0
              ? positionInSeconds / durationInSeconds
              : 0;
          final safeProgress = progress.isFinite ? progress : 0.0;

          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: safeProgress >= 1.0 ? 1.0 : safeProgress.toDouble(),
                backgroundColor: colorScheme.onBackground.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
              ),
              BlocBuilder<PauseResumeCubit, PauseResumeState>(
                builder: (context, pauseState) {
                  return IconButton(
                    icon: Icon(
                      pauseState is PauseResumePlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: colorScheme.inversePrimary.withOpacity(.8),
                    ),
                    onPressed: () {
                      context
                          .read<PauseResumeCubit>()
                          .togglePlayPause(songDetails);
                    },
                  );
                },
              ),
            ],
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: 0.0,
                backgroundColor: colorScheme.onBackground.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
              ),
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: colorScheme.inversePrimary.withOpacity(.8),
                ),
                onPressed: () {
                  context.read<PauseResumeCubit>().togglePlayPause(songDetails);
                },
              ),
            ],
          );
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
