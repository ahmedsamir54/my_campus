import '../../domain/entities/auth_user_entity.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.studentId,
    required super.email,
    required super.fullName,
    required super.token,
    required super.isBiometricEnabled,
    super.department,
    super.avatarUrl,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      studentId: json['studentId'] as String? ?? 'CU-2023-8841',
      email: json['email'] as String? ?? 'ahmed.samir@campus.edu',
      fullName: json['fullName'] as String? ?? 'Ahmed Samir Abdelaziz',
      token: json['token'] as String? ?? 'mock_jwt_session_token_8841',
      isBiometricEnabled: json['isBiometricEnabled'] as bool? ?? true,
      department:
          json['department'] as String? ?? 'Computer Science & AI',
      avatarUrl:
          json['avatarUrl'] as String? ?? 'assets/images/avatar_student.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'email': email,
      'fullName': fullName,
      'token': token,
      'isBiometricEnabled': isBiometricEnabled,
      'department': department,
      'avatarUrl': avatarUrl,
    };
  }

  factory AuthUserModel.fromEntity(AuthUserEntity entity) {
    return AuthUserModel(
      studentId: entity.studentId,
      email: entity.email,
      fullName: entity.fullName,
      token: entity.token,
      isBiometricEnabled: entity.isBiometricEnabled,
      department: entity.department,
      avatarUrl: entity.avatarUrl,
    );
  }
}
