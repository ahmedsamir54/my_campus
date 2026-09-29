import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_dashboard_data_usecase.dart';
import '../../domain/usecases/register_event_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardDataUseCase getDashboardDataUseCase;
  final RegisterEventUseCase registerEventUseCase;

  DashboardCubit({
    required this.getDashboardDataUseCase,
    required this.registerEventUseCase,
  }) : super(DashboardInitial());

  Future<void> loadDashboard() async {
    emit(DashboardLoading());
    final result = await getDashboardDataUseCase(const NoParams());
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (data) => emit(DashboardLoaded(data: data)),
    );
  }

  Future<void> registerEvent(String eventId) async {
    final result = await registerEventUseCase(eventId);
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (data) => emit(DashboardLoaded(data: data)),
    );
  }
}
