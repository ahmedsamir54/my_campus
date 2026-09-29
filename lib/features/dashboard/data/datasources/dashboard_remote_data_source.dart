import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../models/dashboard_models.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardDataModel> getDashboardData();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final String assetPath;

  DashboardRemoteDataSourceImpl({
    this.assetPath = 'assets/mock_data/dashboard_mock.json',
  });

  @override
  Future<DashboardDataModel> getDashboardData() async {
    try {
      // Simulate network roundtrip latency (production REST API behavior)
      await Future.delayed(const Duration(milliseconds: 300));

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;

      return DashboardDataModel.fromJson(jsonMap);
    } catch (e) {
      throw ServerException(
        message: 'Failed to load and parse dashboard mock data: ${e.toString()}',
      );
    }
  }
}
