import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../models/routine_models.dart';

abstract class RoutineRemoteDataSource {
  Future<WeeklyRoutineModel> getWeeklyRoutine();
}

class RoutineRemoteDataSourceImpl implements RoutineRemoteDataSource {
  final String assetPath;

  RoutineRemoteDataSourceImpl({
    this.assetPath = 'assets/mock_data/routine_mock.json',
  });

  @override
  Future<WeeklyRoutineModel> getWeeklyRoutine() async {
    try {
      // Simulate real HTTP network roundtrip latency
      await Future.delayed(const Duration(milliseconds: 300));

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;

      return WeeklyRoutineModel.fromJson(jsonMap);
    } catch (e) {
      throw ServerException(
        message: 'Failed to load and parse routine mock data: ${e.toString()}',
      );
    }
  }
}
