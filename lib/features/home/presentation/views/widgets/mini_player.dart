import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.background, // Background color
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
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
                QueryArtworkWidget(
                  id: songId,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note, size: 50),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songDetails.songs[updateState.currentIndex].title
                            .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground.withOpacity(.8),
                        ),
                      ),
                      Text(
                        songDetails.songs[updateState.currentIndex].artist ??
                            'Unknown Artist',
                        style: TextStyle(
                          color: theme.colorScheme.onBackground.withOpacity(.3),
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
                BlocBuilder<SongSliderCubit, SongSliderState>(
                  builder: (context, sliderState) {
                    if (sliderState is SongSliderSuccess) {
                      final durationInSeconds =
                          sliderState.totalDuration.inSeconds.toDouble();
                      final positionInSeconds =
                          sliderState.currentDuration.inSeconds.toDouble();
                      final progress = positionInSeconds / durationInSeconds;

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            backgroundColor:
                                colorScheme.onBackground.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.teal),
                          ),
                          BlocBuilder<PauseResumeCubit, PauseResumeState>(
                            builder: (context, pauseState) {
                              return IconButton(
                                icon: Icon(
                                  pauseState is PauseResumePlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: colorScheme.inversePrimary
                                      .withOpacity(.8),
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
                            value: 0.0, // Initial progress value
                            backgroundColor:
                                colorScheme.onBackground.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.teal),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              color: colorScheme.inversePrimary.withOpacity(.8),
                            ),
                            onPressed: () {
                              context
                                  .read<PauseResumeCubit>()
                                  .togglePlayPause(songDetails);
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
