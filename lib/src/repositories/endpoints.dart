class Endpoints {
  static const String baseUrl =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com";

  static const String port81 = ":8081";
  static const String port88 = ":8088";
  static const String port89 = ":8089";
  static const String port80 = ":8088";

  static const String login = '$port81/auth/signin';
  static const String signup = '$port81/auth/signup';
  static const String verifyEmail =
      '$port88/chasescroll/verification/verify-token';

  static const String sendEmail = '$port88/chasescroll/verification/send-email';
  static const String changePassword =
      '$port88/chasescroll/verification/change-password';

  static const String getPost = '$port89/feed/get-user-and-friends-posts';
  static const String getTopEvents =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8084/events/get-top-events";
}
