import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_attendance_data_usecase.dart';
import '../../domain/usecases/simulate_absence_usecase.dart';
import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAttendanceDataUseCase getAttendanceDataUseCase;
  final SimulateAbsenceUseCase simulateAbsenceUseCase;

  AttendanceCubit({
    required this.getAttendanceDataUseCase,
    required this.simulateAbsenceUseCase,
  }) : super(AttendanceInitial());

  Future<void> loadAttendance() async {
    emit(AttendanceLoading());
    final result = await getAttendanceDataUseCase(const NoParams());
    result.fold(
      (failure) => emit(AttendanceError(message: failure.message)),
      (data) {
        emit(AttendanceLoaded(
          data: data,
          simulatedSkips: const {},
          isSimulating: false,
        ));
      },
    );
  }

  Future<void> simulateCourseSkips(String courseId, int skips) async {
    if (state is! AttendanceLoaded) return;
    final currentState = state as AttendanceLoaded;

    final updatedSkips = Map<String, int>.from(currentState.simulatedSkips);
    if (skips <= 0) {
      updatedSkips.remove(courseId);
    } else {
      updatedSkips[courseId] = skips;
    }

    final result = await simulateAbsenceUseCase(
      SimulateAbsenceParams(hypotheticalSkips: updatedSkips),
    );

    result.fold(
      (failure) => emit(AttendanceError(message: failure.message)),
      (simulatedData) {
        final hasActiveSkips = updatedSkips.values.any((s) => s > 0);
        emit(currentState.copyWith(
          data: simulatedData,
          simulatedSkips: updatedSkips,
          isSimulating: hasActiveSkips,
        ));
      },
    );
  }

  Future<void> resetSimulation() async {
    if (state is! AttendanceLoaded) return;
    final currentState = state as AttendanceLoaded;

    final result = await simulateAbsenceUseCase(
      const SimulateAbsenceParams(hypotheticalSkips: {}),
    );

    result.fold(
      (failure) => emit(AttendanceError(message: failure.message)),
      (cleanData) {
        emit(currentState.copyWith(
          data: cleanData,
          simulatedSkips: const {},
          isSimulating: false,
        ));
      },
    );
  }
}
