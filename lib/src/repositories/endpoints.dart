import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/services/storage_service.dart';

class Endpoints {
  static const String baseUrl =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com";

  //USERID
  static String userId =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
  //orderID
  static String orderID =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.orderID);
  //orderID
  static String orderCode =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.orderCode);

  static const String port81 = ":8081";
  static const String port82 = ":8082";
  static const String port88 = ":8088";
  static const String port89 = ":8089";
  static const String port80 = ":8088";
  static const String port83 = ":8083";
  static const String port84 = ":8084";
  static const String port90 = ":8090";
  static const String port94 = ":8094";

  static const String login = '$port81/auth/signin';
  static const String signup = '$port81/auth/signup';
  static const String verifyEmail =
      '$port88/chasescroll/verification/verify-token';

  static const String sendEmail = '$port88/chasescroll/verification/send-email';
  static const String changePassword =
      '$port88/chasescroll/verification/change-password';
  static const String getPost = '$port89/feed/get-user-and-friends-posts';
  static const String getUserProfile = '$port82/user/privateprofile';
  static const String createPost = '$port89/feed/create-post';
  static const String uploadImage = '$port90/resource-api/upload-image';

  //-------------------------------------------------------------------------//
  //---------------------------- Explore ------------------------------------//
  static const String getTopEvents = "$port84/events/get-top-events";
  static const String getAllEvents = "$port84/events/events";
  static const String getSuggestedUsers = "$port82/user/suggest-connections";
  static const String getAllCommunities = "$port83/group/group";

  static const String connectFriend = "$port82/user/send-friend-request";

  //--------------------------- Event Endpoint ------------------------------//
  static const String saveEvent = "$port84/events/save-event";

  static String savedEvents =
      "$port84/events/get-saved-events?typeID=${userId.toString()}&type=EVENT";

  static String myEvents = "$port84/events/joined-events/$userId";

  static String pastEvents = "$port84/events/get-past-events";

  static String corporateEvents =
      "$port84/events/events?eventType=Corporate_Event";
  static String socialEvents = "$port84/events/events?eventType=Social_Events";
  static String collegeEvents =
      "$port84/events/events?eventType=College_Events";
  static String virtualEvents =
      "$port84/events/events?eventType=Virtual_Events";
  static String religiousEvents =
      "$port84/events/events?eventType=Religious_Event";
  static String popupEvents = "$port84/events/events?eventType=Popup_Event";
  static String fundraisingEvents =
      "$port84/events/events?eventType=Fundraising_Event";
  static String festivalEvents = "$port84/events/events?eventType=Festival";
  static String communityEvents =
      "$port84/events/events?eventType=Community_Event";
  static String createEventTicket = "$port84/events/create-ticket";
  static String createWebUrlPaystack =
      "$port94/payments/payWithPaystack?orderCode=$orderCode&email=jken04680@gmail.com";
  static String createWebUrlStripe =
      "8094/payments/payWithStripe?orderId=$orderID";
  static String verifyPaymentPS =
      "$port94/payments/verifyPaystackTx?orderCode=$orderCode";
  static String verifyPaymentST =
      "$port94/payments/stripePaySuccess?orderId=$orderID";

  static String createEvent = "$port84/events/create-event";
  static String deleteFriend = "$port82/user/remove-friend";

  //community Endpoint
  static String joinedCommunity = "$port83/group/joined-groups";
}
