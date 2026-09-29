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

  const FeaturedEventEntity({
    required this.id,
    required this.categoryTag,
    required this.deadlineBadge,
    required this.title,
    required this.description,
    required this.audience,
    required this.buttonLabel,
  });

  @override
  List<Object?> get props => [
        id,
        categoryTag,
        deadlineBadge,
        title,
        description,
        audience,
        buttonLabel,
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
