import 'package:equatable/equatable.dart';

class LectureEntity extends Equatable {
  final String id;
  final String title;
  final String code;
  final String hall;
  final String instructor;
  final String startTime;
  final String endTime;
  final String timeSpan;
  final bool isOngoing;
  final String statusTag;
  final int elapsedMinutes;
  final int totalMinutes;
  final double elapsedPercentage;
  final String type; // Lecture, Lab, Workshop, Reservation
  final String? attendanceMarked;
  final String? locateWalkMinutes;
  final String? attachmentName;
  final String? attachmentSize;
  final String? groupSlot;
  final String? rubricLabel;
  final String? reservationButton;

  const LectureEntity({
    required this.id,
    required this.title,
    required this.code,
    required this.hall,
    required this.instructor,
    required this.startTime,
    required this.endTime,
    required this.timeSpan,
    required this.isOngoing,
    required this.statusTag,
    required this.elapsedMinutes,
    required this.totalMinutes,
    required this.elapsedPercentage,
    required this.type,
    this.attendanceMarked,
    this.locateWalkMinutes,
    this.attachmentName,
    this.attachmentSize,
    this.groupSlot,
    this.rubricLabel,
    this.reservationButton,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        code,
        hall,
        instructor,
        startTime,
        endTime,
        timeSpan,
        isOngoing,
        statusTag,
        elapsedMinutes,
        totalMinutes,
        elapsedPercentage,
        type,
        attendanceMarked,
        locateWalkMinutes,
        attachmentName,
        attachmentSize,
        groupSlot,
        rubricLabel,
        reservationButton,
      ];
}

class RoutineDayEntity extends Equatable {
  final String dayName;
  final String dayNumber;
  final String fullDate;
  final bool isToday;
  final bool isSelected;
  final int lecturesCount;
  final String totalHours;
  final String progressPercentage;
  final List<LectureEntity> lectures;

  const RoutineDayEntity({
    required this.dayName,
    required this.dayNumber,
    required this.fullDate,
    required this.isToday,
    this.isSelected = false,
    required this.lecturesCount,
    required this.totalHours,
    required this.progressPercentage,
    required this.lectures,
  });

  RoutineDayEntity copyWith({
    String? dayName,
    String? dayNumber,
    String? fullDate,
    bool? isToday,
    bool? isSelected,
    int? lecturesCount,
    String? totalHours,
    String? progressPercentage,
    List<LectureEntity>? lectures,
  }) {
    return RoutineDayEntity(
      dayName: dayName ?? this.dayName,
      dayNumber: dayNumber ?? this.dayNumber,
      fullDate: fullDate ?? this.fullDate,
      isToday: isToday ?? this.isToday,
      isSelected: isSelected ?? this.isSelected,
      lecturesCount: lecturesCount ?? this.lecturesCount,
      totalHours: totalHours ?? this.totalHours,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      lectures: lectures ?? this.lectures,
    );
  }

  @override
  List<Object?> get props => [
        dayName,
        dayNumber,
        fullDate,
        isToday,
        isSelected,
        lecturesCount,
        totalHours,
        progressPercentage,
        lectures,
      ];
}

class WeeklyRoutineEntity extends Equatable {
  final String semester;
  final String week;
  final List<RoutineDayEntity> days;
  final RoutineDayEntity selectedDay;

  const WeeklyRoutineEntity({
    required this.semester,
    required this.week,
    required this.days,
    required this.selectedDay,
  });

  WeeklyRoutineEntity copyWith({
    String? semester,
    String? week,
    List<RoutineDayEntity>? days,
    RoutineDayEntity? selectedDay,
  }) {
    return WeeklyRoutineEntity(
      semester: semester ?? this.semester,
      week: week ?? this.week,
      days: days ?? this.days,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object?> get props => [semester, week, days, selectedDay];
}
