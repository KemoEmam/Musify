import 'package:musicfy/features/home/data/repos/home_repo.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeRepoImpl implements HomeRepo {
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Future<List<SongModel>> fetchAllSongs() async {
    PermissionStatus status = await requestPermission();
    if (status.isGranted) {
      List<SongModel> allSongs = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        sortType: null,
      );
      List<SongModel> originalList = allSongs.where((song) {
        return song.data.toLowerCase().endsWith('.mp3');
      }).toList();
      return originalList;
    } else {
      return fetchAllSongs();
    }
  }

  Future<PermissionStatus> requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    return status;
  }
}
