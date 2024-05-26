import 'package:on_audio_query/on_audio_query.dart';

abstract class HomeRepo {
  Future<List<SongModel>> fetchAllSongs();
  Future<String?> chooseDefaultSongsPath(); // Add this method
  Future<List<SongModel>> querySongsFromDirectory(String directoryPath);
}
