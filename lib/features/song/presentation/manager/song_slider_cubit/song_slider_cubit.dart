import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:musicfy/core/utils/audio_player_service.dart';
part 'song_slider_state.dart';

class SongSliderCubit extends Cubit<SongSliderState> {
  final AudioPlayerService _audioPlayerService =
      GetIt.instance<AudioPlayerService>();
  bool _isRepeatOn = false;

  SongSliderCubit() : super(SongSliderInitial()) {
    _init();
  }

  void _init() {
    _audioPlayerService.addListener(_onAudioPlayerChange);
    _onAudioPlayerChange();
  }

  void _onAudioPlayerChange() {
    emit(SongSliderSuccess(_audioPlayerService.currentDuration,
        _audioPlayerService.totalDuration, _isRepeatOn));
  }

  void seek(double seconds) {
    _audioPlayerService.seek(Duration(seconds: seconds.toInt()));
  }

  void toggleRepeat() {
    _isRepeatOn = !_isRepeatOn;
    if (_isRepeatOn) {
      _audioPlayerService.setRepeatMode(true);
    } else {
      _audioPlayerService.setRepeatMode(false);
    }
  }

  @override
  Future<void> close() {
    _audioPlayerService.removeListener(_onAudioPlayerChange);
    return super.close();
  }
}
