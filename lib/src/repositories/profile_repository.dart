import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/blockedUser_model.dart';
import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/models/transaction_model.dart';
import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';

class ProfileRepository {
  //USERID
  static String userId =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

  final _storage = locator<LocalStorageService>();

  //this is to get all user connections
  List<ContentUser> allUserConnections = [];

  //this is to get all connection request
  List<ContentUser> allUserRequests = [];

  //for gettting community ID
  List<CommContent> joinedCommunityList = [];

  List<Content> getUserPost = [];

  UserModel? userProfile;

  //for gettting transactions
  List<TransactionHistory> getTransactions = [];

  //for gettting blocked Users
  List<BlockedModel> blockedUsers = [];

  //edit account settings
  Future<bool> accountSetting({
    final bool? publicProfile,
  }) async {
    final data = {
      "publicProfile": publicProfile,
    };
    final response = await ApiClient.put(
      Endpoints.editProfile,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      _storage.saveDataToDisk(
          AppKeys.profileBoolean, response.message['publicProfile']);

      log("see result here====> ${response.message['publicProfile']}");
      return true;
    }
    return false;
  } //resetPassword

  //this is editprofile
  Future<bool> editProfile({
    final String? firstName,
    final String? lastName,
    final String? username,
    final bool? showEmail,
    final String? phone,
    final String? gender,
    final String? webAddress,
    final String? about,
  }) async {
    final data = {
      "firstName": firstName,
      "showEmail": showEmail,
      "lastName": lastName,
      "username": username,
      "data": {
        "mobilePhone": {"objectPublic": true, "value": phone},
        "gender": {"objectPublic": true, "value": gender},
        "webAddress": {"objectPublic": true, "value": webAddress},
        "about": {"objectPublic": true, "value": about},
      }
    };
    final response = await ApiClient.post(
      Endpoints.unSaveEvent,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }

  //this is editprofile
  Future<bool> editProfilImage({
    final String? profileImageRef,
  }) async {
    final data = {};

    String url =
        "${Endpoints.editProfileImage}?profileImageRef=$profileImageRef";
    final response = await ApiClient.put(
      url,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }

  //get bloackedUsers
  Future<List<BlockedModel>> getblockedUsers() async {
    String url = "${Endpoints.blockedList}?size=10";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> block = response.message['content'];
      // log(allEvents.toString());
      blockedUsers = block
          .map<BlockedModel>((user) => BlockedModel.fromJson(user))
          .toList();

      return blockedUsers;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getConnectionRequest(String? page) async {
    String url = "${Endpoints.getUserConnectionRequests}/?size=$page";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> userConnections = response.message['content'];

      return userConnections;
    } else {
      return [];
    }
  }

  //reset password
  Future<dynamic> getEventAnalytic({
    final String? eventId,
  }) async {
    String url = "${Endpoints.analyticEvent}?eventID=$eventId";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return response.message;
    } else {
      return response.message;
    }
  }

  //getJOined Communities
  Future<List<CommContent>> getJoinedCommunity() async {
    String url = "${Endpoints.joinedCommunity}?userID=$userId";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> eventCommunityId = response.message['content'];
      // log(allEvents.toString());
      joinedCommunityList = eventCommunityId
          .map<CommContent>((event) => CommContent.fromJson(event))
          .toList();

      return joinedCommunityList;
    } else {
      return [];
    }
  }

  //get userConnections
  Future<List<ContentUser>> getOtherUsersConnections({String? userID}) async {
    String url = "${Endpoints.getUserConnections}/$userID";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> userConnections = response.message['content'];
      // log(allEvents.toString());
      allUserConnections = userConnections
          .map<ContentUser>((user) => ContentUser.fromJson(user))
          .toList();

      return allUserConnections;
    } else {
      return [];
    }
  }

  //getJOined Communities
  Future<List<CommContent>> getOtherUsersJoinedCommunity(
      {String? userID}) async {
    String url = "${Endpoints.joinedCommunity}?userID=$userID";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> eventCommunityId = response.message['content'];
      // log(allEvents.toString());
      joinedCommunityList = eventCommunityId
          .map<CommContent>((event) => CommContent.fromJson(event))
          .toList();

      return joinedCommunityList;
    } else {
      return [];
    }
  }

  //to get user post
  Future<List<Content>> getOtherUsersPosts(
      {String? userID, String? page}) async {
    String? url = "${Endpoints.getUserPost}?userID=$userID&page=$page";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> allpostUser = response.message['content'];
      // log(allEvents.toString());
      getUserPost =
          allpostUser.map<Content>((post) => Content.fromJson(post)).toList();
      return getUserPost;
    }
    return [];
  }

  //get others  user Profile
  Future<UserModel?> getOtherUsersProfile({String? userID}) async {
    String url = "${Endpoints.getOtherUsersProfile}/$userID";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final Map<String, dynamic> userProfileMap = response.message;
      final userProfile = UserModel.fromJson(userProfileMap);

      log("here is the user profile ====> $userProfile");
      return userProfile;
    }
    return userProfile;
  }

  //get transaction
  Future<List<TransactionHistory>> getTransactionHistory() async {
    final response =
        await ApiClient.get(Endpoints.getTransactions, useToken: true);

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> transactions = response.message['content'];
      // log(allEvents.toString());
      getTransactions = transactions
          .map<TransactionHistory>(
              (event) => TransactionHistory.fromJson(event))
          .toList();

      return getTransactions;
    } else {
      return [];
    }
  }

  //get userConnections
  Future<List<ContentUser>> getUserConnections() async {
    String url = "${Endpoints.getUserConnections}/$userId";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> userConnections = response.message['content'];
      // log(allEvents.toString());
      allUserConnections = userConnections
          .map<ContentUser>((user) => ContentUser.fromJson(user))
          .toList();

      return allUserConnections;
    } else {
      return [];
    }
  }

  //get userConnections
  // Future<List<ContentUser>> getUserConnectionsRequest() async {
  //   String url = "${Endpoints.getUserConnectionRequests}?size=10";
  //   final response = await ApiClient.get(url, useToken: true);

  //   if (response.status == 200) {
  //     final List<dynamic> userRequests = response.message['content'];
  //     // log(allEvents.toString());
  //     allUserRequests = userRequests
  //         .map<ContentUser>((user) => ContentUser.fromJson(user))
  //         .toList();

  //     return allUserRequests;
  //   } else {
  //     return [];
  //   }
  // }

  //to get user post
  Future<List<Content>> getUserPosts({String? page}) async {
    String? url = "${Endpoints.getUserPost}?userID=$userId&page=$page";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> allpostUser = response.message['content'];
      // log(allEvents.toString());
      getUserPost =
          allpostUser.map<Content>((post) => Content.fromJson(post)).toList();
      return getUserPost;
    }
    return [];
  }

  //get user Profile
  Future<UserModel?> getUserProfile() async {
    final response = await ApiClient.get(
      Endpoints.getUserProfile,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final Map<String, dynamic> userProfileMap = response.message;
      final userProfile = UserModel.fromJson(userProfileMap);

      log("here is the user profile ====> $userProfile");
      _storage.saveDataToDisk(
          AppKeys.fullName, "${userProfile.firstName} ${userProfile.lastName}");
      _storage.saveDataToDisk(AppKeys.email, response.message['email']);
      _storage.saveDataToDisk(AppKeys.username, "${userProfile.username}");
      return userProfile;
    }
    return userProfile;
  }

  //report bug
  Future<bool> reportBug({
    final String? title,
    final String? description,
  }) async {
    final data = {
      "title": title,
      "description": description,
      "reportType": "REPORT_BUG",
      "typeID": userId
    };
    final response = await ApiClient.post(
      Endpoints.report,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }

  //report bug
  Future<bool> reportEnhancement({
    final String? title,
    final String? description,
  }) async {
    final data = {
      "title": title,
      "description": description,
      "reportType": "REPORT_ENHANCEMENT",
      "typeID": userId
    };
    final response = await ApiClient.post(
      Endpoints.report,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }

  //reset password
  Future<bool> resetPassword({
    final String? oldPassword,
    final String? newPassword,
  }) async {
    final data = {"oldPassword": oldPassword, "newPassword": newPassword};
    final response = await ApiClient.put(
      Endpoints.resetPassword,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }

  //reset password
  Future<bool> unblockUser({
    final String? userID,
  }) async {
    String url = "${Endpoints.blockedUsers}/$userID";
    final response = await ApiClient.delete(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log(response.message.toString());
      return true;
    }
    return false;
  }
}
