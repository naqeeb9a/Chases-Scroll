import 'dart:developer';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:flutter/material.dart';

class EventRepository {
  //this is to get all events
  List<ContentEvent> allEventList = [];

  //this is to get all events
  List<ContentEvent> trendingEventList = [];

  //this is to get all events
  List<ContentEvent> myEventList = [];

  //this is to get all events
  List<ContentEvent> savedEventList = [];

  //this is to get all events
  List<ContentEvent> pastEventList = [];

  //to get top events
  List<ContentEvent> eventList = [];

  //to get corporateList events
  List<ContentEvent> corporateList = [];

  //to get socialList events
  List<ContentEvent> socialList = [];

  //to get collegeList events
  List<ContentEvent> collegeList = [];

  //to get virtualList events
  List<ContentEvent> virtualList = [];

  //to get religiousList events
  List<ContentEvent> religiousList = [];

  //to get popupList events
  List<ContentEvent> popupList = [];

  //to get fundraisingList events
  List<ContentEvent> fundraisingList = [];

  //to get festivalList events
  List<ContentEvent> festivalList = [];

  //to get communityList events
  List<ContentEvent> communityList = [];

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

  //getCollegeEvents events
  Future<List<ContentEvent>> getCollegeEvents() async {
    final response =
        await ApiClient.get(Endpoints.corporateEvents, useToken: true);

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

  //Community events
  Future<List<ContentEvent>> getCommunityEvents() async {
    final response =
        await ApiClient.get(Endpoints.communityEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      communityList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return communityList;
    } else {
      return [];
    }
  }

  //corporate events
  Future<List<ContentEvent>> getCorporateEvents() async {
    final response =
        await ApiClient.get(Endpoints.corporateEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      corporateList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return corporateList;
    } else {
      return [];
    }
  }

  //Festival events
  Future<List<ContentEvent>> getFestivalEvents() async {
    final response =
        await ApiClient.get(Endpoints.festivalEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      festivalList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return festivalList;
    } else {
      return [];
    }
  }

  //Fundraising events
  Future<List<ContentEvent>> getFundraisingEvents() async {
    final response =
        await ApiClient.get(Endpoints.fundraisingEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      fundraisingList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return fundraisingList;
    } else {
      return [];
    }
  }

  Future<List<ContentEvent>> getMyEvents() async {
    final response = await ApiClient.get(Endpoints.myEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      log(allEvents.toString());
      myEventList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return myEventList;
    } else {
      return [];
    }
  }

  Future<List<ContentEvent>> getPastEvents() async {
    final response = await ApiClient.get(Endpoints.pastEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      pastEventList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return pastEventList;
    } else {
      return [];
    }
  }

  //popup events
  Future<List<ContentEvent>> getPopupEvents() async {
    final response = await ApiClient.get(Endpoints.popupEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      popupList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return popupList;
    } else {
      return [];
    }
  }

  //Religious events
  Future<List<ContentEvent>> getReligiousEvents() async {
    final response =
        await ApiClient.get(Endpoints.religiousEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      religiousList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return religiousList;
    } else {
      return [];
    }
  }

  Future<List<ContentEvent>> getSavedEvents() async {
    final response = await ApiClient.get(Endpoints.savedEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      savedEventList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return savedEventList;
    } else {
      return [];
    }
  }

  //getSocialEvents events
  Future<List<ContentEvent>> getSocialEvents() async {
    final response =
        await ApiClient.get(Endpoints.socialEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      socialList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return socialList;
    } else {
      return [];
    }
  }

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

  Future<List<ContentEvent>> getTrendingEvents() async {
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

  //virtual events
  Future<List<ContentEvent>> getVirtualEvents() async {
    final response =
        await ApiClient.get(Endpoints.virtualEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      virtualList = allEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return virtualList;
    } else {
      return [];
    }
  }

  //this is  to save an event
  Future<dynamic> saveEvent({
    final String? eventID,
    final String? userID,
  }) async {
    final data = {
      "eventID": eventID,
      "typeID": userID,
      "type": "EVENT",
    };
    final response = await ApiClient.post(Endpoints.saveEvent,
        body: data,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }
}
