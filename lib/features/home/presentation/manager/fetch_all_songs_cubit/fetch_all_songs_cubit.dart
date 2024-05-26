import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicfy/features/home/data/repos/home_repo.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'fetch_all_songs_state.dart';

class FetchAllSongsCubit extends Cubit<FetchAllSongsState> {
  final HomeRepo homeRepo;

  FetchAllSongsCubit(this.homeRepo) : super(FetchAllSongsInitial());

  Future<void> fetchAllSongs() async {
    emit(FetchAllSongsLoading());
    try {
      final originalList = await homeRepo.fetchAllSongs();
      if (originalList.isNotEmpty) {
        emit(FetchAllSongsSuccess(originalList));
      } else {
        emit(FetchAllSongsFailure(errMessage: 'No songs found on the device.'));
      }
    } catch (e) {
      emit(FetchAllSongsPermissionDenied(
          errMessage: 'Access Denied, tap to grant access.'));
    }
  }

  Future<void> chooseDefaultSongsPath() async {
    final selectedPath = await homeRepo.chooseDefaultSongsPath();
    if (selectedPath != null) {
      final songList = await homeRepo.querySongsFromDirectory(selectedPath);
      if (songList.isNotEmpty) {
        emit(FetchAllSongsSuccess(songList));
      } else {
        emit(FetchAllSongsFailure(
            errMessage:
                'The folder you specified doesn\'t contain songs or is empty.'));
      }
    }
  }
}
