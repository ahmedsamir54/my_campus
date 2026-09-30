import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_weekly_routine_usecase.dart';
import '../../domain/usecases/select_routine_day_usecase.dart';
import 'routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  final GetWeeklyRoutineUseCase getWeeklyRoutineUseCase;
  final SelectRoutineDayUseCase selectRoutineDayUseCase;

  RoutineCubit({
    required this.getWeeklyRoutineUseCase,
    required this.selectRoutineDayUseCase,
  }) : super(RoutineInitial());

  Future<void> loadWeeklyRoutine() async {
    emit(RoutineLoading());
    final result = await getWeeklyRoutineUseCase(const NoParams());
    result.fold(
      (failure) => emit(RoutineError(message: failure.message)),
      (routine) => emit(RoutineLoaded(routine: routine)),
    );
  }

  Future<void> selectDay(String dayName) async {
    final result = await selectRoutineDayUseCase(dayName);
    result.fold(
      (failure) => emit(RoutineError(message: failure.message)),
      (routine) => emit(RoutineLoaded(routine: routine)),
    );
  }
}
