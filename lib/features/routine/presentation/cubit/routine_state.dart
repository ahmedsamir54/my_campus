import 'package:equatable/equatable.dart';
import '../../domain/entities/routine_entities.dart';

abstract class RoutineState extends Equatable {
  const RoutineState();

  @override
  List<Object?> get props => [];
}

class RoutineInitial extends RoutineState {}

class RoutineLoading extends RoutineState {}

class RoutineLoaded extends RoutineState {
  final WeeklyRoutineEntity routine;

  const RoutineLoaded({required this.routine});

  @override
  List<Object?> get props => [routine];
}

class RoutineError extends RoutineState {
  final String message;

  const RoutineError({required this.message});

  @override
  List<Object?> get props => [message];
}
