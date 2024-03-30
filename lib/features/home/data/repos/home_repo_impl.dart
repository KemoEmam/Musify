import 'package:device_info_plus/device_info_plus.dart';
import 'package:musicfy/features/home/data/repos/home_repo.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform; // Used for checking the platform

class HomeRepoImpl implements HomeRepo {
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Future<List<SongModel>> fetchAllSongs() async {
    // Ensure permission is requested and granted before proceeding
    var permissionStatus = await requestPermission();
    if (permissionStatus != PermissionStatus.granted) {
      throw Exception('Storage permission not granted');
    }
    return await _querySongs();
  }

  Future<List<SongModel>> _querySongs() async {
    List<SongModel> allSongs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      sortType: null,
    );
    List<SongModel> mp3Songs = allSongs
        .where((song) => song.data.toLowerCase().endsWith('.mp3'))
        .toList();

    if (mp3Songs.isEmpty) {
      allSongs = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.INTERNAL,
        sortType: null,
      );
      mp3Songs = allSongs
          .where((song) => song.data.toLowerCase().endsWith('.mp3'))
          .toList();
    }

    return mp3Songs;
  }

  Future<PermissionStatus> requestPermission() async {
    PermissionStatus status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    int? apiLevel = androidInfo.version.sdkInt;

    if (Platform.isAndroid && apiLevel >= 33) {
      status = await Permission.audio.status;
      if (!status.isGranted) {
        status = await Permission.audio.request();
      }
    } else {
      status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return status;
  }
}
