import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:musicfy/core/utils/audio_player_service.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';

part 'pause_resume_state.dart';

class PauseResumeCubit extends Cubit<PauseResumeState> {
  PauseResumeCubit() : super(PauseResumeInitial());
  final AudioPlayerService _audioPlayerService =
      GetIt.instance<AudioPlayerService>();

  void togglePlayPause(SongDetailsModel songDetails) async {
    if (_audioPlayerService.isPlaying) {
      await _audioPlayerService.pause();
      emit(PauseResumePaused());
    } else {
      await _audioPlayerService.resume();
      emit(PauseResumePlaying());
    }
  }

  void nextSong(SongDetailsModel songDetails) async {
    await _audioPlayerService.updateSongDetails(songDetails);
    await _audioPlayerService.nextSong();
    emit(PauseResumePlaying());
  }

  void previousSong(SongDetailsModel songDetails) async {
    await _audioPlayerService.updateSongDetails(songDetails);
    await _audioPlayerService.previousSong();
    emit(PauseResumePlaying());
  }

  void playSong(SongDetailsModel songDetails) async {
    await _audioPlayerService.updateSongDetails(songDetails);
    await _audioPlayerService
        .play(songDetails.songs[songDetails.selectedIndex].data);
    emit(PauseResumePlaying());
  }

  void initialize(SongDetailsModel songDetails) async {
    if (_audioPlayerService.isPlaying) {
      emit(PauseResumePlaying());
    } else {
      emit(PauseResumePaused());
    }
  }
}
