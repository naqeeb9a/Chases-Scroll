import 'dart:convert';
import 'dart:developer';

import 'package:chases_scroll/src/models/group_model.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/members.dart';
import 'endpoints.dart';

class CommunityRepo {
  Future<bool> acceptOrRejectCommunity(
      {required String communityId, required bool resolve}) async {
    var body = {"id": communityId, "resolve": resolve};

    final response = await ApiClient.post(Endpoints.resolveRequest,
        body: body, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log(response.message.toString());
      return true;
    }
    return false;
  }

  Future<bool> createCommunity(
      {required String name,
      required bool isPublic,
      required String mulitpleMedia,
      required String description}) async {
    var data = {
      "data": {
        "address": "",
        "contactNumber": "",
        "email": "",
        "name": name,
        "password": "",
        "isPublic": isPublic,
        "imgSrc": mulitpleMedia,
        "description": description
      }
    };

    final response = await ApiClient.post(Endpoints.createCommunity,
        body: data, useToken: true);

    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future createPost(String text, String groupId, String sourceId,
      String? mediaRef, List<String>? multipleMediaRef, String? type) async {
    var body = {
      "text": text,
      "type": type,
      "isGroupFeed": true,
      "sourceId": sourceId,
      'groupId': groupId,
      "mediaRef": mediaRef,
      "multipleMediaRef": multipleMediaRef,
    };
    log(body.toString());

    final response =
        await ApiClient.post(Endpoints.createPost, body: body, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return true;
    }
    return false;
  }

  Future<bool> editCommunity(
      {required String name,
      required communityId,
      required bool isPublic,
      required String multipleMedia,
      required String description}) async {
    var data = {
      "groupID": communityId,
      "groupData": {
        "name": name,
        "isPublic": isPublic,
        "imgSrc": multipleMedia,
        "description": description
      }
    };

    final response = await ApiClient.put(Endpoints.editCommunity,
        body: data, useToken: true);

    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<GroupModel> findCommunity() async {
    final response = await ApiClient.get(
      Endpoints.findGroup,
      useToken: true,
    );
    if (response.status == 200) {
      log(response.message.toString());
      return GroupModel.fromJson(response.message);
    }
    return GroupModel();
  }

  Future<GroupModel> getGroup({String? userId, String? search}) async {
    final response = await ApiClient.get(
      '${Endpoints.joinedGroup}?userID=$userId',
      useToken: true,
    );

    if (response.status == 200) {
      log("#############################");
      log(response.message.toString());
      return GroupModel.fromJson(response.message);
    }
    return GroupModel();
  }

  Future<PostModel> getGroupChat(String? id) async {
    String endpoint = '${Endpoints.getGroupPost}$id';
    final response = await ApiClient.get(
      endpoint,
      useToken: true,
    );

    if (response.status == 200) {
      log("#############################");
      log(response.message.toString());
      return PostModel.fromJson(response.message);
    }
    return PostModel();
  }

  Future<GroupMembers> getGroupMembers(String communityId) async {
    final response = await ApiClient.get(
      '${Endpoints.getGroupMembers}$communityId',
      useToken: true,
    );
    if (response.status == 200) {
      log(response.message.toString());
      return GroupMembers.fromJson(response.message);
    }
    return GroupMembers();
  }

  Future<bool> joinCommunity({
    required String groupId,
    required String userId,
  }) async {
    var data = {"groupID": groupId, "joinID": userId};
    log(data.toString());

    final response = await ApiClient.post(Endpoints.joinCommunity,
        body: data, useToken: true);

    if (response.status == 200) {
      return true;
    }
    return false;
  }

  launchLink(String uri) async {
    final Uri url = Uri.parse(uri);
    try {
      await launchUrl(url);
    } catch (e) {
      ToastResp.toastMsgError(resp: "Something went wrong");
    }
  }

  void launchMapOnAddress(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    final Uri url = Uri.parse(googleUrl);
    try {
      await launchUrl(url);
    } catch (e) {
      ToastResp.toastMsgError(resp: "Something went wrong");
    }
  }

  Future<bool> leaveGroup(
      {required String userId, required String groupId}) async {
    var queryParameters = {"groupID": groupId, "userID": json.decode(userId)};
    log(queryParameters.toString());
    final response = await ApiClient.delete(Endpoints.leaveGroup,
        queryParameters: queryParameters, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      getGroup(userId: json.decode(userId));
      log(response.message.toString());
      return true;
    }
    return false;
  }

  Future<bool> reportCommunity({
    required String title,
    required String description,
    required String reportType,
    required String typeId,
  }) async {
    var data = {
      "title": title,
      "description": description,
      "reportType": reportType,
      "typeID": typeId
    };
    log(data.toString());

    final response =
        await ApiClient.post(Endpoints.report, body: data, useToken: true);
    log("what is happening");

    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<GroupModel> requestGroup({String? userId}) async {
    final response = await ApiClient.get(
      '${Endpoints.getRequestGroup}/$userId',
      useToken: true,
    );
    if (response.status == 200) {
      log(response.message.toString());
      return GroupModel.fromJson(response.message);
    }
    return GroupModel();
  }
}
