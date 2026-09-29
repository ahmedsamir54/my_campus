import 'package:flutter/material.dart';

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
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route under construction')),
      ),
      settings: settings,
    );
  }
}
