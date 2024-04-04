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
  static const favouritesRoute = '/favourites';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
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
        path: '/home',
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
        path: '/song',
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const SongView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          );
        },
      ),
      GoRoute(
        path: '/settings',
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
        path: '/favourites',
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
