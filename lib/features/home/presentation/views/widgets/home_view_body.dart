import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/features/home/presentation/manager/fetch_all_songs_cubit/fetch_all_songs_cubit.dart';
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
        body: RefreshIndicator(
          onRefresh: () async {
            await BlocProvider.of<FetchAllSongsCubit>(context).fetchAllSongs();
          },
          child: const PlaylistListViewWidget(),
        ),
      ),
    );
  }
}
