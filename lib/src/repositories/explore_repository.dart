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
  List<Content> eventList = [];
  //this is for getting suggested users
  List<ContentUser> suggestedUsers = [];

  //this is for all event
  List<Content> allEventList = [];
  //this is for community
  List<CommContent> allCommunityList = [];

  Future<dynamic> connectWithFriend({String? friendID}) async {
    final data = {
      "toUserID": friendID,
    };
    final response = await ApiClient.post(Endpoints.connectFriend,
        body: data,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    log("response here saying  connect friend... =>>>${response.message}");

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
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
      //log(allCommunities.toString());
      allCommunityList = allCommunities
          .map<CommContent>((event) => CommContent.fromJson(event))
          .toList();

      return allCommunityList;
    } else {
      return [];
    }
  }

  Future<List<Content>> getAllEvents() async {
    final response =
        await ApiClient.get(Endpoints.getAllEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      allEventList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return allEventList;
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

  Future<List<Content>> getTopEvents() async {
    final response =
        await ApiClient.get(Endpoints.getTopEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> topEvents = response.message['content'];
      //log(topEvents.toString());
      eventList =
          topEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return eventList;
    } else {
      return [];
    }
  }
}
