import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicfy/features/settings/presentation/manager/dark_light_cubit/dark_light_cubit.dart';

class ThemeUtils {
  static void setStatusBarStyleForTheme(DarkLightState state) {
    if (state is DarkThemeState) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    } else if (state is LightThemeState) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }
}
