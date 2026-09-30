import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../models/attendance_models.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceDataModel> getAttendanceData();
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final String assetPath;

  AttendanceRemoteDataSourceImpl({
    this.assetPath = 'assets/mock_data/attendance_mock.json',
  });

  @override
  Future<AttendanceDataModel> getAttendanceData() async {
    try {
      // Simulate real HTTP network roundtrip latency
      await Future.delayed(const Duration(milliseconds: 300));

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap =
          json.decode(jsonString) as Map<String, dynamic>;

      return AttendanceDataModel.fromJson(jsonMap);
    } catch (e) {
      throw ServerException(
        message: 'Failed to load and parse attendance mock data: ${e.toString()}',
      );
    }
  }
}
