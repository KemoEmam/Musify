part of 'dark_light_cubit.dart';

@immutable
sealed class DarkLightState {}

final class DarkLightInitial extends DarkLightState {}

final class LightThemeState extends DarkLightState {}

final class DarkThemeState extends DarkLightState {}
