import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_campus/core/usecases/usecase.dart';
import '../../domain/usecases/get_dashboard_data_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardDataUseCase getDashboardDataUseCase;

  DashboardCubit({required this.getDashboardDataUseCase}) : super(DashboardInitial());

  Future<void> loadDashboard() async {
    emit(DashboardLoading());
    final result = await getDashboardDataUseCase(const NoParams());
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (data) => emit(DashboardLoaded(data: data)),
    );
  }
}
