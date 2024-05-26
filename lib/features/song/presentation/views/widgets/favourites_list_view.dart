import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/home/presentation/views/widgets/playlist_card_item_widget.dart';
import 'package:musicfy/features/song/presentation/manager/pause_resume_cubit/pause_resume_cubit.dart';
import 'package:musicfy/features/song/presentation/manager/update_song_details_cubit/update_song_details_cubit.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouritesListView extends StatelessWidget {
  const FavouritesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final likedSongs = context.read<UpdateSongDetailsCubit>().getLikedSongs();
    final currentState = context.read<UpdateSongDetailsCubit>().state;
    List<SongModel> fullSongList = [];
    if (currentState is UpdateSongDetailsSuccess) {
      fullSongList = currentState.songDetails.songs;
    }
    return likedSongs.isEmpty
        ? const Center(
            child: Opacity(
              opacity: .3,
              child: Text(
                'Your favourite songs will be added here',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        : ListView.builder(
            itemCount: likedSongs.length,
            itemBuilder: (context, index) {
              final song = likedSongs[index];
              return GestureDetector(
                onTap: () async {
                  final originalIndex = fullSongList.indexOf(song);
                  if (originalIndex != -1) {
                    BlocProvider.of<PauseResumeCubit>(context).playSong(
                        SongDetailsModel(
                            songs: fullSongList, selectedIndex: originalIndex));

                    Navigator.pop(context);
                  }
                },
                child: PlaylistCardItemWidget(
                  type: ArtworkType.AUDIO,
                  id: song.id,
                  songName: song.title,
                  artistName: song.artist ?? 'Unknown Artist',
                ),
              );
            },
          );
  }
}
