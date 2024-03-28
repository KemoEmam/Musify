part of 'update_song_details_cubit.dart';

@immutable
sealed class UpdateSongDetailsState {}

class UpdateSongDetailsInitial extends UpdateSongDetailsState {}

class UpdateSongDetailsLoading extends UpdateSongDetailsState {}

class UpdateSongDetailsSuccess extends UpdateSongDetailsState {
  final SongDetailsModel songDetails;
  final int currentIndex;
  final bool isPlaying;

  UpdateSongDetailsSuccess({
    required this.songDetails,
    required this.currentIndex,
    required this.isPlaying,
  });
}

class UpdateSongDetailsFailure extends UpdateSongDetailsState {
  final String errMessage;

  UpdateSongDetailsFailure(this.errMessage);
}
