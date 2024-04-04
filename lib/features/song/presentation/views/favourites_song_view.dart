import 'package:flutter/material.dart';
import 'package:musicfy/features/song/presentation/views/widgets/favourites_song_view_body.dart';

class FavouritesSongView extends StatelessWidget {
  const FavouritesSongView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavouritesSongViewBody(),
    );
  }
}
