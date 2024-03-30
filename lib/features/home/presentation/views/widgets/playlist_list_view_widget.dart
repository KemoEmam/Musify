import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musicfy/core/utils/app_routes.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/home/presentation/manager/fetch_all_songs_cubit/fetch_all_songs_cubit.dart';
import 'package:musicfy/features/home/presentation/views/widgets/playlist_card_item_widget.dart';
import 'package:musicfy/features/song/presentation/manager/pause_resume_cubit/pause_resume_cubit.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistListViewWidget extends StatelessWidget {
  const PlaylistListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllSongsCubit, FetchAllSongsState>(
      builder: (context, state) {
        if (state is FetchAllSongsSuccess) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    BlocProvider.of<PauseResumeCubit>(context).playSong(
                        SongDetailsModel(
                            songs: state.songs, selectedIndex: index));

                    GoRouter.of(context).push(AppRoutes.songRoute,
                        extra: SongDetailsModel(
                            songs: state.songs, selectedIndex: index));
                  },
                  child: PlaylistCardItemWidget(
                    type: ArtworkType.AUDIO,
                    id: state.songs[index].id,
                    songName: state.songs[index].title,
                    artistName: state.songs[index].artist ?? 'Unknown Artist',
                  ),
                );
              });
        } else if (state is FetchAllSongsFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errMessage),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<FetchAllSongsCubit>(context)
                        .fetchAllSongs();
                  },
                  child: Text('Retry',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
