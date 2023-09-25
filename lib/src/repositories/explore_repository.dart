import 'dart:developer';

import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/event_model.dart';

//riverpod provider
final repositoryProvider = Provider<ExploreRepository>(
  (_) => ExploreRepository(),
);

class ExploreRepository {
  List<ContentEvent> eventList = [];
  Future<List<ContentEvent>> getTopEvents() async {
    final response =
        await ApiClient.get(Endpoints.getTopEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> topEvents = response.message['content'];
      //log(topEvents.toString());
      eventList = topEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return eventList;
    } else {
      return [];
    }
  }

  //this is for getting suggested users
  List<Content> suggestedUsers = [];
  Future<List<Content>> getSuggestedUsers() async {
    final response =
        await ApiClient.get(Endpoints.getSuggestedUsers, useToken: true);

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> suggestUsers = response.message['content'];
      //log(suggestUsers.toString());
      suggestedUsers =
          suggestUsers.map<Content>((user) => Content.fromJson(user)).toList();

      return suggestedUsers;
    } else {
      return [];
    }
  }

  //this is for all event
  List<ContentEvent> allEventList = [];
  Future<List<ContentEvent>> getAllEvents() async {
    final response =
        await ApiClient.get(Endpoints.getAllEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      allEventList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return allEventList;
    } else {
      return [];
    }
  }

  //this is for community
  List<CommContent> allCommunityList = [];
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
}
