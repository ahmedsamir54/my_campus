import '../../../../core/error/exceptions.dart';
import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> loginWithCredentials({
    required String studentIdOrEmail,
    required String password,
  });

  Future<AuthUserModel> loginWithBiometrics();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthUserModel> loginWithCredentials({
    required String studentIdOrEmail,
    required String password,
  }) async {
    // Simulate real university SSO OAuth2/LDAP roundtrip
    await Future.delayed(const Duration(milliseconds: 400));

    final normalized = studentIdOrEmail.trim().toLowerCase();

    // Reject empty or very short credentials
    if (normalized.isEmpty) {
      throw const ServerException(message: 'Student ID or university email is required.');
    }
    if (password.trim().isEmpty) {
      throw const ServerException(message: 'Portal password is required.');
    }
    if (password.length < 4) {
      throw const ServerException(message: 'Password must be at least 4 characters.');
    }

    // Explicit error simulation for test purposes
    if (normalized == 'invalid' || normalized == 'fail@campus.edu') {
      throw const ServerException(
        message: 'Invalid university credentials. Please check your Student ID and portal password.',
      );
    }

    // Success response: maps to verified enrolled student
    return AuthUserModel(
      studentId: normalized.contains('cu-') ? studentIdOrEmail.toUpperCase() : 'CU-2023-8841',
      email: normalized.contains('@') ? studentIdOrEmail : 'ahmed.samir@campus.edu',
      fullName: 'Ahmed Samir Abdelaziz',
      token: 'jwt_sso_bearer_token_${DateTime.now().millisecondsSinceEpoch}',
      isBiometricEnabled: true,
      department: 'Computer Science & AI',
      avatarUrl: 'assets/images/avatar_student.png',
    );
  }

  @override
  Future<AuthUserModel> loginWithBiometrics() async {
    // Simulate Face ID / Fingerprint sensor validation latency
    await Future.delayed(const Duration(milliseconds: 350));

    return AuthUserModel(
      studentId: 'CU-2023-8841',
      email: 'ahmed.samir@campus.edu',
      fullName: 'Ahmed Samir Abdelaziz',
      token: 'jwt_biometric_bearer_token_${DateTime.now().millisecondsSinceEpoch}',
      isBiometricEnabled: true,
      department: 'Computer Science & AI',
      avatarUrl: 'assets/images/avatar_student.png',
    );
  }
}
