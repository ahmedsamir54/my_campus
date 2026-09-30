import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../models/profile_models.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDataModel> getStudentProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final String assetPath;

  ProfileRemoteDataSourceImpl({
    this.assetPath = 'assets/mock_data/profile_mock.json',
  });

  @override
  Future<ProfileDataModel> getStudentProfile() async {
    try {
      // Simulate real HTTP network roundtrip latency
      await Future.delayed(const Duration(milliseconds: 300));

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap =
          json.decode(jsonString) as Map<String, dynamic>;

      return ProfileDataModel.fromJson(jsonMap);
    } catch (e) {
      throw ServerException(
        message: 'Failed to load and parse profile mock data: ${e.toString()}',
      );
    }
  }
}
