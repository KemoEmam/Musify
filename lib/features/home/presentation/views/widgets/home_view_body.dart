import 'package:flutter/material.dart';
import 'package:musicfy/features/home/presentation/views/widgets/home_app_bar_widget.dart';
import 'package:musicfy/features/home/presentation/views/widgets/playlist_list_view_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverToBoxAdapter(
              child: HomeAppBarWidget(),
            ),
          ];
        },
        body: const PlaylistListViewWidget(),
      ),
    );
  }
}
