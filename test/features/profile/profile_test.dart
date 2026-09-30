import 'package:flutter_test/flutter_test.dart';
import 'package:my_campus/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:my_campus/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:my_campus/features/profile/data/models/profile_models.dart';
import 'package:my_campus/features/profile/data/repositories/profile_repository_impl.dart';

class MockProfileRemoteDataSource implements ProfileRemoteDataSource {
  final ProfileDataModel sampleData;
  MockProfileRemoteDataSource(this.sampleData);

  @override
  Future<ProfileDataModel> getStudentProfile() async => sampleData;
}

class MockProfileLocalDataSource implements ProfileLocalDataSource {
  ProfileDataModel? cachedProfile;
  bool biometrics = true;
  bool notifications = true;

  @override
  Future<ProfileDataModel?> getCachedProfile() async => cachedProfile;

  @override
  Future<void> cacheProfile(ProfileDataModel profile) async {
    cachedProfile = profile;
  }

  @override
  Future<bool> getBiometricsEnabled() async => biometrics;

  @override
  Future<void> setBiometricsEnabled(bool enabled) async {
    biometrics = enabled;
  }

  @override
  Future<bool> getNotificationsEnabled() async => notifications;

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    notifications = enabled;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProfileDataModel sampleData;
  late MockProfileRemoteDataSource remoteDataSource;
  late MockProfileLocalDataSource localDataSource;
  late ProfileRepositoryImpl repository;

  setUp(() {
    sampleData = ProfileDataModel.fromJson(const {
      'profile': {
        'id': 'std_8841',
        'name': 'Ahmed Samir Abdelaziz',
        'studentIdNumber': 'CU-2023-8841',
        'department': 'Computer Science & AI',
        'faculty': 'Faculty of Computers & Artificial Intelligence',
        'batch': '2023 - 2027',
        'academicYear': 'Year 3 (Junior)',
        'semester': 'Fall 2026',
        'bloodGroup': 'A+',
        'validUntil': 'July 2027',
        'issuedDate': 'September 2023',
        'email': 'ahmed.samir@campus.edu',
        'phone': '+20 100 234 5678',
        'emergencyContact': '+20 101 987 6543 (Father)',
        'nationalId': '30109230104567',
        'barcodeValue': '*CU8841026*',
        'qrPayload': 'mycampus://verify/student/CU-2023-8841',
        'avatarUrl': 'assets/images/avatar_student.png',
        'status': 'Active / Verified',
        'cardType': 'Digital Student Pass (PVC Smart Card)',
      },
      'academic': {
        'cgpa': 3.82,
        'maxCgpa': 4.0,
        'earnedCredits': 96,
        'totalCredits': 136,
        'enrolledCourses': 6,
        'semester': 'Semester 6',
        'academicStanding': 'Dean\'s List • First Honors',
        'libraryCleared': true,
        'financialCleared': true,
      },
      'settings': {
        'biometricsEnabled': true,
        'notificationsEnabled': true,
        'darkMode': false,
        'offlineIdAccess': true,
      },
    });

    remoteDataSource = MockProfileRemoteDataSource(sampleData);
    localDataSource = MockProfileLocalDataSource();
    repository = ProfileRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  test('ProfileDataModel JSON serialization and round-trip test', () {
    final json = sampleData.toJson();
    final parsed = ProfileDataModel.fromJson(json);

    expect(parsed.profile.name, 'Ahmed Samir Abdelaziz');
    expect(parsed.profile.studentIdNumber, 'CU-2023-8841');
    expect(parsed.profile.barcodeValue, '*CU8841026*');
    expect(parsed.profile.bloodGroup, 'A+');
    expect(parsed.academic.cgpa, 3.82);
    expect(parsed.academic.earnedCredits, 96);
    expect(parsed.academic.libraryCleared, isTrue);
    expect(parsed.settings.biometricsEnabled, isTrue);
  });

  test('ProfileRepositoryImpl getStudentProfile caches and returns remote data', () async {
    final result = await repository.getStudentProfile();
    expect(result.isRight(), isTrue);

    result.fold(
      (failure) => fail('Expected success but got failure: $failure'),
      (data) {
        expect(data.profile.name, 'Ahmed Samir Abdelaziz');
        expect(data.academic.cgpa, 3.82);
        expect(localDataSource.cachedProfile, isNotNull);
      },
    );
  });

  test('ProfileRepositoryImpl toggleBiometrics updates local settings', () async {
    final result = await repository.toggleBiometrics(false);
    expect(result.isRight(), isTrue);

    result.fold(
      (failure) => fail('Expected success but got failure: $failure'),
      (settings) {
        expect(settings.biometricsEnabled, isFalse);
        expect(localDataSource.biometrics, isFalse);
      },
    );
  });

  test('ProfileRepositoryImpl toggleNotifications updates local settings', () async {
    final result = await repository.toggleNotifications(false);
    expect(result.isRight(), isTrue);

    result.fold(
      (failure) => fail('Expected success but got failure: $failure'),
      (settings) {
        expect(settings.notificationsEnabled, isFalse);
        expect(localDataSource.notifications, isFalse);
      },
    );
  });
}
