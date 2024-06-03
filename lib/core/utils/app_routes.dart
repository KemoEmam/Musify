import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicfy/features/home/presentation/views/home_view.dart';
import 'package:musicfy/features/settings/presentation/views/settings_view.dart';
import 'package:musicfy/features/song/presentation/views/favourites_song_view.dart';
import 'package:musicfy/features/song/presentation/views/song_view.dart';
import 'package:musicfy/features/splash/presentation/views/splash_view.dart';

abstract class AppRoutes {
  static const splashRoute = '/';
  static const homeRoute = '/home';
  static const settingsRoute = '/settings';
  static const songRoute = '/song';
  static const songRouteFromMiniPlayer = '/songFromMiniPlayer';
  static const favouritesRoute = '/favourites';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: splashRoute,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const SplashView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
      GoRoute(
        path: homeRoute,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const HomeView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          );
        },
      ),
      GoRoute(
        path: songRoute,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: SongView(
                // songDetails: state.extra as SongDetailsModel,
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          );
        },
      ),
      GoRoute(
        path: songRouteFromMiniPlayer,
        pageBuilder: (context, state) {
          return SlideFromBottomPageRoute<void>(
            page: SongView(
                // songDetails: state.extra as SongDetailsModel,
                ),
          );
        },
      ),
      GoRoute(
        path: settingsRoute,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const SettingsView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          );
        },
      ),
      GoRoute(
        path: favouritesRoute,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const FavouritesSongView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          );
        },
      ),
    ],
  );
}

class SlideFromBottomPageRoute<T> extends CustomTransitionPage<T> {
  final Widget page;

  SlideFromBottomPageRoute({required this.page})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          child: page,
        );
}
