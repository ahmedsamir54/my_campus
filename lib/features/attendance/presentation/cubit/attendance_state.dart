import 'package:equatable/equatable.dart';
import '../../domain/entities/attendance_entities.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final AttendanceDataEntity data;
  final Map<String, int> simulatedSkips;
  final bool isSimulating;

  const AttendanceLoaded({
    required this.data,
    this.simulatedSkips = const {},
    this.isSimulating = false,
  });

  AttendanceLoaded copyWith({
    AttendanceDataEntity? data,
    Map<String, int>? simulatedSkips,
    bool? isSimulating,
  }) {
    return AttendanceLoaded(
      data: data ?? this.data,
      simulatedSkips: simulatedSkips ?? this.simulatedSkips,
      isSimulating: isSimulating ?? this.isSimulating,
    );
  }

  @override
  List<Object?> get props => [data, simulatedSkips, isSimulating];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError({required this.message});

  @override
  List<Object?> get props => [message];
}
