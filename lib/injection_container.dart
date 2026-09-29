import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/theme_cubit.dart';
import 'features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/domain/repositories/dashboard_repository.dart';
import 'features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'features/dashboard/domain/usecases/register_event_usecase.dart';
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! Core
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sharedPreferences: sl()));

  //! Feature: Dashboard
  // Data Sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GetDashboardDataUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => RegisterEventUseCase(repository: sl()),
  );

  // Cubits / ViewModels
  sl.registerFactory(
    () => DashboardCubit(
      getDashboardDataUseCase: sl(),
      registerEventUseCase: sl(),
    ),
  );
}
