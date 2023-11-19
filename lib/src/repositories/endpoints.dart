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
  static const String getUserPost = 'feed/get-users-media-posts';
  static const String getUserProfile = 'user/privateprofile';
  static const String getOtherUsersProfile = '/user/publicprofile';
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

  //-------------------------------------------------------------------------//
  //---------------------------- Explore ------------------------------------//
  static const String getTopEvents = "events/get-top-events";
  static const String getAllEvents = "events/events";
  static const String getSuggestedUsers = "user/suggest-connections";
  static const String getAllCommunities = "group/group";

  static const String connectFriend = "/user/send-friend-request";
  static const String disconnectFriend = "user/remove-friend";
  static const String acceptFriend = "user/accept-friend-request";
  static const String rejectFriend = "user/reject-friend-request";
  static const String blockFriend = "user/block";

  //--------------------------- Event Endpoint ------------------------------//
  static const String saveEvent = "events/save-event";
  static const String unSaveEvent = "events/remove-saved-event";

  static String savedEvents = "events/get-saved-events";

  static String myEvents = "events/joined-events";

  static String pastEvents = "events/get-past-events";

  static String corporateEvents = "/events/events?eventType=Corporate_Event";
  static String socialEvents = "/events/events?eventType=Social_Events";
  static String collegeEvents = "/events/events?eventType=College_Events";
  static String virtualEvents = "/events/events?eventType=Virtual_Events";
  static String religiousEvents = "/events/events?eventType=Religious_Event";
  static String popupEvents = "/events/events?eventType=Popup_Event";
  static String fundraisingEvents =
      "/events/events?eventType=Fundraising_Event";
  static String festivalEvents = "/events/events?eventType=Festival";
  static String communityEvents = "/events/events?eventType=Community_Event";
  static String createEventTicket = "/events/create-ticket";
  static String createWebUrlPaystack = "payments/payWithPaystack";
  static String createWebUrlStripe = "payments/payWithStripe";

  //-----------------------create && draft ------------------------------
  static String createDraft = "events/create-draft";
  static String updateDraft = "/events/update-draft";
  static String createEvent = "events/create-event-from-draft";
  static String getDraftEvent = "events/drafts";
  static String deleteDraft = "/events/delete-draft";

  //verifyEventPayment
  static String verifyEventPaystack = "payments/verifyPaystackTx";
  static String verifyEventStripe = "payments/stripePaySuccess";
  static String deleteFriend = "/user/remove-friend";
  static String getEventMembers = "/events/get-event-members";

  //community Endpoint
  static String joinedCommunity = "/group/joined-groups";
  static String leaveCommunity = "/group/leave-group";

  //for profile settings
  static String getUserConnections = "/user/get-users-connections";
  static String getUserConnectionRequests = "user/friend-requests";
  static String editProfile = "user/update-profile";
  static String editProfileImage = "user/update-main-profile-image";
  static String resetPassword = "chasescroll/verification/reset-password";
  static String getPrivateUserProfile = "user/privateprofile";
  static String getTransactions = "payments/transactions";
  static String getEventsDashboard = "events/events";
  static String report = "report/report";
  static String blockedList = "user/blocklist";
  static String blockedUsers = "user/delete-block";
  static String getConnectionRequest = "user/friend-requests";

  //wallet
  static String getTransactionsWallet = "payments/history";
  static String escrowAddStatus = "payments/orders";
  static String getEscrowBalances = "escrow/balances";
  static String fundWallet = "payments/api/wallet/fundWallet";
  static String onboardPaystack = "payments/account/onboardPaystack";
  static String checkPaystack = "payments/account/checkPaystack";
  static String withdrawWallet = "payments/account/withdraw";
  static String walletBalances = "payments/api/wallet/balance";
  static String accountStatus = "payments/account/check";
  static String deleteBlock = "user/delete-block";
  static String verifyFund = "payments/api/wallet/verifyFundWallet";
  static String onboardStripe = "payments/account/oauthOnboard";

  //analytics
  static String analyticEvent = "payments/analytics/tickets";
}
