class Endpoints {
  static const String baseUrl =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com";

  static const String port81 = ":8081";
  static const String port88 = ":8088";
  static const String port80 = ":8088";

  static const String login = '$port81/auth/signin';
  static const String signup = '$port81/auth/signup';
  static const String verifyEmail =
      '$port88/chasescroll/verification/verify-token';

  static const String sendEmail = '$port88/chasescroll/verification/send-email';
  static const String changePassword =
      '$port88/chasescroll/verification/change-password';

  //------------------------------------------------------------------------//
  //---------------------------- Explore ------------------------------------//
  static const String getTopEvents =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8084/events/get-top-events";
  static const String getAllEvents =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8084/events/events";
  static const String getSuggestedUsers =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8082/user/suggest-connections";
  static const String getAllCommunities =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8083/group/group";
}
