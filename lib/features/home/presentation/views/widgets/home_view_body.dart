import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musicfy/core/utils/app_routes.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/home/presentation/manager/fetch_all_songs_cubit/fetch_all_songs_cubit.dart';
import 'package:musicfy/features/home/presentation/views/widgets/home_app_bar_widget.dart';
import 'package:musicfy/features/home/presentation/views/widgets/mini_player.dart';
import 'package:musicfy/features/home/presentation/views/widgets/playlist_list_view_widget.dart';
import 'package:musicfy/features/song/presentation/manager/song_slider_cubit/song_slider_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongSliderCubit(),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await BlocProvider.of<FetchAllSongsCubit>(context).fetchAllSongs();
          },
          child: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    const SliverToBoxAdapter(
                      child: HomeAppBarWidget(),
                    ),
                  ];
                },
                body: BlocBuilder<FetchAllSongsCubit, FetchAllSongsState>(
                  builder: (context, state) {
                    if (state is FetchAllSongsSuccess) {
                      return PlaylistListViewWidget(
                        songs: state.songs,
                      );
                    } else if (state is FetchAllSongsPermissionDenied) {
                      return _buildErrorState(
                        context,
                        state.errMessage,
                        () => BlocProvider.of<FetchAllSongsCubit>(context)
                            .fetchAllSongs(),
                      );
                    } else if (state is FetchAllSongsFailure) {
                      return _buildErrorState(
                        context,
                        state.errMessage,
                        () => BlocProvider.of<FetchAllSongsCubit>(context)
                            .chooseDefaultSongsPath(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              BlocBuilder<FetchAllSongsCubit, FetchAllSongsState>(
                builder: (context, state) {
                  if (state is FetchAllSongsSuccess) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRoutes.songRouteFromMiniPlayer,
                            extra: SongDetailsModel(
                                songs: state.songs, selectedIndex: 0),
                          );
                        },
                        child: const MiniPlayer(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(
      BuildContext context, String message, VoidCallback retry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: retry,
            child: Text('Retry',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary)),
          ),
        ],
      ),
    );
  }
}
