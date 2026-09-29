import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/dashboard_models.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardDataModel?> getCachedDashboardData();
  Future<void> cacheDashboardData(DashboardDataModel data);
  Future<bool> isEventRegistered(String eventId);
  Future<void> setEventRegistered(String eventId, bool isRegistered);
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  static const String _cachedDashboardKey = 'cached_dashboard_payload_key';
  static const String _eventRegistrationPrefix = 'event_registered_';

  final SharedPreferences sharedPreferences;

  DashboardLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<DashboardDataModel?> getCachedDashboardData() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedDashboardKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return DashboardDataModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to read cached dashboard: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheDashboardData(DashboardDataModel data) async {
    try {
      final jsonString = json.encode(data.toJson());
      await sharedPreferences.setString(_cachedDashboardKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Failed to cache dashboard: ${e.toString()}');
    }
  }

  @override
  Future<bool> isEventRegistered(String eventId) async {
    try {
      return sharedPreferences.getBool('$_eventRegistrationPrefix$eventId') ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> setEventRegistered(String eventId, bool isRegistered) async {
    try {
      await sharedPreferences.setBool('$_eventRegistrationPrefix$eventId', isRegistered);
    } catch (e) {
      throw CacheException(message: 'Failed to persist event registration: ${e.toString()}');
    }
  }
}
