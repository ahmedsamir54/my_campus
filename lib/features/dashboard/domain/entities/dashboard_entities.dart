import 'package:equatable/equatable.dart';

class NextClassEntity extends Equatable {
  final String courseTitle;
  final String room;
  final String instructor;
  final String startTime;
  final String countdown;

  const NextClassEntity({
    required this.courseTitle,
    required this.room,
    required this.instructor,
    required this.startTime,
    required this.countdown,
  });

  @override
  List<Object?> get props => [courseTitle, room, instructor, startTime, countdown];
}

class QuickActionItemEntity extends Equatable {
  final String id;
  final String label;
  final String iconCode;
  final String? badge;
  final String route;

  const QuickActionItemEntity({
    required this.id,
    required this.label,
    required this.iconCode,
    this.badge,
    required this.route,
  });

  @override
  List<Object?> get props => [id, label, iconCode, badge, route];
}

class FeaturedEventEntity extends Equatable {
  final String id;
  final String categoryTag;
  final String deadlineBadge;
  final String title;
  final String description;
  final String audience;
  final String buttonLabel;
  final bool isRegistered;

  const FeaturedEventEntity({
    required this.id,
    required this.categoryTag,
    required this.deadlineBadge,
    required this.title,
    required this.description,
    required this.audience,
    required this.buttonLabel,
    this.isRegistered = false,
  });

  FeaturedEventEntity copyWith({
    String? id,
    String? categoryTag,
    String? deadlineBadge,
    String? title,
    String? description,
    String? audience,
    String? buttonLabel,
    bool? isRegistered,
  }) {
    return FeaturedEventEntity(
      id: id ?? this.id,
      categoryTag: categoryTag ?? this.categoryTag,
      deadlineBadge: deadlineBadge ?? this.deadlineBadge,
      title: title ?? this.title,
      description: description ?? this.description,
      audience: audience ?? this.audience,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }

  @override
  List<Object?> get props => [
        id,
        categoryTag,
        deadlineBadge,
        title,
        description,
        audience,
        buttonLabel,
        isRegistered,
      ];
}

class DashboardDataEntity extends Equatable {
  final String studentName;
  final String studentStatus;
  final String semester;
  final String weather;
  final int notificationCount;
  final NextClassEntity nextClass;
  final List<QuickActionItemEntity> quickActions;
  final FeaturedEventEntity featuredEvent;

  const DashboardDataEntity({
    required this.studentName,
    required this.studentStatus,
    required this.semester,
    required this.weather,
    required this.notificationCount,
    required this.nextClass,
    required this.quickActions,
    required this.featuredEvent,
  });

  DashboardDataEntity copyWith({
    String? studentName,
    String? studentStatus,
    String? semester,
    String? weather,
    int? notificationCount,
    NextClassEntity? nextClass,
    List<QuickActionItemEntity>? quickActions,
    FeaturedEventEntity? featuredEvent,
  }) {
    return DashboardDataEntity(
      studentName: studentName ?? this.studentName,
      studentStatus: studentStatus ?? this.studentStatus,
      semester: semester ?? this.semester,
      weather: weather ?? this.weather,
      notificationCount: notificationCount ?? this.notificationCount,
      nextClass: nextClass ?? this.nextClass,
      quickActions: quickActions ?? this.quickActions,
      featuredEvent: featuredEvent ?? this.featuredEvent,
    );
  }

  @override
  List<Object?> get props => [
        studentName,
        studentStatus,
        semester,
        weather,
        notificationCount,
        nextClass,
        quickActions,
        featuredEvent,
      ];
}
