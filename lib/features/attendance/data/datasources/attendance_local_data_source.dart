import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/attendance_models.dart';

abstract class AttendanceLocalDataSource {
  Future<AttendanceDataModel?> getCachedAttendanceData();
  Future<void> cacheAttendanceData(AttendanceDataModel data);
  Future<Map<String, int>?> getCachedSimulations();
  Future<void> cacheSimulations(Map<String, int> simulations);
  Future<void> clearSimulations();
}

class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  static const String _cachedAttendanceKey = 'cached_attendance_data_key';
  static const String _cachedSimulationsKey = 'cached_attendance_simulations_key';

  final SharedPreferences sharedPreferences;

  AttendanceLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AttendanceDataModel?> getCachedAttendanceData() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedAttendanceKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        return AttendanceDataModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      throw CacheException(
        message: 'Failed to read cached attendance data: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheAttendanceData(AttendanceDataModel data) async {
    try {
      final jsonString = json.encode(data.toJson());
      await sharedPreferences.setString(_cachedAttendanceKey, jsonString);
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache attendance data: ${e.toString()}',
      );
    }
  }

  @override
  Future<Map<String, int>?> getCachedSimulations() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedSimulationsKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> rawMap =
            json.decode(jsonString) as Map<String, dynamic>;
        return rawMap.map((key, value) => MapEntry(key, value as int));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheSimulations(Map<String, int> simulations) async {
    try {
      final jsonString = json.encode(simulations);
      await sharedPreferences.setString(_cachedSimulationsKey, jsonString);
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache simulation state: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearSimulations() async {
    await sharedPreferences.remove(_cachedSimulationsKey);
  }
}
