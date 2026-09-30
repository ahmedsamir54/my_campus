import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/auth_user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuthSession({
    required AuthUserModel user,
    required bool rememberMe,
  });
  Future<String?> getCachedToken();
  Future<AuthUserModel?> getCachedUser();
  Future<bool> isRemembered();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _authTokenKey = 'auth_session_token_key';
  static const String _authUserKey = 'auth_session_user_json_key';
  static const String _rememberMeKey = 'auth_remember_me_key';

  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAuthSession({
    required AuthUserModel user,
    required bool rememberMe,
  }) async {
    try {
      await sharedPreferences.setString(_authTokenKey, user.token);
      await sharedPreferences.setString('auth_token', user.token);
      await sharedPreferences.setString(
          _authUserKey, json.encode(user.toJson()));
      await sharedPreferences.setBool(_rememberMeKey, rememberMe);
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache authentication session: ${e.toString()}',
      );
    }
  }

  @override
  Future<String?> getCachedToken() async {
    try {
      return sharedPreferences.getString(_authTokenKey);
    } catch (e) {
      throw CacheException(
        message: 'Failed to read cached token: ${e.toString()}',
      );
    }
  }

  @override
  Future<AuthUserModel?> getCachedUser() async {
    try {
      final jsonString = sharedPreferences.getString(_authUserKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        return AuthUserModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      throw CacheException(
        message: 'Failed to read cached user: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> isRemembered() async {
    return sharedPreferences.getBool(_rememberMeKey) ?? true;
  }

  @override
  Future<void> clearSession() async {
    try {
      await sharedPreferences.remove(_authTokenKey);
      await sharedPreferences.remove('auth_token');
      await sharedPreferences.remove(_authUserKey);
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear session: ${e.toString()}',
      );
    }
  }
}
