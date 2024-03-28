part of 'song_slider_cubit.dart';

@immutable
sealed class SongSliderState {}

final class SongSliderInitial extends SongSliderState {}

class SongSliderLoading extends SongSliderState {}

class SongSliderSuccess extends SongSliderState {
  final Duration currentDuration;
  final Duration totalDuration;
  final bool isRepeatOn;

  SongSliderSuccess(this.currentDuration, this.totalDuration, this.isRepeatOn);
}

class SongSliderFailure extends SongSliderState {
  final String message;

  SongSliderFailure(this.message);
}
