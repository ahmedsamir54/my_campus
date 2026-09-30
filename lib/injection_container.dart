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

// Attendance feature
import 'features/attendance/data/datasources/attendance_local_data_source.dart';
import 'features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'features/attendance/data/repositories/attendance_repository_impl.dart';
import 'features/attendance/domain/repositories/attendance_repository.dart';
import 'features/attendance/domain/usecases/get_attendance_data_usecase.dart';
import 'features/attendance/domain/usecases/simulate_absence_usecase.dart';
import 'features/attendance/presentation/cubit/attendance_cubit.dart';

// Profile feature
import 'features/profile/data/datasources/profile_local_data_source.dart';
import 'features/profile/data/datasources/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_student_profile_usecase.dart';
import 'features/profile/domain/usecases/toggle_settings_usecases.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';

// Auth feature
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/biometric_login_usecase.dart';
import 'features/auth/domain/usecases/login_with_credentials_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

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

  //! Feature: Attendance
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AttendanceLocalDataSource>(
    () => AttendanceLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAttendanceDataUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => SimulateAbsenceUseCase(repository: sl()),
  );
  sl.registerFactory(
    () => AttendanceCubit(
      getAttendanceDataUseCase: sl(),
      simulateAbsenceUseCase: sl(),
    ),
  );

  //! Feature: Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetStudentProfileUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => ToggleBiometricsUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => ToggleNotificationsUseCase(repository: sl()),
  );
  sl.registerFactory(
    () => ProfileCubit(
      getStudentProfileUseCase: sl(),
      toggleBiometricsUseCase: sl(),
      toggleNotificationsUseCase: sl(),
    ),
  );

  //! Feature: Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LoginWithCredentialsUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => BiometricLoginUseCase(repository: sl()),
  );
  sl.registerFactory(
    () => AuthCubit(
      loginWithCredentialsUseCase: sl(),
      biometricLoginUseCase: sl(),
      authRepository: sl(),
    ),
  );
}


