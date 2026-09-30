import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String studentId;
  final String email;
  final String fullName;
  final String token;
  final bool isBiometricEnabled;
  final String department;
  final String avatarUrl;

  const AuthUserEntity({
    required this.studentId,
    required this.email,
    required this.fullName,
    required this.token,
    required this.isBiometricEnabled,
    this.department = 'Computer Science & AI',
    this.avatarUrl = 'assets/images/avatar_student.png',
  });

  AuthUserEntity copyWith({
    String? studentId,
    String? email,
    String? fullName,
    String? token,
    bool? isBiometricEnabled,
    String? department,
    String? avatarUrl,
  }) {
    return AuthUserEntity(
      studentId: studentId ?? this.studentId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      token: token ?? this.token,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      department: department ?? this.department,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [
        studentId,
        email,
        fullName,
        token,
        isBiometricEnabled,
        department,
        avatarUrl,
      ];
}
