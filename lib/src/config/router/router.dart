import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/auth_screens/data.dart';
import 'package:chases_scroll/src/screens/auth_screens/email_screen.dart';
import 'package:chases_scroll/src/screens/auth_screens/forgot_password.dart';
import 'package:chases_scroll/src/screens/auth_screens/password_screen.dart';
import 'package:chases_scroll/src/screens/auth_screens/pincode.dart';
import 'package:chases_scroll/src/screens/auth_screens/signup.dart';
import 'package:chases_scroll/src/screens/auth_screens/signup_two.dart';
import 'package:chases_scroll/src/screens/onboarding/explore.dart';
import 'package:chases_scroll/src/screens/onboarding/onboarding_screen.dart';
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
          builder: (_, __) => const OnboardingScreen()),
      GoRoute(
          path: AppRoutes.explore,
          name: AppRoutes.explore,
          builder: (_, __) => const ExploreScreen()),
      GoRoute(
          path: AppRoutes.emailScreen,
          name: AppRoutes.emailScreen,
          builder: (_, __) => const EmailScreen()),
      GoRoute(
          path: AppRoutes.passwordScreen,
          name: AppRoutes.passwordScreen,
          builder: (_, __) => PasswordScreen(
                email: __.extra as String,
              )),
      GoRoute(
          path: AppRoutes.signupone,
          name: AppRoutes.signupone,
          builder: (_, __) => const SignupScreen()),
      GoRoute(
          path: AppRoutes.signuptwo,
          name: AppRoutes.signuptwo,
          builder: (_, __) => SignupTwoScreen(
                signupData: __.extra as SignupOneModel,
              )),
      GoRoute(
          path: AppRoutes.forgotPassword,
          name: AppRoutes.forgotPassword,
          builder: (_, __) => const ForgotPasswordScreen()),
      GoRoute(
          path: AppRoutes.pincode,
          name: AppRoutes.pincode,
          builder: (_, __) => const PinCodeScreen()),
    ]);
