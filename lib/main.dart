import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';
import 'core/routes/app_launch_destination.dart';
import 'core/routes/app_routes.dart';
import 'core/usecases/usecase.dart';
import 'features/splash/domain/usecases/resolve_initial_route_usecase.dart';
import 'injection_container.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash immediately during startup
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Service Locator dependencies
  await initDependencies();

  // Read session / onboarding flags via ResolveInitialRouteUseCase
  final resolveInitialRouteUseCase = sl<ResolveInitialRouteUseCase>();
  final destinationResult = await resolveInitialRouteUseCase(const NoParams());

  final String initialRoute = destinationResult.fold(
    (failure) => AppRoutes.onboarding,
    (destination) {
      switch (destination) {
        case AppLaunchDestination.onboarding:
          return AppRoutes.onboarding;
        case AppLaunchDestination.login:
          return AppRoutes.login;
        case AppLaunchDestination.dashboard:
          return AppRoutes.mainShell;
      }
    },
  );

  // Once initial route is decided, remove native splash to transition seamlessly
  FlutterNativeSplash.remove();

  runApp(MyCampusApp(initialRoute: initialRoute));
}
