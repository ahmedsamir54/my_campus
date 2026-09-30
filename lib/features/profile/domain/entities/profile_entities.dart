import 'package:equatable/equatable.dart';

class StudentProfileEntity extends Equatable {
  final String id;
  final String name;
  final String studentIdNumber;
  final String department;
  final String faculty;
  final String batch;
  final String academicYear;
  final String semester;
  final String bloodGroup;
  final String validUntil;
  final String issuedDate;
  final String email;
  final String phone;
  final String emergencyContact;
  final String nationalId;
  final String barcodeValue;
  final String qrPayload;
  final String avatarUrl;
  final String status;
  final String cardType;

  const StudentProfileEntity({
    required this.id,
    required this.name,
    required this.studentIdNumber,
    required this.department,
    required this.faculty,
    required this.batch,
    required this.academicYear,
    required this.semester,
    required this.bloodGroup,
    required this.validUntil,
    required this.issuedDate,
    required this.email,
    required this.phone,
    required this.emergencyContact,
    required this.nationalId,
    required this.barcodeValue,
    required this.qrPayload,
    required this.avatarUrl,
    required this.status,
    required this.cardType,
  });

  StudentProfileEntity copyWith({
    String? id,
    String? name,
    String? studentIdNumber,
    String? department,
    String? faculty,
    String? batch,
    String? academicYear,
    String? semester,
    String? bloodGroup,
    String? validUntil,
    String? issuedDate,
    String? email,
    String? phone,
    String? emergencyContact,
    String? nationalId,
    String? barcodeValue,
    String? qrPayload,
    String? avatarUrl,
    String? status,
    String? cardType,
  }) {
    return StudentProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      studentIdNumber: studentIdNumber ?? this.studentIdNumber,
      department: department ?? this.department,
      faculty: faculty ?? this.faculty,
      batch: batch ?? this.batch,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      validUntil: validUntil ?? this.validUntil,
      issuedDate: issuedDate ?? this.issuedDate,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      nationalId: nationalId ?? this.nationalId,
      barcodeValue: barcodeValue ?? this.barcodeValue,
      qrPayload: qrPayload ?? this.qrPayload,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      cardType: cardType ?? this.cardType,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        studentIdNumber,
        department,
        faculty,
        batch,
        academicYear,
        semester,
        bloodGroup,
        validUntil,
        issuedDate,
        email,
        phone,
        emergencyContact,
        nationalId,
        barcodeValue,
        qrPayload,
        avatarUrl,
        status,
        cardType,
      ];
}

class AcademicSummaryEntity extends Equatable {
  final double cgpa;
  final double maxCgpa;
  final int earnedCredits;
  final int totalCredits;
  final int enrolledCourses;
  final String semester;
  final String academicStanding;
  final bool libraryCleared;
  final bool financialCleared;

  const AcademicSummaryEntity({
    required this.cgpa,
    required this.maxCgpa,
    required this.earnedCredits,
    required this.totalCredits,
    required this.enrolledCourses,
    required this.semester,
    required this.academicStanding,
    required this.libraryCleared,
    required this.financialCleared,
  });

  AcademicSummaryEntity copyWith({
    double? cgpa,
    double? maxCgpa,
    int? earnedCredits,
    int? totalCredits,
    int? enrolledCourses,
    String? semester,
    String? academicStanding,
    bool? libraryCleared,
    bool? financialCleared,
  }) {
    return AcademicSummaryEntity(
      cgpa: cgpa ?? this.cgpa,
      maxCgpa: maxCgpa ?? this.maxCgpa,
      earnedCredits: earnedCredits ?? this.earnedCredits,
      totalCredits: totalCredits ?? this.totalCredits,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      semester: semester ?? this.semester,
      academicStanding: academicStanding ?? this.academicStanding,
      libraryCleared: libraryCleared ?? this.libraryCleared,
      financialCleared: financialCleared ?? this.financialCleared,
    );
  }

  @override
  List<Object?> get props => [
        cgpa,
        maxCgpa,
        earnedCredits,
        totalCredits,
        enrolledCourses,
        semester,
        academicStanding,
        libraryCleared,
        financialCleared,
      ];
}

class ProfileSettingsEntity extends Equatable {
  final bool biometricsEnabled;
  final bool notificationsEnabled;
  final bool darkMode;
  final bool offlineIdAccess;

  const ProfileSettingsEntity({
    required this.biometricsEnabled,
    required this.notificationsEnabled,
    required this.darkMode,
    required this.offlineIdAccess,
  });

  ProfileSettingsEntity copyWith({
    bool? biometricsEnabled,
    bool? notificationsEnabled,
    bool? darkMode,
    bool? offlineIdAccess,
  }) {
    return ProfileSettingsEntity(
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      notificationsEnabled:
          notificationsEnabled ?? this.notificationsEnabled,
      darkMode: darkMode ?? this.darkMode,
      offlineIdAccess: offlineIdAccess ?? this.offlineIdAccess,
    );
  }

  @override
  List<Object?> get props => [
        biometricsEnabled,
        notificationsEnabled,
        darkMode,
        offlineIdAccess,
      ];
}

class ProfileDataEntity extends Equatable {
  final StudentProfileEntity profile;
  final AcademicSummaryEntity academic;
  final ProfileSettingsEntity settings;

  const ProfileDataEntity({
    required this.profile,
    required this.academic,
    required this.settings,
  });

  ProfileDataEntity copyWith({
    StudentProfileEntity? profile,
    AcademicSummaryEntity? academic,
    ProfileSettingsEntity? settings,
  }) {
    return ProfileDataEntity(
      profile: profile ?? this.profile,
      academic: academic ?? this.academic,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [profile, academic, settings];
}
