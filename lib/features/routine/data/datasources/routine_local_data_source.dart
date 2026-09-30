import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/routine_models.dart';

abstract class RoutineLocalDataSource {
  Future<WeeklyRoutineModel?> getCachedWeeklyRoutine();
  Future<void> cacheWeeklyRoutine(WeeklyRoutineModel routine);
  Future<String?> getLastSelectedDay();
  Future<void> setLastSelectedDay(String dayName);
}

class RoutineLocalDataSourceImpl implements RoutineLocalDataSource {
  static const String _cachedRoutineKey = 'cached_weekly_routine_key';
  static const String _lastSelectedDayKey = 'last_selected_routine_day_key';

  final SharedPreferences sharedPreferences;

  RoutineLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeeklyRoutineModel?> getCachedWeeklyRoutine() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedRoutineKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return WeeklyRoutineModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to read cached routine: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheWeeklyRoutine(WeeklyRoutineModel routine) async {
    try {
      final jsonString = json.encode(routine.toJson());
      await sharedPreferences.setString(_cachedRoutineKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Failed to cache routine: ${e.toString()}');
    }
  }

  @override
  Future<String?> getLastSelectedDay() async {
    return sharedPreferences.getString(_lastSelectedDayKey);
  }

  @override
  Future<void> setLastSelectedDay(String dayName) async {
    await sharedPreferences.setString(_lastSelectedDayKey, dayName);
  }
}
