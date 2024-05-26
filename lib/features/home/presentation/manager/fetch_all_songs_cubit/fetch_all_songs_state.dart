part of 'fetch_all_songs_cubit.dart';

@immutable
sealed class FetchAllSongsState {}

final class FetchAllSongsInitial extends FetchAllSongsState {}

final class FetchAllSongsSuccess extends FetchAllSongsState {
  final List<SongModel> songs;

  FetchAllSongsSuccess(this.songs);
}

final class FetchAllSongsFailure extends FetchAllSongsState {
  final String errMessage;

  FetchAllSongsFailure({required this.errMessage});
}

final class FetchAllSongsLoading extends FetchAllSongsState {}

final class FetchAllSongsPermissionDenied extends FetchAllSongsState {
  final String errMessage;

  FetchAllSongsPermissionDenied({required this.errMessage});
}
