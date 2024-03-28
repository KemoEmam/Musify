import 'package:on_audio_query/on_audio_query.dart';

class SongDetailsModel {
  List<SongModel> songs;
  int selectedIndex;
  bool isLiked;
  SongDetailsModel(
      {required this.songs, required this.selectedIndex, this.isLiked = false});
}
