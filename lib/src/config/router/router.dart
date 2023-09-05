import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/onboarding/onboarding.dart';
import 'package:chases_scroll/src/screens/onboarding/splashscreen.dart';
import 'package:go_router/go_router.dart';

GoRouter router() => GoRouter(routes: <GoRoute>[
      GoRoute(
          path: AppRoutes.splashscreen,
          name: AppRoutes.splashscreen,
          builder: (_, __) => const SplashScreenView()),
      GoRoute(
          path: AppRoutes.onboarding,
          name: AppRoutes.onboarding,
          builder: (_, __) => const OnboardingScreen())
    ]);
