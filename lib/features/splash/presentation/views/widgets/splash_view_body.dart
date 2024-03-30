import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:musicfy/core/themes/theme_utils.dart';
import 'package:musicfy/core/utils/app_routes.dart';
import 'package:musicfy/core/utils/assets.dart';
import 'package:musicfy/features/settings/presentation/manager/dark_light_cubit/dark_light_cubit.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late final DarkLightCubit _darkLightCubit;
  late final StreamSubscription _themeSubscription;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light),
    );
    _splashAnimation();
    _initializeThemeListener();
    _navigateToHome();
  }

  @override
  void dispose() {
    animationController.dispose();
    _themeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: Center(
        child: Lottie.asset(AssetsData.splashScreen),
      ),
    );
  }

  void _splashAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  void _initializeThemeListener() {
    _darkLightCubit = context.read<DarkLightCubit>();
    _themeSubscription = _darkLightCubit.stream.listen((state) {
      ThemeUtils.setStatusBarStyleForTheme(state);
    });
  }

  void _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      GoRouter.of(context).pushReplacement(AppRoutes.homeRoute);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    });
  }
}
