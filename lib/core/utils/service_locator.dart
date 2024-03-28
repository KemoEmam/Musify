import 'package:get_it/get_it.dart';
import 'package:musicfy/core/utils/audio_player_service.dart';

final getIt = GetIt.instance;

void serviceLocator() {
  getIt.registerSingleton<AudioPlayerService>(AudioPlayerService());
}
