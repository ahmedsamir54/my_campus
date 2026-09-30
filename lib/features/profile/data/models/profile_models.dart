import '../../domain/entities/profile_entities.dart';

class StudentProfileModel extends StudentProfileEntity {
  const StudentProfileModel({
    required super.id,
    required super.name,
    required super.studentIdNumber,
    required super.department,
    required super.faculty,
    required super.batch,
    required super.academicYear,
    required super.semester,
    required super.bloodGroup,
    required super.validUntil,
    required super.issuedDate,
    required super.email,
    required super.phone,
    required super.emergencyContact,
    required super.nationalId,
    required super.barcodeValue,
    required super.qrPayload,
    required super.avatarUrl,
    required super.status,
    required super.cardType,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Ahmed Samir Abdelaziz',
      studentIdNumber: json['studentIdNumber'] as String? ?? 'CU-2023-8841',
      department:
          json['department'] as String? ?? 'Computer Science & AI',
      faculty: json['faculty'] as String? ??
          'Faculty of Computers & Artificial Intelligence',
      batch: json['batch'] as String? ?? '2023 - 2027',
      academicYear: json['academicYear'] as String? ?? 'Year 3 (Junior)',
      semester: json['semester'] as String? ?? 'Fall 2026',
      bloodGroup: json['bloodGroup'] as String? ?? 'A+',
      validUntil: json['validUntil'] as String? ?? 'July 2027',
      issuedDate: json['issuedDate'] as String? ?? 'September 2023',
      email: json['email'] as String? ?? 'ahmed.samir@campus.edu',
      phone: json['phone'] as String? ?? '+20 100 234 5678',
      emergencyContact:
          json['emergencyContact'] as String? ?? '+20 101 987 6543 (Father)',
      nationalId: json['nationalId'] as String? ?? '30109230104567',
      barcodeValue: json['barcodeValue'] as String? ?? '*CU8841026*',
      qrPayload: json['qrPayload'] as String? ??
          'mycampus://verify/student/CU-2023-8841',
      avatarUrl:
          json['avatarUrl'] as String? ?? 'assets/images/avatar_student.png',
      status: json['status'] as String? ?? 'Active / Verified',
      cardType: json['cardType'] as String? ??
          'Digital Student Pass (PVC Smart Card)',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'studentIdNumber': studentIdNumber,
      'department': department,
      'faculty': faculty,
      'batch': batch,
      'academicYear': academicYear,
      'semester': semester,
      'bloodGroup': bloodGroup,
      'validUntil': validUntil,
      'issuedDate': issuedDate,
      'email': email,
      'phone': phone,
      'emergencyContact': emergencyContact,
      'nationalId': nationalId,
      'barcodeValue': barcodeValue,
      'qrPayload': qrPayload,
      'avatarUrl': avatarUrl,
      'status': status,
      'cardType': cardType,
    };
  }

  factory StudentProfileModel.fromEntity(StudentProfileEntity entity) {
    return StudentProfileModel(
      id: entity.id,
      name: entity.name,
      studentIdNumber: entity.studentIdNumber,
      department: entity.department,
      faculty: entity.faculty,
      batch: entity.batch,
      academicYear: entity.academicYear,
      semester: entity.semester,
      bloodGroup: entity.bloodGroup,
      validUntil: entity.validUntil,
      issuedDate: entity.issuedDate,
      email: entity.email,
      phone: entity.phone,
      emergencyContact: entity.emergencyContact,
      nationalId: entity.nationalId,
      barcodeValue: entity.barcodeValue,
      qrPayload: entity.qrPayload,
      avatarUrl: entity.avatarUrl,
      status: entity.status,
      cardType: entity.cardType,
    );
  }
}

class AcademicSummaryModel extends AcademicSummaryEntity {
  const AcademicSummaryModel({
    required super.cgpa,
    required super.maxCgpa,
    required super.earnedCredits,
    required super.totalCredits,
    required super.enrolledCourses,
    required super.semester,
    required super.academicStanding,
    required super.libraryCleared,
    required super.financialCleared,
  });

  factory AcademicSummaryModel.fromJson(Map<String, dynamic> json) {
    return AcademicSummaryModel(
      cgpa: (json['cgpa'] as num?)?.toDouble() ?? 3.82,
      maxCgpa: (json['maxCgpa'] as num?)?.toDouble() ?? 4.0,
      earnedCredits: (json['earnedCredits'] as num?)?.toInt() ?? 96,
      totalCredits: (json['totalCredits'] as num?)?.toInt() ?? 136,
      enrolledCourses: (json['enrolledCourses'] as num?)?.toInt() ?? 6,
      semester: json['semester'] as String? ?? 'Semester 6',
      academicStanding: json['academicStanding'] as String? ??
          'Dean\'s List • First Honors',
      libraryCleared: json['libraryCleared'] as bool? ?? true,
      financialCleared: json['financialCleared'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cgpa': cgpa,
      'maxCgpa': maxCgpa,
      'earnedCredits': earnedCredits,
      'totalCredits': totalCredits,
      'enrolledCourses': enrolledCourses,
      'semester': semester,
      'academicStanding': academicStanding,
      'libraryCleared': libraryCleared,
      'financialCleared': financialCleared,
    };
  }

  factory AcademicSummaryModel.fromEntity(AcademicSummaryEntity entity) {
    return AcademicSummaryModel(
      cgpa: entity.cgpa,
      maxCgpa: entity.maxCgpa,
      earnedCredits: entity.earnedCredits,
      totalCredits: entity.totalCredits,
      enrolledCourses: entity.enrolledCourses,
      semester: entity.semester,
      academicStanding: entity.academicStanding,
      libraryCleared: entity.libraryCleared,
      financialCleared: entity.financialCleared,
    );
  }
}

class ProfileSettingsModel extends ProfileSettingsEntity {
  const ProfileSettingsModel({
    required super.biometricsEnabled,
    required super.notificationsEnabled,
    required super.darkMode,
    required super.offlineIdAccess,
  });

  factory ProfileSettingsModel.fromJson(Map<String, dynamic> json) {
    return ProfileSettingsModel(
      biometricsEnabled: json['biometricsEnabled'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      darkMode: json['darkMode'] as bool? ?? false,
      offlineIdAccess: json['offlineIdAccess'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biometricsEnabled': biometricsEnabled,
      'notificationsEnabled': notificationsEnabled,
      'darkMode': darkMode,
      'offlineIdAccess': offlineIdAccess,
    };
  }

  factory ProfileSettingsModel.fromEntity(ProfileSettingsEntity entity) {
    return ProfileSettingsModel(
      biometricsEnabled: entity.biometricsEnabled,
      notificationsEnabled: entity.notificationsEnabled,
      darkMode: entity.darkMode,
      offlineIdAccess: entity.offlineIdAccess,
    );
  }
}

class ProfileDataModel extends ProfileDataEntity {
  const ProfileDataModel({
    required StudentProfileModel super.profile,
    required AcademicSummaryModel super.academic,
    required ProfileSettingsModel super.settings,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      profile: StudentProfileModel.fromJson(
        json['profile'] as Map<String, dynamic>? ?? {},
      ),
      academic: AcademicSummaryModel.fromJson(
        json['academic'] as Map<String, dynamic>? ?? {},
      ),
      settings: ProfileSettingsModel.fromJson(
        json['settings'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': StudentProfileModel.fromEntity(profile).toJson(),
      'academic': AcademicSummaryModel.fromEntity(academic).toJson(),
      'settings': ProfileSettingsModel.fromEntity(settings).toJson(),
    };
  }

  factory ProfileDataModel.fromEntity(ProfileDataEntity entity) {
    return ProfileDataModel(
      profile: StudentProfileModel.fromEntity(entity.profile),
      academic: AcademicSummaryModel.fromEntity(entity.academic),
      settings: ProfileSettingsModel.fromEntity(entity.settings),
    );
  }
}
