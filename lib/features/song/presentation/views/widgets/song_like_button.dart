import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:musicfy/features/song/presentation/manager/update_song_details_cubit/update_song_details_cubit.dart';

class SongLikeButton extends StatelessWidget {
  const SongLikeButton(
      {super.key, required this.isLiked, required this.currentIndex});
  final bool isLiked;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateSongDetailsCubit, UpdateSongDetailsState>(
      builder: (context, state) {
        return LikeButton(
          size: 30,
          isLiked: isLiked,
          onTap: (bool isLiked) async {
            context.read<UpdateSongDetailsCubit>().toggleSongLike(currentIndex);
            return !isLiked;
          },
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked
                  ? const Color.fromARGB(255, 248, 37, 118)
                  : Colors.grey,
              size: 32,
            );
          },
        );
      },
    );
  }
}
