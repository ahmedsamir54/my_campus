import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/attendance/presentation/cubit/attendance_cubit.dart';
import '../../features/attendance/presentation/pages/attendance_page.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/navigation/presentation/main_navigation_shell.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../injection_container.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String mainShell = '/main';
  static const String attendance = '/attendance';
  static const String assignments = '/assignments';
  static const String academics = '/academics';
  static const String events = '/events';
  static const String services = '/services';
  static const String notices = '/notices';
  static const String routine = '/routine';
  static const String profile = '/profile';
  static const String messaging = '/messaging';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: const LoginPage(),
          ),
          settings: settings,
        );
      case mainShell:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationShell(),
          settings: settings,
        );
      case attendance:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AttendanceCubit>()..loadAttendance(),
            child: const AttendancePage(),
          ),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ProfileCubit>()..loadProfile(),
            child: const ProfilePage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Under Construction')),
            body: Center(
              child: Text(
                'Route "${settings.name}" is planned on the roadmap.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          settings: settings,
        );
    }
  }
}
