import 'package:flutter_test/flutter_test.dart';
import 'package:my_campus/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:my_campus/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:my_campus/features/auth/data/models/auth_user_model.dart';
import 'package:my_campus/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  final AuthUserModel sampleUser;
  MockAuthRemoteDataSource(this.sampleUser);

  @override
  Future<AuthUserModel> loginWithCredentials({
    required String studentIdOrEmail,
    required String password,
  }) async {
    if (studentIdOrEmail.isEmpty || password.isEmpty) {
      throw Exception('Credentials cannot be empty');
    }
    return sampleUser;
  }

  @override
  Future<AuthUserModel> loginWithBiometrics() async {
    return sampleUser;
  }
}

class MockAuthLocalDataSource implements AuthLocalDataSource {
  AuthUserModel? cachedUser;
  String? cachedToken;
  bool remembered = true;

  @override
  Future<void> cacheAuthSession({
    required AuthUserModel user,
    required bool rememberMe,
  }) async {
    cachedUser = user;
    cachedToken = user.token;
    remembered = rememberMe;
  }

  @override
  Future<String?> getCachedToken() async => cachedToken;

  @override
  Future<AuthUserModel?> getCachedUser() async => cachedUser;

  @override
  Future<bool> isRemembered() async => remembered;

  @override
  Future<void> clearSession() async {
    cachedUser = null;
    cachedToken = null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUserModel sampleUser;
  late MockAuthRemoteDataSource remoteDataSource;
  late MockAuthLocalDataSource localDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    sampleUser = const AuthUserModel(
      studentId: 'CU-2023-8841',
      email: 'ahmed.samir@campus.edu',
      fullName: 'Ahmed Samir Abdelaziz',
      token: 'jwt_mock_token_8841',
      isBiometricEnabled: true,
      department: 'Computer Science & AI',
      avatarUrl: 'assets/images/avatar_student.png',
    );

    remoteDataSource = MockAuthRemoteDataSource(sampleUser);
    localDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  test('AuthUserModel JSON serialization and round-trip test', () {
    final json = sampleUser.toJson();
    final parsed = AuthUserModel.fromJson(json);

    expect(parsed.studentId, 'CU-2023-8841');
    expect(parsed.email, 'ahmed.samir@campus.edu');
    expect(parsed.fullName, 'Ahmed Samir Abdelaziz');
    expect(parsed.token, 'jwt_mock_token_8841');
    expect(parsed.isBiometricEnabled, isTrue);
  });

  test('AuthRepositoryImpl loginWithCredentials successfully authenticates and caches session', () async {
    final result = await repository.loginWithCredentials(
      studentIdOrEmail: 'CU-2023-8841',
      password: 'password123',
      rememberMe: true,
    );

    expect(result.isRight(), isTrue);
    result.fold(
      (failure) => fail('Expected success but got failure: $failure'),
      (user) {
        expect(user.studentId, 'CU-2023-8841');
        expect(localDataSource.cachedToken, 'jwt_mock_token_8841');
        expect(localDataSource.cachedUser, isNotNull);
      },
    );
  });

  test('AuthRepositoryImpl loginWithBiometrics successfully authenticates', () async {
    final result = await repository.loginWithBiometrics();

    expect(result.isRight(), isTrue);
    result.fold(
      (failure) => fail('Expected success but got failure: $failure'),
      (user) {
        expect(user.studentId, 'CU-2023-8841');
        expect(user.isBiometricEnabled, isTrue);
      },
    );
  });

  test('AuthRepositoryImpl logout clears cached session', () async {
    await repository.loginWithCredentials(
      studentIdOrEmail: 'CU-2023-8841',
      password: 'password123',
    );
    expect(localDataSource.cachedToken, isNotNull);

    await repository.logout();
    expect(localDataSource.cachedToken, isNull);
    expect(localDataSource.cachedUser, isNull);
  });
}
