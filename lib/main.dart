import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/core/themes/dark_theme.dart';
import 'package:musicfy/core/themes/light_theme.dart';
import 'package:musicfy/core/utils/app_routes.dart';
import 'package:musicfy/core/utils/service_locator.dart';
import 'package:musicfy/features/home/data/repos/home_repo_impl.dart';
import 'package:musicfy/features/home/presentation/manager/fetch_all_songs_cubit/fetch_all_songs_cubit.dart';
import 'package:musicfy/features/settings/presentation/manager/dark_light_cubit/dark_light_cubit.dart';
import 'package:musicfy/features/song/presentation/manager/pause_resume_cubit/pause_resume_cubit.dart';
import 'package:musicfy/features/song/presentation/manager/song_slider_cubit/song_slider_cubit.dart';
import 'package:musicfy/features/song/presentation/manager/update_song_details_cubit/update_song_details_cubit.dart';
import 'package:musicfy/core/themes/theme_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final darkLightCubit = DarkLightCubit();
  await darkLightCubit.initializeTheme();
  runApp(Musicfy(darkLightCubit: darkLightCubit));
  serviceLocator();
}

class Musicfy extends StatelessWidget {
  const Musicfy({super.key, required this.darkLightCubit});
  final DarkLightCubit darkLightCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: darkLightCubit),
        BlocProvider(
          create: (context) =>
              FetchAllSongsCubit(HomeRepoImpl())..fetchAllSongs(),
        ),
        BlocProvider(create: (context) => SongSliderCubit()),
        BlocProvider(create: (context) => UpdateSongDetailsCubit()),
        BlocProvider(create: (context) => PauseResumeCubit()),
      ],
      child: BlocListener<DarkLightCubit, DarkLightState>(
        listener: (context, state) {
          ThemeUtils.setStatusBarStyleForTheme(state);
        },
        child: BlocBuilder<DarkLightCubit, DarkLightState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRoutes.router,
              theme: state is LightThemeState ? lightMode : darkMode,
            );
          },
        ),
      ),
    );
  }
}
