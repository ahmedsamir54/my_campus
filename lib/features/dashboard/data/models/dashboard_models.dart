import '../../domain/entities/dashboard_entities.dart';

class NextClassModel extends NextClassEntity {
  const NextClassModel({
    required super.courseTitle,
    required super.room,
    required super.instructor,
    required super.startTime,
    required super.countdown,
  });

  factory NextClassModel.fromJson(Map<String, dynamic> json) {
    return NextClassModel(
      courseTitle: json['courseTitle'] as String,
      room: json['room'] as String,
      instructor: json['instructor'] as String,
      startTime: json['startTime'] as String,
      countdown: json['countdown'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseTitle': courseTitle,
      'room': room,
      'instructor': instructor,
      'startTime': startTime,
      'countdown': countdown,
    };
  }
}

class QuickActionItemModel extends QuickActionItemEntity {
  const QuickActionItemModel({
    required super.id,
    required super.label,
    required super.iconCode,
    super.badge,
    required super.route,
  });

  factory QuickActionItemModel.fromJson(Map<String, dynamic> json) {
    return QuickActionItemModel(
      id: json['id'] as String,
      label: json['label'] as String,
      iconCode: json['iconCode'] as String,
      badge: json['badge'] as String?,
      route: json['route'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'iconCode': iconCode,
      'badge': badge,
      'route': route,
    };
  }
}

class FeaturedEventModel extends FeaturedEventEntity {
  const FeaturedEventModel({
    required super.id,
    required super.categoryTag,
    required super.deadlineBadge,
    required super.title,
    required super.description,
    required super.audience,
    required super.buttonLabel,
  });

  factory FeaturedEventModel.fromJson(Map<String, dynamic> json) {
    return FeaturedEventModel(
      id: json['id'] as String,
      categoryTag: json['categoryTag'] as String,
      deadlineBadge: json['deadlineBadge'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      audience: json['audience'] as String,
      buttonLabel: json['buttonLabel'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryTag': categoryTag,
      'deadlineBadge': deadlineBadge,
      'title': title,
      'description': description,
      'audience': audience,
      'buttonLabel': buttonLabel,
    };
  }
}

class DashboardDataModel extends DashboardDataEntity {
  const DashboardDataModel({
    required super.studentName,
    required super.studentStatus,
    required super.semester,
    required super.weather,
    required super.notificationCount,
    required NextClassModel super.nextClass,
    required List<QuickActionItemModel> super.quickActions,
    required FeaturedEventModel super.featuredEvent,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      studentName: json['studentName'] as String,
      studentStatus: json['studentStatus'] as String,
      semester: json['semester'] as String,
      weather: json['weather'] as String,
      notificationCount: json['notificationCount'] as int,
      nextClass: NextClassModel.fromJson(json['nextClass'] as Map<String, dynamic>),
      quickActions: (json['quickActions'] as List)
          .map((item) => QuickActionItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      featuredEvent: FeaturedEventModel.fromJson(json['featuredEvent'] as Map<String, dynamic>),
    );
  }
}
