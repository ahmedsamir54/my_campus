import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/theme_cubit.dart';

// Dashboard feature
import 'features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/domain/repositories/dashboard_repository.dart';
import 'features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'features/dashboard/domain/usecases/register_event_usecase.dart';
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';

// Routine feature
import 'features/routine/data/datasources/routine_local_data_source.dart';
import 'features/routine/data/datasources/routine_remote_data_source.dart';
import 'features/routine/data/repositories/routine_repository_impl.dart';
import 'features/routine/domain/repositories/routine_repository.dart';
import 'features/routine/domain/usecases/get_weekly_routine_usecase.dart';
import 'features/routine/domain/usecases/select_routine_day_usecase.dart';
import 'features/routine/presentation/cubit/routine_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! Core
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sharedPreferences: sl()));

  //! Feature: Dashboard
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetDashboardDataUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => RegisterEventUseCase(repository: sl()),
  );
  sl.registerFactory(
    () => DashboardCubit(
      getDashboardDataUseCase: sl(),
      registerEventUseCase: sl(),
    ),
  );

  //! Feature: Routine
  sl.registerLazySingleton<RoutineRemoteDataSource>(
    () => RoutineRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<RoutineLocalDataSource>(
    () => RoutineLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<RoutineRepository>(
    () => RoutineRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetWeeklyRoutineUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => SelectRoutineDayUseCase(repository: sl()),
  );
  sl.registerFactory(
    () => RoutineCubit(
      getWeeklyRoutineUseCase: sl(),
      selectRoutineDayUseCase: sl(),
    ),
  );
}
