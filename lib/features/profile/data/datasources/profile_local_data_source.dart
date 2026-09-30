import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/profile_models.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileDataModel?> getCachedProfile();
  Future<void> cacheProfile(ProfileDataModel profile);
  Future<bool> getBiometricsEnabled();
  Future<void> setBiometricsEnabled(bool enabled);
  Future<bool> getNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool enabled);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _cachedProfileKey = 'cached_student_profile_key';
  static const String _biometricsKey = 'setting_biometrics_enabled_key';
  static const String _notificationsKey = 'setting_notifications_enabled_key';

  final SharedPreferences sharedPreferences;

  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ProfileDataModel?> getCachedProfile() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedProfileKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        final model = ProfileDataModel.fromJson(jsonMap);

        // Apply any saved settings overrides
        final savedBiometrics = sharedPreferences.getBool(_biometricsKey);
        final savedNotifications = sharedPreferences.getBool(_notificationsKey);

        final updatedSettings = model.settings.copyWith(
          biometricsEnabled: savedBiometrics ?? model.settings.biometricsEnabled,
          notificationsEnabled:
              savedNotifications ?? model.settings.notificationsEnabled,
        );

        return ProfileDataModel.fromEntity(
          model.copyWith(settings: updatedSettings),
        );
      }
      return null;
    } catch (e) {
      throw CacheException(
        message: 'Failed to read cached profile: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cacheProfile(ProfileDataModel profile) async {
    try {
      final jsonString = json.encode(profile.toJson());
      await sharedPreferences.setString(_cachedProfileKey, jsonString);
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache profile: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> getBiometricsEnabled() async {
    return sharedPreferences.getBool(_biometricsKey) ?? true;
  }

  @override
  Future<void> setBiometricsEnabled(bool enabled) async {
    await sharedPreferences.setBool(_biometricsKey, enabled);
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    return sharedPreferences.getBool(_notificationsKey) ?? true;
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await sharedPreferences.setBool(_notificationsKey, enabled);
  }
}
