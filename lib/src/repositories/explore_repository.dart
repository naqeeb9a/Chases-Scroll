import 'dart:developer';

import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/event_model.dart';

//riverpod provider
final repositoryProvider = Provider<ExploreRepository>(
  (_) => ExploreRepository(),
);

class ExploreRepository {
  List<EventContent> eventList = [];
  //this is for getting suggested users
  List<ContentUser> suggestedUsers = [];

  //this is for all event
  List<EventContent> allEventList = [];
  //this is for community
  List<CommContent> allCommunityList = [];

  //accept friend request
  Future<dynamic> acceptFriendRequest({String? friendID}) async {
    final data = {
      "friendRequestID": friendID,
    };
    final response = await ApiClient.post(Endpoints.acceptFriend,
        body: data,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    log("response here saying  acceptFriendRequest... =>>>${response.message}");

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  Future<dynamic> blockFriend({String? friendID}) async {
    final data = {"blockType": "USER", "typeID": friendID};
    final response = await ApiClient.post(
      Endpoints.blockFriend,
      body: data,
      useToken: true,
    );

    log("response here saying blockFriend... =>>>${response.message}");

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  Future<dynamic> connectWithFriend({String? friendID}) async {
    final data = {
      "toUserID": friendID,
    };
    final response = await ApiClient.post(Endpoints.connectFriend,
        body: data,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    if (response.status == 200 || response.status == 201) {
      log("response here saying  connect friend... =>>>${response.message}");
      return response.message;
    }
    log("response here saying  connect friend... =>>>${response.message}");
    return response.message;
  }

  Future<dynamic> disconnectWithFriend({String? friendID}) async {
    String url = "${Endpoints.disconnectFriend}/$friendID";

    final response = await ApiClient.delete(url,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    log("response here saying disconnect friend ... =>>>${response.message}");

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  Future<List<CommContent>> getAllCommunity() async {
    final response =
        await ApiClient.get(Endpoints.getAllCommunities, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allCommunities = response.message['content'];
      log("getAllCommunity ====>${allCommunities.toString()}");
      allCommunityList = allCommunities
          .map<CommContent>((event) => CommContent.fromJson(event))
          .toList();

      return allCommunityList;
    } else {
      return [];
    }
  }

  Future<List<EventContent>> getAllEvents() async {
    final response =
        await ApiClient.get(Endpoints.getAllEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      allEventList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return allEventList;
    } else {
      return [];
    }
  }

  Future<List<CommContent>> getJoinedCommunity({String? userId}) async {
    String? url = "${Endpoints.joinedCommunity}?userID=$userId";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allCommunities = response.message['content'];
      //log(allCommunities.toString());
      allCommunityList = allCommunities
          .map<CommContent>((event) => CommContent.fromJson(event))
          .toList();

      return allCommunityList;
    } else {
      return [];
    }
  }

  Future<List<ContentUser>> getSuggestedUsers() async {
    final response =
        await ApiClient.get(Endpoints.getSuggestedUsers, useToken: true);

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> suggestUsers = response.message['content'];
      //log(suggestUsers.toString());
      suggestedUsers = suggestUsers
          .map<ContentUser>((user) => ContentUser.fromJson(user))
          .toList();

      return suggestedUsers;
    } else {
      return [];
    }
  }

  Future<List<EventContent>> getTopEvents() async {
    final response =
        await ApiClient.get(Endpoints.getTopEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> topEvents = response.message['content'];
      //log(topEvents.toString());
      eventList = topEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return eventList;
    } else {
      return [];
    }
  }

  //reject friend request
  Future<dynamic> rejectFriendRequest({String? friendID}) async {
    String url = "${Endpoints.rejectFriend}/$friendID";
    final response = await ApiClient.delete(url,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    log("response here saying rejectFriendRequest... =>>>${response.message}");

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }
}
