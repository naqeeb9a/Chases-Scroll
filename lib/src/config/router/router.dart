import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/commdata.dart';
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
import 'package:chases_scroll/src/screens/bottom_nav.dart';
import 'package:chases_scroll/src/screens/chat/chat.dart';
import 'package:chases_scroll/src/screens/chat/group_chat.dart';
import 'package:chases_scroll/src/screens/chat/group_chat_message.dart';
import 'package:chases_scroll/src/screens/chat/model.dart';
import 'package:chases_scroll/src/screens/chat/private_chat.dart';
import 'package:chases_scroll/src/screens/community/community_chat.dart';
import 'package:chases_scroll/src/screens/community/community_info.dart';
import 'package:chases_scroll/src/screens/community/create_community.dart';
import 'package:chases_scroll/src/screens/community/model/group_model.dart';
import 'package:chases_scroll/src/screens/community/report_community.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/add_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/edit_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/get_community_id_view.dart';
import 'package:chases_scroll/src/screens/event_screens/buying_event_ticket_screen/event_webview_screens.dart';
import 'package:chases_scroll/src/screens/event_screens/buying_event_ticket_screen/privacy_policy_screen.dart';
import 'package:chases_scroll/src/screens/event_screens/draft_event_views/draft_event_views.dart';
import 'package:chases_scroll/src/screens/event_screens/event_attendance_view.dart';
import 'package:chases_scroll/src/screens/event_screens/event_details_main_view.dart';
import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/trending_event.dart';
import 'package:chases_scroll/src/screens/home/comment/comment.dart';
import 'package:chases_scroll/src/screens/home/report_user.dart';
import 'package:chases_scroll/src/screens/notification/notification.dart';
import 'package:chases_scroll/src/screens/onboarding/explore.dart';
import 'package:chases_scroll/src/screens/onboarding/onboarding_screen.dart';
import 'package:chases_scroll/src/screens/onboarding/splashscreen.dart';
import 'package:chases_scroll/src/screens/profile_view/other_users_profile_main_view.dart';
import 'package:chases_scroll/src/screens/profile_view/see_more_community.dart';
import 'package:chases_scroll/src/screens/profile_view/see_more_event.dart';
import 'package:chases_scroll/src/screens/profile_view/see_more_user.dart';
import 'package:chases_scroll/src/screens/profile_view/settings.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/account_settings_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/blocked_users_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/change_password_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/edit_profile_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/eventDasboard/event_dashboard_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/privacy_policy_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/report_bug_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/request_enhancement_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/terms_&_condition_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/transaction_screen_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/wallet/wallet_setting_view.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/settings_payment_view.dart';
import 'package:chases_scroll/src/screens/widgets/success_screen.dart';
import 'package:chases_scroll/src/screens/widgets/three_dots_loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/event_screens/buying_event_ticket_screen/event_ticket_summary.dart';
import '../../screens/event_screens/buying_event_ticket_screen/payment_method_screen.dart';
import '../../screens/event_screens/buying_event_ticket_screen/payment_service_screen.dart';
import '../../screens/event_screens/buying_event_ticket_screen/refund_ticket_detail_screen.dart';
import '../../screens/event_screens/find_events/all_event_view.dart';
import '../../screens/expore_screens/widgets/search_explode_view.dart';
import '../../screens/expore_screens/widgets/suggestion_more_view.dart';
import '../../screens/profile_view/see_more_user_post.dart';

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
          path: AppRoutes.communityChat,
          name: AppRoutes.communityChat,
          builder: (_, __) =>
              CommunityChat(communityData: __.extra as CommunityData)),
      GoRoute(
          path: AppRoutes.communityInfo,
          name: AppRoutes.communityInfo,
          builder: (_, __) => CommunityInfo(
                communityInfoModel: __.extra as CommunityInfoModel,
              )),
      GoRoute(
          path: AppRoutes.createCommunity,
          name: AppRoutes.createCommunity,
          builder: (_, __) => CreateCommunity(
              communityInfoModel: __.extra as CommunityInfoModel)),
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
        builder: (_, __) => const BottomNavBar(),
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
        path: AppRoutes.chatScreen,
        name: AppRoutes.chatScreen,
        builder: (_, __) => const ChatScreen(),
      ),
      GoRoute(
        path: AppRoutes.createChat,
        name: AppRoutes.createChat,
        builder: (_, __) => CreateChat(),
      ),
      GoRoute(
        path: AppRoutes.comment,
        name: AppRoutes.comment,
        builder: (_, __) => Comment(
          commentData: __.extra as Map<dynamic, dynamic>,
          // path: AppRoutes.addEventView,
          // name: AppRoutes.addEventView,
          // builder: (_, __) => const AddEventView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.eventView,
        name: AppRoutes.eventView,
        builder: (_, __) => const EventMainView(),
      ),
      GoRoute(
        path: AppRoutes.reportCommunity,
        name: AppRoutes.reportCommunity,
        builder: (_, __) => ReportCommunity(
          typeId: __.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.reportPostUser,
        name: AppRoutes.reportPostUser,
        builder: (_, __) => ReportPostUser(
          typeId: __.extra as String,
        ),
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
          eventDetails: __.extra as EventContent,
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
        builder: (_, __) => WebViewPaystack(
          url: __.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.webEventStripe,
        name: AppRoutes.webEventStripe,
        builder: (_, __) => WebViewEventStripe(
          url: __.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.eventCommunityId,
        name: AppRoutes.eventCommunityId,
        builder: (_, __) => GetCommunityFunnelID(),
      ),
      GoRoute(
        path: AppRoutes.eventAttendeesView,
        name: AppRoutes.eventAttendeesView,
        builder: (_, __) => EventAttendeesView(
          eventDetails: __.extra as EventContent,
        ),
      ),
      GoRoute(
        path: AppRoutes.findTrendingEvent,
        name: AppRoutes.findTrendingEvent,
        builder: (_, __) => const FindTrendingEvents(),
      ),
      GoRoute(
          path: AppRoutes.privateChat,
          name: AppRoutes.privateChat,
          builder: (_, __) => PrivateChat(
                chatDataModel: __.extra as ChatDataModel,
              )),
      GoRoute(
          path: AppRoutes.groupChatMessage,
          name: AppRoutes.groupChatMessage,
          builder: (_, __) => GroupChatMessage(
                chatDataModel: __.extra as ChatDataModel,
              )),
      GoRoute(
          path: AppRoutes.notification,
          name: AppRoutes.notification,
          builder: (_, __) => const NotificationView()),
      GoRoute(
          path: AppRoutes.settings,
          name: AppRoutes.settings,
          builder: (_, __) => const SettingsScreenView()),
      GoRoute(
        path: AppRoutes.terms,
        name: AppRoutes.terms,
        builder: (_, __) => const TermsAndConditionScreenView(),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        name: AppRoutes.privacy,
        builder: (_, __) => const PrivacyPolicyScreenView(),
      ),
      GoRoute(
        path: AppRoutes.enhancement,
        name: AppRoutes.enhancement,
        builder: (_, __) => RequestEnhancementScreenView(),
      ),
      GoRoute(
        path: AppRoutes.reportBug,
        name: AppRoutes.reportBug,
        builder: (_, __) => ReportBugScreenView(),
      ),
      GoRoute(
        path: AppRoutes.accountSetting,
        name: AppRoutes.accountSetting,
        builder: (_, __) => const AccountSettingView(),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        name: AppRoutes.changePassword,
        builder: (_, __) => const ChangePasswordScreenView(),
      ),
      GoRoute(
        path: AppRoutes.settingPayment,
        name: AppRoutes.settingPayment,
        builder: (_, __) => const SettingsPaymentScreenView(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: AppRoutes.editProfile,
        builder: (_, __) => const EditProfileScreenView(),
      ),
      GoRoute(
        path: AppRoutes.profileUsersMore,
        name: AppRoutes.profileUsersMore,
        builder: (_, __) => const SeeMoreUserView(),
      ),
      GoRoute(
        path: AppRoutes.profileEventMore,
        name: AppRoutes.profileEventMore,
        builder: (_, __) => const SeeMoreUserEvents(),
      ),
      GoRoute(
        path: AppRoutes.profileCommmunityMore,
        name: AppRoutes.profileCommmunityMore,
        builder: (_, __) => const SeeMoreUserCommunities(),
      ),
      GoRoute(
        path: AppRoutes.otherUsersProfile,
        name: AppRoutes.otherUsersProfile,
        builder: (_, __) => OtherUsersMainProfileView(
          userId: __.extra as String,
        ),
      ),
      GoRoute(
        path: AppRoutes.transactionView,
        name: AppRoutes.transactionView,
        builder: (_, __) => const TransactionScreeView(),
      ),
      GoRoute(
        path: AppRoutes.settingsWallet,
        name: AppRoutes.settingsWallet,
        builder: (_, __) => const WalletSettingScreenView(),
      ),
      GoRoute(
        path: AppRoutes.eventByID,
        name: AppRoutes.eventByID,
        builder: (_, __) => const MyEventByIDView(),
      ),
      GoRoute(
        path: AppRoutes.addEventView,
        name: AppRoutes.addEventView,
        builder: (_, __) => const AddEventView(),
      ),
      GoRoute(
        path: AppRoutes.blockedUser,
        name: AppRoutes.blockedUser,
        builder: (_, __) => const BlockedUsersView(),
      ),
      GoRoute(
        path: AppRoutes.draftEvent,
        name: AppRoutes.draftEvent,
        builder: (_, __) => MyDraftEventView(),
      ),
      GoRoute(
        path: AppRoutes.draftEditEvent,
        name: AppRoutes.draftEditEvent,
        builder: (_, __) => EditEventView(
          eventDetails: __.extra as EventContent,
        ),
      ),
      GoRoute(
        path: AppRoutes.seeMoreUserPost,
        name: AppRoutes.seeMoreUserPost,
        builder: (_, __) => SeeMoreUserPost(
          userID: __.extra as String,
        ),
      ),
    ]);
