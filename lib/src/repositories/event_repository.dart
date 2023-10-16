import 'dart:developer';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:flutter/material.dart';

class EventRepository {
  //this is to get all events
  List<Content> allEventList = [];

  //this is to get all events
  List<Content> trendingEventList = [];

  //this is to get all events
  List<Content> myEventList = [];

  //this is to get all events
  List<Content> savedEventList = [];

  //this is to get all events
  List<Content> pastEventList = [];

  //to get top events
  List<Content> eventList = [];

  //to get corporateList events
  List<Content> corporateList = [];

  //to get socialList events
  List<Content> socialList = [];

  //to get collegeList events
  List<Content> collegeList = [];

  //to get virtualList events
  List<Content> virtualList = [];

  //to get religiousList events
  List<Content> religiousList = [];

  //to get popupList events
  List<Content> popupList = [];

  //to get fundraisingList events
  List<Content> fundraisingList = [];

  //to get festivalList events
  List<Content> festivalList = [];

  //to get communityList events
  List<Content> communityList = [];

  //to create event ticket
  Future<dynamic> createTicket({
    final int? numberOfTickets,
    final String? eventID,
    final String? ticketType,
  }) async {
    final data = {
      "eventID": eventID,
      "ticketType": ticketType,
      "numberOfTickets": numberOfTickets
    };
    final response = await ApiClient.post(Endpoints.createEventTicket,
        body: data,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  //to create event ticket
  Future<Map<String, dynamic>> createWebUrlPayStack() async {
    final data = {};
    final response = await ApiClient.post(Endpoints.createWebUrlPaystack,
        body: data, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("webUrlPaystack ======> ${response.message}");
      return response.message;
    }
    return response.message;
  }

  Future<Map<String, dynamic>> createWebUrlStripe() async {
    final data = {};
    final response = await ApiClient.post(Endpoints.createWebUrlStripe,
        body: data, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("webUrlStripe ======> ${response.message}");
      return response.message;
    }
    return response.message;
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

  //getCollegeEvents events
  Future<List<Content>> getCollegeEvents() async {
    final response =
        await ApiClient.get(Endpoints.corporateEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      collegeList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return collegeList;
    } else {
      return [];
    }
  }

  //Community events
  Future<List<Content>> getCommunityEvents() async {
    final response =
        await ApiClient.get(Endpoints.communityEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      communityList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return communityList;
    } else {
      return [];
    }
  }

  //corporate events
  Future<List<Content>> getCorporateEvents() async {
    final response =
        await ApiClient.get(Endpoints.corporateEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      corporateList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return corporateList;
    } else {
      return [];
    }
  }

  //Festival events
  Future<List<Content>> getFestivalEvents() async {
    final response =
        await ApiClient.get(Endpoints.festivalEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      festivalList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return festivalList;
    } else {
      return [];
    }
  }

  //Fundraising events
  Future<List<Content>> getFundraisingEvents() async {
    final response =
        await ApiClient.get(Endpoints.fundraisingEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      fundraisingList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return fundraisingList;
    } else {
      return [];
    }
  }

  Future<List<Content>> getMyEvents() async {
    final response = await ApiClient.get(Endpoints.myEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      log(allEvents.toString());
      myEventList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return myEventList;
    } else {
      return [];
    }
  }

  Future<List<Content>> getPastEvents() async {
    final response = await ApiClient.get(Endpoints.pastEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      pastEventList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return pastEventList;
    } else {
      return [];
    }
  }

  //popup events
  Future<List<Content>> getPopupEvents() async {
    final response = await ApiClient.get(Endpoints.popupEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      popupList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return popupList;
    } else {
      return [];
    }
  }

  //Religious events
  Future<List<Content>> getReligiousEvents() async {
    final response =
        await ApiClient.get(Endpoints.religiousEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      religiousList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return religiousList;
    } else {
      return [];
    }
  }

  Future<List<Content>> getSavedEvents() async {
    final response = await ApiClient.get(Endpoints.savedEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      savedEventList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return savedEventList;
    } else {
      return [];
    }
  }

  //getSocialEvents events
  Future<List<Content>> getSocialEvents() async {
    final response =
        await ApiClient.get(Endpoints.socialEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      socialList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

      return socialList;
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

  Future<List<Content>> getTrendingEvents() async {
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

  //virtual events
  Future<List<Content>> getVirtualEvents() async {
    final response =
        await ApiClient.get(Endpoints.virtualEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      virtualList =
          allEvents.map<Content>((event) => Content.fromJson(event)).toList();

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
