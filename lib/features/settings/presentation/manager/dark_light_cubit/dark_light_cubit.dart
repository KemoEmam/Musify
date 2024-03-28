import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dark_light_state.dart';

class DarkLightCubit extends Cubit<DarkLightState> {
  DarkLightCubit() : super(DarkLightInitial()) {
    initializeTheme();
  }

  Future<void> initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }

  void toggleTheme() {
    if (state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }
}
