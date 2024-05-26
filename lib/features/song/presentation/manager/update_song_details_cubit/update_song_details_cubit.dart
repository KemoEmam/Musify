import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:musicfy/core/utils/audio_player_service.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_song_details_state.dart';

class UpdateSongDetailsCubit extends Cubit<UpdateSongDetailsState> {
  final AudioPlayerService _audioPlayerService =
      GetIt.instance<AudioPlayerService>();
  final Set<int> _likedSongsIndices = {};

  UpdateSongDetailsCubit() : super(UpdateSongDetailsInitial()) {
    _init();
  }

  void _init() {
    _audioPlayerService.addListener(_onAudioPlayerChange);
    if (_audioPlayerService.songDetails != null) {
      _onAudioPlayerChange();
    }
    _loadLikedSongs();
  }

  Future<void> _saveLikedSongs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'likedSongs', _likedSongsIndices.map((e) => e.toString()).toList());
  }

  Future<void> _loadLikedSongs() async {
    final prefs = await SharedPreferences.getInstance();
    final likedSongs = prefs.getStringList('likedSongs') ?? [];
    _likedSongsIndices.addAll(likedSongs.map((e) => int.parse(e)));
    emit(state); // Re-emit the current state to update the UI
  }

  void _onAudioPlayerChange() {
    final newSongDetails = _audioPlayerService.songDetails;
    final newIndex = _audioPlayerService.currentIndex;
    final newIsPlaying = _audioPlayerService.isPlaying;

    if (state is UpdateSongDetailsSuccess) {
      final currentState = state as UpdateSongDetailsSuccess;
      if (currentState.songDetails != newSongDetails ||
          currentState.currentIndex != newIndex ||
          currentState.isPlaying != newIsPlaying) {
        emit(UpdateSongDetailsSuccess(
          songDetails: newSongDetails!,
          currentIndex: newIndex,
          isPlaying: newIsPlaying,
        ));
      }
    } else {
      emit(UpdateSongDetailsSuccess(
        songDetails: newSongDetails!,
        currentIndex: newIndex,
        isPlaying: newIsPlaying,
      ));
    }
  }

  void toggleSongLike(int songIndex) {
    final currentState = state;
    if (currentState is UpdateSongDetailsSuccess) {
      if (_likedSongsIndices.contains(songIndex)) {
        _likedSongsIndices.remove(songIndex);
      } else {
        _likedSongsIndices.add(songIndex);
      }
      _saveLikedSongs(); // Save liked songs whenever they are toggled
      emit(UpdateSongDetailsSuccess(
        songDetails: currentState.songDetails,
        currentIndex: currentState.currentIndex,
        isPlaying: currentState.isPlaying,
      ));
    }
  }

  List<SongModel> getLikedSongs() {
    if (state is UpdateSongDetailsSuccess) {
      final currentState = state as UpdateSongDetailsSuccess;
      return currentState.songDetails.songs
          .where((song) => _likedSongsIndices
              .contains(currentState.songDetails.songs.indexOf(song)))
          .toList();
    } else {
      return [];
    }
  }

  bool isSongLiked(int songIndex) {
    return _likedSongsIndices.contains(songIndex);
  }

  @override
  Future<void> close() {
    _audioPlayerService.removeListener(_onAudioPlayerChange);
    return super.close();
  }
}
