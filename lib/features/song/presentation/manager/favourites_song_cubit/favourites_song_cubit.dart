// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:musicfy/features/home/data/models/song_details_model.dart';
// import 'package:musicfy/features/home/data/repos/home_repo.dart';
// import 'package:on_audio_query/on_audio_query.dart'; // Ensure this is correctly imported

// part 'favourites_song_state.dart';

// class FavouritesSongCubit extends Cubit<FavouritesSongState> {
//   final HomeRepo homeRepo;

//   FavouritesSongCubit(this.homeRepo) : super(FavouritesSongInitial()) {
//     _init();
//   }

//   final Set<int> _likedSongIds = {};

//   void _init() {
//     // Optionally, load liked song IDs from persistent storage and update the list
//     // This is a placeholder for initialization logic
//   }

//   void toggleSongLike(SongDetailsModel song) {
//     if (_likedSongIds.contains(song.songs[song.selectedIndex].id)) {
//       _likedSongIds.remove(song.songs[song.selectedIndex].id);
//     } else {
//       _likedSongIds.add(song.songs[song.selectedIndex].id);
//     }
//     _updateLikedSongs();
//   }

//   void _updateLikedSongs() async {
//     try {
//       final allSongs = await homeRepo.fetchAllSongs();
//       final likedSongs =
//           allSongs.where((song) => _likedSongIds.contains(song.id)).toList();

//       // Assuming you have a method to convert SongModel to SongDetailsModel

//       emit(FavouritesSongUpdated(likedSongs));
//     } catch (e) {
//       emit(FavouritesSongFailure(e.toString()));
//     }
//   }

//   bool isSongLiked(int songId) {
//     return _likedSongIds.contains(songId);
//   }
// }
