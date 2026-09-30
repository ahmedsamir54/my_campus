import 'package:flutter_test/flutter_test.dart';
import 'package:my_campus/features/attendance/data/models/attendance_models.dart';
import 'package:my_campus/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:my_campus/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:my_campus/features/attendance/data/datasources/attendance_local_data_source.dart';

class MockRemoteDataSource implements AttendanceRemoteDataSource {
  final AttendanceDataModel sampleData;
  MockRemoteDataSource(this.sampleData);

  @override
  Future<AttendanceDataModel> getAttendanceData() async => sampleData;
}

class MockLocalDataSource implements AttendanceLocalDataSource {
  AttendanceDataModel? cachedData;
  Map<String, int>? cachedSimulations;

  @override
  Future<AttendanceDataModel?> getCachedAttendanceData() async => cachedData;

  @override
  Future<void> cacheAttendanceData(AttendanceDataModel data) async {
    cachedData = data;
  }

  @override
  Future<Map<String, int>?> getCachedSimulations() async => cachedSimulations;

  @override
  Future<void> cacheSimulations(Map<String, int> simulations) async {
    cachedSimulations = simulations;
  }

  @override
  Future<void> clearSimulations() async {
    cachedSimulations = null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AttendanceDataModel sampleData;
  late MockRemoteDataSource remoteDataSource;
  late MockLocalDataSource localDataSource;
  late AttendanceRepositoryImpl repository;

  setUp(() {
    sampleData = AttendanceDataModel.fromJson(const {
      'summary': {
        'overallPercentage': 89.0,
        'totalAttended': 89,
        'totalConducted': 100,
        'minimumThreshold': 75.0,
        'isEligible': true,
        'statusBadgeText': 'Exam Hall Ticket Cleared',
        'statusSubtitle': 'All courses satisfy the 75% threshold.',
        'semester': 'Fall 2026 • 5th Semester',
        'lastUpdated': 'Just now',
        'requiredSafeAttendance': 75,
      },
      'courses': [
        {
          'courseId': 'cs201',
          'courseName': 'Data Structures',
          'courseCode': 'CS201',
          'instructor': 'Dr. Alan Vance',
          'hall': 'Hall B-12',
          'credits': 3,
          'attended': 19,
          'conducted': 20,
          'percentage': 95.0,
          'status': 'Safe',
          'maxSkipsAllowed': 5,
          'safeSkipsText': 'Can skip up to 5 more classes safely',
          'requiredToAttend': 0,
          'nextClass': 'Tomorrow',
          'color': '#006B4D',
        },
        {
          'courseId': 'mat201',
          'courseName': 'Discrete Mathematics',
          'courseCode': 'MAT201',
          'instructor': 'Prof. Robert Lang',
          'hall': 'Hall 101',
          'credits': 3,
          'attended': 9,
          'conducted': 12,
          'percentage': 75.0,
          'status': 'Warning',
          'maxSkipsAllowed': 0,
          'safeSkipsText': 'At 75% boundary! Zero skips allowed',
          'requiredToAttend': 0,
          'nextClass': 'Tomorrow',
          'color': '#EA580C',
        },
      ],
    });

    remoteDataSource = MockRemoteDataSource(sampleData);
    localDataSource = MockLocalDataSource();
    repository = AttendanceRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  test('AttendanceDataModel serialization and JSON round-trip test', () {
    final json = sampleData.toJson();
    final parsed = AttendanceDataModel.fromJson(json);

    expect(parsed.summary.overallPercentage, 89.0);
    expect(parsed.summary.isEligible, isTrue);
    expect(parsed.courses.length, 2);
    expect(parsed.courses[0].courseCode, 'CS201');
    expect(parsed.courses[1].courseCode, 'MAT201');
    expect(parsed.courses[1].percentage, 75.0);
  });

  test('AttendanceRepositoryImpl getAttendanceData returns remote and caches', () async {
    final result = await repository.getAttendanceData();
    expect(result.isRight(), isTrue);

    result.fold(
      (failure) => fail('Expected right result, got failure: $failure'),
      (data) {
        expect(data.summary.overallPercentage, 89.0);
        expect(data.courses.length, 2);
        expect(localDataSource.cachedData, isNotNull);
      },
    );
  });

  test('AttendanceRepositoryImpl simulateAbsence computes dynamic safe-zone projection', () async {
    // Simulate skipping 2 classes for MAT201 (which was at 75% boundary with 9/12)
    // New conducted = 12 + 2 = 14. Percentage = 9/14 = 64.3% -> At Risk!
    final result = await repository.simulateAbsence(
      hypotheticalSkips: {'mat201': 2},
    );

    expect(result.isRight(), isTrue);
    result.fold(
      (failure) => fail('Expected right result, got failure: $failure'),
      (data) {
        final matCourse = data.courses.firstWhere((c) => c.courseId == 'mat201');
        expect(matCourse.percentage, lessThan(75.0));
        expect(matCourse.status, 'At Risk');
        expect(matCourse.maxSkipsAllowed, 0);

        // Overall eligibility should now alert user
        expect(data.summary.isEligible, isFalse);
        expect(data.summary.statusBadgeText, contains('Warning'));
      },
    );
  });

  test('AttendanceRepositoryImpl clears simulations when empty map passed', () async {
    await repository.simulateAbsence(hypotheticalSkips: {'cs201': 1});
    expect(localDataSource.cachedSimulations, isNotNull);

    await repository.simulateAbsence(hypotheticalSkips: {});
    expect(localDataSource.cachedSimulations, isNull);
  });
}
