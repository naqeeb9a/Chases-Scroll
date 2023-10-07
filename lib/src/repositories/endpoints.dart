class Endpoints {
  static const String baseUrl =
      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com";

  static const String port81 = ":8081";
  static const String port82 = ":8082";
  static const String port88 = ":8088";
  static const String port89 = ":8089";
  static const String port80 = ":8080";
  static const String port90 = ":8090";
  static const String displayImages = '$baseUrl$port80/resource-api/download';
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
  static const String addComment = '$port89/feed/add-comment';
  static const String getPostComment = '$port89/feed/get-all-comments';
  static const String uploadVideo = '$port90/resource-api/upload-video';
  static const String likePost = '$port89/feed/like-post';
  static const String suggest = '$port80/user/suggest-connections';
  static const String sharePost = '$port89/feed/share-post';
  static const String removePost = '$port89/feed/remove-post';
  static const String editPost = '$port89/feed/edit-post';

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
