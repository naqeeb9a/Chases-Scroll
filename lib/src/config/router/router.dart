import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/screens/auth_screens/data.dart';
import 'package:chases_scroll/src/screens/auth_screens/email_screen.dart';
import 'package:chases_scroll/src/screens/auth_screens/forgot_password.dart';
import 'package:chases_scroll/src/screens/auth_screens/new_password.dart';
import 'package:chases_scroll/src/screens/auth_screens/password_screen.dart';
import 'package:chases_scroll/src/screens/auth_screens/pincode.dart';
import 'package:chases_scroll/src/screens/auth_screens/signup.dart';
import 'package:chases_scroll/src/screens/auth_screens/signup_two.dart';
import 'package:chases_scroll/src/screens/auth_screens/success_password.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/add_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/get_community_id_view.dart';
import 'package:chases_scroll/src/screens/event_screens/buying_event_ticket_screen/event_webview_screens.dart';
import 'package:chases_scroll/src/screens/event_screens/buying_event_ticket_screen/privacy_policy_screen.dart';
import 'package:chases_scroll/src/screens/event_screens/event_details_main_view.dart';
import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:chases_scroll/src/screens/onboarding/explore.dart';
import 'package:chases_scroll/src/screens/onboarding/onboarding_screen.dart';
import 'package:chases_scroll/src/screens/onboarding/splashscreen.dart';
import 'package:chases_scroll/src/screens/widgets/success_screen.dart';
import 'package:chases_scroll/src/screens/widgets/three_dots_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/bottom_nav.dart';
import '../../screens/event_screens/buying_event_ticket_screen/event_ticket_summary.dart';
import '../../screens/event_screens/buying_event_ticket_screen/payment_method_screen.dart';
import '../../screens/event_screens/buying_event_ticket_screen/payment_service_screen.dart';
import '../../screens/event_screens/buying_event_ticket_screen/refund_ticket_detail_screen.dart';
import '../../screens/event_screens/find_events/all_event_view.dart';
import '../../screens/expore_screens/widgets/search_explode_view.dart';
import '../../screens/expore_screens/widgets/suggestion_more_view.dart';

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
          builder: (_, __) => EmailScreen()),
      GoRoute(
          path: AppRoutes.passwordScreen,
          name: AppRoutes.passwordScreen,
          builder: (_, __) => PasswordScreen(
                email: __.extra as String,
              )),
      GoRoute(
          path: AppRoutes.signupone,
          name: AppRoutes.signupone,
          builder: (_, __) => SignupScreen()),
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
          builder: (_, __) => PinCodeScreen(
                isSignup: __.extra as bool,
              )),
      GoRoute(
        path: AppRoutes.newPassword,
        name: AppRoutes.newPassword,
        builder: (_, __) => NewPassword(
          token: __.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.successPassword,
        name: AppRoutes.successPassword,
        builder: (_, __) => const SuccessPassword(),
      ),
      GoRoute(
        path: AppRoutes.bottomNav,
        name: AppRoutes.bottomNav,
        builder: (_, __) => const BottomNav(),
      ),
      GoRoute(
        path: AppRoutes.suggestionFriendMore,
        name: AppRoutes.suggestionFriendMore,
        builder: (_, __) => const SuggestionFriendMore(), //SearchExploreView
      ),
      GoRoute(
        path: AppRoutes.searchExploreView,
        name: AppRoutes.searchExploreView,
        builder: (_, __) => const SearchExploreView(),
      ),
      GoRoute(
        path: AppRoutes.addEventView,
        name: AppRoutes.addEventView,
        builder: (_, __) => const AddEventView(),
      ),
      GoRoute(
        path: AppRoutes.eventView,
        name: AppRoutes.eventView,
        builder: (_, __) => const EventMainView(),
      ),
      GoRoute(
        path: AppRoutes.allEventView,
        name: AppRoutes.allEventView,
        builder: (_, __) => const FindAllEventsView(),
      ),
      GoRoute(
        path: AppRoutes.eventTicketSummaryScreen,
        name: AppRoutes.eventTicketSummaryScreen,
        builder: (_, __) => const EventTicketSummaryScreen(),
      ),
      GoRoute(
        path: AppRoutes.eventDetailMainView,
        name: AppRoutes.eventDetailMainView,
        builder: (_, __) => EventDetailsMainView(
          eventDetails: __.extra as Content,
        ),
      ),
      GoRoute(
        path: AppRoutes.eventTicketPrivacyPolicyScreen,
        name: AppRoutes.eventTicketPrivacyPolicyScreen,
        builder: (_, __) => EventTicketPrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppRoutes.threeLoadingDotsScreen,
        name: AppRoutes.threeLoadingDotsScreen,
        builder: (_, __) => ThreeLoadingDotsScreen(
          screen: __.extra as Widget,
        ),
      ),
      GoRoute(
        path: AppRoutes.eventSuccessScreen,
        name: AppRoutes.eventSuccessScreen,
        builder: (_, __) => EventSuccessScreenView(
          widgetScreenString: __.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.paymentMethodScreen,
        name: AppRoutes.paymentMethodScreen,
        builder: (_, __) => const PaymentMethodScreenView(),
      ),
      GoRoute(
        path: AppRoutes.refundBoughtDetailScreen,
        name: AppRoutes.refundBoughtDetailScreen,
        builder: (_, __) => const RefundTicketDetailScreen(),
      ),
      GoRoute(
        path: AppRoutes.currencyPaymentScreen,
        name: AppRoutes.currencyPaymentScreen,
        builder: (_, __) => const CardCurrencyScreenView(),
      ),
      GoRoute(
        path: AppRoutes.webEventPayStack,
        name: AppRoutes.webEventPayStack,
        builder: (_, __) => PaymentPaystackView(
          url: __.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.eventCommunityId,
        name: AppRoutes.eventCommunityId,
        builder: (_, __) => GetCommunityFunnelID(),
      ),
    ]);
