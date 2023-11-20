class Endpoints {
  // static const String baseUrl =
  //     "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com";
  // https://chaseenv.chasescroll.com/

  static const String baseUrl = "https://chaseenv.chasescroll.com/";

  static const String port81 = ":8081";
  static const String port82 = ":8082";
  static const String port88 = ":8088";
  static const String port89 = ":8089";
  static const String port80 = ":8080";

  static const String port83 = ":8083";
  static const String port84 = ":8084";
  static const String port90 = ":8090";
  static const String displayImages = '${baseUrl}resource-api/download/';
  static const String login = 'auth/signin';
  static const String signup = 'auth/signup';
  static const String verifyEmail = 'chasescroll/verification/verify-token';
  static const String port94 = ":8094";

  static const String sendEmail = 'chasescroll/verification/send-email';
  static const String changePassword =
      'chasescroll/verification/change-password';
  static const String getPost = 'feed/get-user-and-friends-posts';
  static const String getUserProfile = 'user/privateprofile';
  static const String createPost = 'feed/create-post';
  static const String uploadImage = 'resource-api/upload-image';
  static const String uploadFile = 'resource-api/upload';
  static const String addComment = 'feed/add-comment';
  static const String getPostComment = 'feed/get-all-comments';
  static const String uploadVideo = 'resource-api/upload-video';
  static const String likePost = 'feed/like-post';
  static const String suggest = 'user/suggest-connections';
  static const String sharePost = 'feed/share-post';
  static const String removePost = 'feed/remove-post';
  static const String editPost = 'feed/edit-post';
  static const String createCommunity = 'group/create-group';
  static const String joinedGroup = 'group/joined-groups';
  static const String getRequestGroup = 'group/get-requests';
  static const String findGroup = 'group/find-groups';
  static const String getGroupPost = 'feed/get-all-group-posts?groupID=';
  static const String joinCommunity = 'group/join-group';
  static const String leaveGroup = '/group/leave-group';
  static const String getGroupMembers = 'group/get-group-members?groupID=';
  static const String subComment = 'feed/add-sub-comment';
  static const String editCommunity = '/group/update-group';
  static const String getChat = "chat/chat";
  static const String sendChat = "chat/message";
  static const String getChatMessage = "chat/message";
  static const String getSuggestedUsers = "user/suggest-connections";
  static const String userFriends = "user/get-users-connections";
  static const String likeComment = "feed/like-comment";
  static const String getSubComment = "feed/get-all-sub-comments";
  static const String notifications = "notifications/notification";
  static const String report = "report/report";
  static const String resolveRequest = "group/resolve-request";

  //-------------------------------------------------------------------------//
  //---------------------------- Explore ------------------------------------//
  static const String getTopEvents = "$port84/events/get-top-events";
  static const String getAllEvents = "$port84/events/events";

  static const String getAllCommunities = "$port83/group/group";

  static const String connectFriend = "$port82/user/send-friend-request";
  static const String disconnectFriend = "$port82/user/remove-friend";

  //--------------------------- Event Endpoint ------------------------------//
  static const String saveEvent = "$port84/events/save-event";
  static const String unSaveEvent = "$port84/events/remove-saved-event";

  static String savedEvents = "$port84/events/get-saved-events";

  static String myEvents = "$port84/events/joined-events";

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
  static String createWebUrlPaystack = "$port94/payments/payWithPaystack";
  static String createWebUrlStripe = "$port94/payments/payWithStripe";

  static String createEvent = "$port84/events/create-event";
  static String deleteFriend = "$port82/user/remove-friend";
  static String getEventMembers = "$port84/events/get-event-members";

  //community Endpoint
  static String joinedCommunity = "$port83/group/joined-groups";

  static String leaveCommunity = "$port83/group/leave-group";
}
