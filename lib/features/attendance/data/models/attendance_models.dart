import '../../domain/entities/attendance_entities.dart';

class AttendanceSummaryModel extends AttendanceSummaryEntity {
  const AttendanceSummaryModel({
    required super.overallPercentage,
    required super.totalAttended,
    required super.totalConducted,
    required super.minimumThreshold,
    required super.isEligible,
    required super.statusBadgeText,
    required super.statusSubtitle,
    required super.semester,
    required super.lastUpdated,
    required super.requiredSafeAttendance,
  });

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryModel(
      overallPercentage: (json['overallPercentage'] as num?)?.toDouble() ?? 0.0,
      totalAttended: (json['totalAttended'] as num?)?.toInt() ?? 0,
      totalConducted: (json['totalConducted'] as num?)?.toInt() ?? 0,
      minimumThreshold:
          (json['minimumThreshold'] as num?)?.toDouble() ?? 75.0,
      isEligible: json['isEligible'] as bool? ?? true,
      statusBadgeText: json['statusBadgeText'] as String? ?? 'Eligible',
      statusSubtitle: json['statusSubtitle'] as String? ?? '',
      semester: json['semester'] as String? ?? 'Fall 2026',
      lastUpdated: json['lastUpdated'] as String? ?? '',
      requiredSafeAttendance:
          (json['requiredSafeAttendance'] as num?)?.toInt() ?? 75,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overallPercentage': overallPercentage,
      'totalAttended': totalAttended,
      'totalConducted': totalConducted,
      'minimumThreshold': minimumThreshold,
      'isEligible': isEligible,
      'statusBadgeText': statusBadgeText,
      'statusSubtitle': statusSubtitle,
      'semester': semester,
      'lastUpdated': lastUpdated,
      'requiredSafeAttendance': requiredSafeAttendance,
    };
  }

  factory AttendanceSummaryModel.fromEntity(AttendanceSummaryEntity entity) {
    return AttendanceSummaryModel(
      overallPercentage: entity.overallPercentage,
      totalAttended: entity.totalAttended,
      totalConducted: entity.totalConducted,
      minimumThreshold: entity.minimumThreshold,
      isEligible: entity.isEligible,
      statusBadgeText: entity.statusBadgeText,
      statusSubtitle: entity.statusSubtitle,
      semester: entity.semester,
      lastUpdated: entity.lastUpdated,
      requiredSafeAttendance: entity.requiredSafeAttendance,
    );
  }
}

class CourseAttendanceModel extends CourseAttendanceEntity {
  const CourseAttendanceModel({
    required super.courseId,
    required super.courseName,
    required super.courseCode,
    required super.instructor,
    required super.hall,
    required super.credits,
    required super.attended,
    required super.conducted,
    required super.percentage,
    required super.status,
    required super.maxSkipsAllowed,
    required super.safeSkipsText,
    required super.requiredToAttend,
    required super.nextClass,
    required super.color,
  });

  factory CourseAttendanceModel.fromJson(Map<String, dynamic> json) {
    return CourseAttendanceModel(
      courseId: json['courseId'] as String? ?? '',
      courseName: json['courseName'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      instructor: json['instructor'] as String? ?? '',
      hall: json['hall'] as String? ?? '',
      credits: (json['credits'] as num?)?.toInt() ?? 3,
      attended: (json['attended'] as num?)?.toInt() ?? 0,
      conducted: (json['conducted'] as num?)?.toInt() ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'Safe',
      maxSkipsAllowed: (json['maxSkipsAllowed'] as num?)?.toInt() ?? 0,
      safeSkipsText: json['safeSkipsText'] as String? ?? '',
      requiredToAttend: (json['requiredToAttend'] as num?)?.toInt() ?? 0,
      nextClass: json['nextClass'] as String? ?? '',
      color: json['color'] as String? ?? '#006B4D',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseCode': courseCode,
      'instructor': instructor,
      'hall': hall,
      'credits': credits,
      'attended': attended,
      'conducted': conducted,
      'percentage': percentage,
      'status': status,
      'maxSkipsAllowed': maxSkipsAllowed,
      'safeSkipsText': safeSkipsText,
      'requiredToAttend': requiredToAttend,
      'nextClass': nextClass,
      'color': color,
    };
  }

  factory CourseAttendanceModel.fromEntity(CourseAttendanceEntity entity) {
    return CourseAttendanceModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
      courseCode: entity.courseCode,
      instructor: entity.instructor,
      hall: entity.hall,
      credits: entity.credits,
      attended: entity.attended,
      conducted: entity.conducted,
      percentage: entity.percentage,
      status: entity.status,
      maxSkipsAllowed: entity.maxSkipsAllowed,
      safeSkipsText: entity.safeSkipsText,
      requiredToAttend: entity.requiredToAttend,
      nextClass: entity.nextClass,
      color: entity.color,
    );
  }
}

class AttendanceDataModel extends AttendanceDataEntity {
  const AttendanceDataModel({
    required AttendanceSummaryModel super.summary,
    required List<CourseAttendanceModel> super.courses,
  });

  factory AttendanceDataModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDataModel(
      summary: AttendanceSummaryModel.fromJson(
        json['summary'] as Map<String, dynamic>? ?? {},
      ),
      courses: (json['courses'] as List<dynamic>? ?? [])
          .map((item) =>
              CourseAttendanceModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': AttendanceSummaryModel.fromEntity(summary).toJson(),
      'courses': courses
          .map((c) => CourseAttendanceModel.fromEntity(c).toJson())
          .toList(),
    };
  }

  factory AttendanceDataModel.fromEntity(AttendanceDataEntity entity) {
    return AttendanceDataModel(
      summary: AttendanceSummaryModel.fromEntity(entity.summary),
      courses: entity.courses
          .map((c) => CourseAttendanceModel.fromEntity(c))
          .toList(),
    );
  }
}
