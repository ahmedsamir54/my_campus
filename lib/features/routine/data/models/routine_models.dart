import '../../domain/entities/routine_entities.dart';

class LectureModel extends LectureEntity {
  const LectureModel({
    required super.id,
    required super.title,
    required super.code,
    required super.hall,
    required super.instructor,
    required super.startTime,
    required super.endTime,
    required super.timeSpan,
    required super.isOngoing,
    required super.statusTag,
    required super.elapsedMinutes,
    required super.totalMinutes,
    required super.elapsedPercentage,
    required super.type,
    super.attendanceMarked,
    super.locateWalkMinutes,
    super.attachmentName,
    super.attachmentSize,
    super.groupSlot,
    super.rubricLabel,
    super.reservationButton,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String,
      hall: json['hall'] as String,
      instructor: json['instructor'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      timeSpan: json['timeSpan'] as String,
      isOngoing: json['isOngoing'] as bool? ?? false,
      statusTag: json['statusTag'] as String? ?? '',
      elapsedMinutes: json['elapsedMinutes'] as int? ?? 0,
      totalMinutes: json['totalMinutes'] as int? ?? 90,
      elapsedPercentage: (json['elapsedPercentage'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] as String? ?? 'Lecture',
      attendanceMarked: json['attendanceMarked'] as String?,
      locateWalkMinutes: json['locateWalkMinutes'] as String?,
      attachmentName: json['attachmentName'] as String?,
      attachmentSize: json['attachmentSize'] as String?,
      groupSlot: json['groupSlot'] as String?,
      rubricLabel: json['rubricLabel'] as String?,
      reservationButton: json['reservationButton'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'hall': hall,
      'instructor': instructor,
      'startTime': startTime,
      'endTime': endTime,
      'timeSpan': timeSpan,
      'isOngoing': isOngoing,
      'statusTag': statusTag,
      'elapsedMinutes': elapsedMinutes,
      'totalMinutes': totalMinutes,
      'elapsedPercentage': elapsedPercentage,
      'type': type,
      'attendanceMarked': attendanceMarked,
      'locateWalkMinutes': locateWalkMinutes,
      'attachmentName': attachmentName,
      'attachmentSize': attachmentSize,
      'groupSlot': groupSlot,
      'rubricLabel': rubricLabel,
      'reservationButton': reservationButton,
    };
  }
}

class RoutineDayModel extends RoutineDayEntity {
  const RoutineDayModel({
    required super.dayName,
    required super.dayNumber,
    required super.fullDate,
    required super.isToday,
    super.isSelected = false,
    required super.lecturesCount,
    required super.totalHours,
    required super.progressPercentage,
    required super.lectures,
  });

  factory RoutineDayModel.fromJson(Map<String, dynamic> json) {
    return RoutineDayModel(
      dayName: json['dayName'] as String,
      dayNumber: json['dayNumber'] as String,
      fullDate: json['fullDate'] as String,
      isToday: json['isToday'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
      lecturesCount: json['lecturesCount'] as int? ?? 0,
      totalHours: json['totalHours'] as String? ?? '',
      progressPercentage: json['progressPercentage'] as String? ?? '',
      lectures: (json['lectures'] as List? ?? [])
          .map((item) => LectureModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName,
      'dayNumber': dayNumber,
      'fullDate': fullDate,
      'isToday': isToday,
      'isSelected': isSelected,
      'lecturesCount': lecturesCount,
      'totalHours': totalHours,
      'progressPercentage': progressPercentage,
      'lectures': lectures.map((l) => (l as LectureModel).toJson()).toList(),
    };
  }
}

class WeeklyRoutineModel extends WeeklyRoutineEntity {
  const WeeklyRoutineModel({
    required super.semester,
    required super.week,
    required super.days,
    required super.selectedDay,
  });

  factory WeeklyRoutineModel.fromJson(Map<String, dynamic> json) {
    final daysList = (json['days'] as List)
        .map((item) => RoutineDayModel.fromJson(item as Map<String, dynamic>))
        .toList();

    RoutineDayModel? defaultSelected;
    for (final d in daysList) {
      if (d.isToday) {
        defaultSelected = d;
        break;
      }
    }
    defaultSelected ??= daysList.isNotEmpty
        ? daysList.first
        : const RoutineDayModel(
            dayName: 'Mon',
            dayNumber: '28',
            fullDate: '',
            isToday: false,
            lecturesCount: 0,
            totalHours: '',
            progressPercentage: '',
            lectures: [],
          );

    return WeeklyRoutineModel(
      semester: json['semester'] as String? ?? 'Fall 2026',
      week: json['week'] as String? ?? 'Week 7',
      days: daysList,
      selectedDay: defaultSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'semester': semester,
      'week': week,
      'days': days.map((d) => (d as RoutineDayModel).toJson()).toList(),
    };
  }
}
