import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themePrefKey = 'user_theme_mode';
  final SharedPreferences sharedPreferences;

  ThemeCubit({required this.sharedPreferences}) : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final isDark = sharedPreferences.getBool(_themePrefKey);
    if (isDark != null) {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await sharedPreferences.setBool(_themePrefKey, newMode == ThemeMode.dark);
    emit(newMode);
  }

  Future<void> setTheme(ThemeMode mode) async {
    await sharedPreferences.setBool(_themePrefKey, mode == ThemeMode.dark);
    emit(mode);
  }
}
