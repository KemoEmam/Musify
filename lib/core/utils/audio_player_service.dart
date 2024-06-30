import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerService {
  List<SongModel> _songs = [];
  int _currentIndex = 0;
  bool isPlaying = false;
  SongDetailsModel? songDetails;

  static const MethodChannel _channel =
      MethodChannel('com.karimelemam.musicfy.audioplayer/audiofocus');

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _totalDuration = Duration.zero;
  Duration _currentDuration = Duration.zero;
  bool _isRepeatOn = false;

  int get currentIndex => _currentIndex;
  Duration get totalDuration => _totalDuration;
  Duration get currentDuration => _currentDuration;
  PlayerState get audioPlayerState => _audioPlayer.state;

  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;

  AudioPlayerService._internal() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      _notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      _notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isRepeatOn) {
        playFromPlaylist(_currentIndex);
      } else {
        nextSong();
      }
      _notifyListeners();
    });
  }

  Future<SongDetailsModel> updateSongDetails(
      SongDetailsModel newSongDetails) async {
    try {
      songDetails = newSongDetails;
      _songs = newSongDetails.songs;
      _currentIndex = newSongDetails.selectedIndex;
      _notifyListeners();
    } catch (e) {
      rethrow;
    }
    return songDetails!;
  }

  Future<void> playFromPlaylist(int index) async {
    if (index < 0 || index >= _songs.length) {
      return;
    }
    _currentIndex = index;
    songDetails!.selectedIndex = _currentIndex;
    await play(_songs[index].data);
    isPlaying = true;
  }

  Future<void> play(String filePath) async {
    final bool focusGranted = await _channel.invokeMethod('requestAudioFocus');
    if (focusGranted) {
      await _audioPlayer.stop();
      await _audioPlayer.play(DeviceFileSource(filePath));
      isPlaying = true;
      _notifyListeners();
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    isPlaying = false;
    _notifyListeners();
    await _channel.invokeMethod('abandonAudioFocus');
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
    isPlaying = true;
    _notifyListeners();
  }

  void pauseResume() {
    if (_audioPlayer.state == PlayerState.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  Future<void> nextSong() async {
    if (_currentIndex + 1 < _songs.length) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    songDetails!.selectedIndex = _currentIndex;
    await playFromPlaylist(_currentIndex);
    _notifyListeners();
  }

  Future<void> previousSong() async {
    if (_currentIndex - 1 >= 0) {
      _currentIndex--;
    } else {
      _currentIndex = _songs.length - 1;
    }
    songDetails!.selectedIndex = _currentIndex;
    await playFromPlaylist(_currentIndex);
    _notifyListeners();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void toggleRepeat() {
    _isRepeatOn = !_isRepeatOn;
    _notifyListeners();
  }

  void setRepeatMode(bool repeat) {
    _isRepeatOn = repeat;
    _notifyListeners();
  }

  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
