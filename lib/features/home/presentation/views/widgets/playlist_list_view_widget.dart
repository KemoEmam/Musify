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
  final List<SongModel> songs;
  const PlaylistListViewWidget({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<FetchAllSongsCubit>(context).fetchAllSongs();
      },
      child: SizedBox(
        height:
            MediaQuery.of(context).size.height, // Adjust the height as needed
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: songs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                BlocProvider.of<PauseResumeCubit>(context).playSong(
                  SongDetailsModel(songs: songs, selectedIndex: index),
                );

                GoRouter.of(context).push(
                  AppRoutes.songRoute,
                  extra: SongDetailsModel(songs: songs, selectedIndex: index),
                );
              },
              child: PlaylistCardItemWidget(
                type: ArtworkType.AUDIO,
                id: songs[index].id,
                songName: songs[index].title,
                artistName: songs[index].artist ?? 'Unknown Artist',
              ),
            );
          },
        ),
      ),
    );
  }
}
