import 'package:flutter/material.dart';
import 'package:musicfy/features/song/presentation/views/widgets/favourites_app_bar.dart';
import 'package:musicfy/features/song/presentation/views/widgets/favourites_list_view.dart';

class FavouritesSongViewBody extends StatelessWidget {
  const FavouritesSongViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverToBoxAdapter(
              child: FavouritesAppBar(),
            ),
          ];
        },
        body: const FavouritesListView(),
      ),
    );
  }
}
