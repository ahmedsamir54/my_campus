import 'package:equatable/equatable.dart';

class AttendanceSummaryEntity extends Equatable {
  final double overallPercentage;
  final int totalAttended;
  final int totalConducted;
  final double minimumThreshold;
  final bool isEligible;
  final String statusBadgeText;
  final String statusSubtitle;
  final String semester;
  final String lastUpdated;
  final int requiredSafeAttendance;

  const AttendanceSummaryEntity({
    required this.overallPercentage,
    required this.totalAttended,
    required this.totalConducted,
    required this.minimumThreshold,
    required this.isEligible,
    required this.statusBadgeText,
    required this.statusSubtitle,
    required this.semester,
    required this.lastUpdated,
    required this.requiredSafeAttendance,
  });

  AttendanceSummaryEntity copyWith({
    double? overallPercentage,
    int? totalAttended,
    int? totalConducted,
    double? minimumThreshold,
    bool? isEligible,
    String? statusBadgeText,
    String? statusSubtitle,
    String? semester,
    String? lastUpdated,
    int? requiredSafeAttendance,
  }) {
    return AttendanceSummaryEntity(
      overallPercentage: overallPercentage ?? this.overallPercentage,
      totalAttended: totalAttended ?? this.totalAttended,
      totalConducted: totalConducted ?? this.totalConducted,
      minimumThreshold: minimumThreshold ?? this.minimumThreshold,
      isEligible: isEligible ?? this.isEligible,
      statusBadgeText: statusBadgeText ?? this.statusBadgeText,
      statusSubtitle: statusSubtitle ?? this.statusSubtitle,
      semester: semester ?? this.semester,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      requiredSafeAttendance:
          requiredSafeAttendance ?? this.requiredSafeAttendance,
    );
  }

  @override
  List<Object?> get props => [
        overallPercentage,
        totalAttended,
        totalConducted,
        minimumThreshold,
        isEligible,
        statusBadgeText,
        statusSubtitle,
        semester,
        lastUpdated,
        requiredSafeAttendance,
      ];
}

class CourseAttendanceEntity extends Equatable {
  final String courseId;
  final String courseName;
  final String courseCode;
  final String instructor;
  final String hall;
  final int credits;
  final int attended;
  final int conducted;
  final double percentage;
  final String status; // 'Safe', 'Warning', 'At Risk'
  final int maxSkipsAllowed;
  final String safeSkipsText;
  final int requiredToAttend;
  final String nextClass;
  final String color;

  const CourseAttendanceEntity({
    required this.courseId,
    required this.courseName,
    required this.courseCode,
    required this.instructor,
    required this.hall,
    required this.credits,
    required this.attended,
    required this.conducted,
    required this.percentage,
    required this.status,
    required this.maxSkipsAllowed,
    required this.safeSkipsText,
    required this.requiredToAttend,
    required this.nextClass,
    required this.color,
  });

  CourseAttendanceEntity copyWith({
    String? courseId,
    String? courseName,
    String? courseCode,
    String? instructor,
    String? hall,
    int? credits,
    int? attended,
    int? conducted,
    double? percentage,
    String? status,
    int? maxSkipsAllowed,
    String? safeSkipsText,
    int? requiredToAttend,
    String? nextClass,
    String? color,
  }) {
    return CourseAttendanceEntity(
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,
      instructor: instructor ?? this.instructor,
      hall: hall ?? this.hall,
      credits: credits ?? this.credits,
      attended: attended ?? this.attended,
      conducted: conducted ?? this.conducted,
      percentage: percentage ?? this.percentage,
      status: status ?? this.status,
      maxSkipsAllowed: maxSkipsAllowed ?? this.maxSkipsAllowed,
      safeSkipsText: safeSkipsText ?? this.safeSkipsText,
      requiredToAttend: requiredToAttend ?? this.requiredToAttend,
      nextClass: nextClass ?? this.nextClass,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [
        courseId,
        courseName,
        courseCode,
        instructor,
        hall,
        credits,
        attended,
        conducted,
        percentage,
        status,
        maxSkipsAllowed,
        safeSkipsText,
        requiredToAttend,
        nextClass,
        color,
      ];
}

class AttendanceDataEntity extends Equatable {
  final AttendanceSummaryEntity summary;
  final List<CourseAttendanceEntity> courses;

  const AttendanceDataEntity({
    required this.summary,
    required this.courses,
  });

  AttendanceDataEntity copyWith({
    AttendanceSummaryEntity? summary,
    List<CourseAttendanceEntity>? courses,
  }) {
    return AttendanceDataEntity(
      summary: summary ?? this.summary,
      courses: courses ?? this.courses,
    );
  }

  @override
  List<Object?> get props => [summary, courses];
}
