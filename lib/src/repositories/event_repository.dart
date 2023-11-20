import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/attendee_model.dart';
import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/models/product_data_type.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/helpers/getmime.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class EventRepository {
  //USERID
  static String userId =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
  //orderID
  static String orderID =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.orderID);
  //orderID
  static String orderCode =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.orderCode);

  //email
  static String email =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.email);
  //this is to get all events
  List<EventContent> allEventList = [];

  //this is to get all events
  List<EventContent> trendingEventList = [];

  //this is to get all events
  List<EventContent> myEventList = [];

  //this is to get all events
  List<EventContent> savedEventList = [];

  //this is to get all events
  List<EventContent> pastEventList = [];

  //to get top events
  List<EventContent> eventList = [];

  //to get corporateList events
  List<EventContent> corporateList = [];

  //to get socialList events
  List<EventContent> socialList = [];

  //to get collegeList events
  List<EventContent> collegeList = [];

  //to get virtualList events
  List<EventContent> virtualList = [];

  //to get draft events
  List<EventContent> draftList = [];

  //to get religiousList events
  List<EventContent> religiousList = [];

  //to get popupList events
  List<EventContent> popupList = [];

  //to get fundraisingList events
  List<EventContent> fundraisingList = [];

  //to get festivalList events
  List<EventContent> festivalList = [];

  //to get communityList events
  List<EventContent> communityList = [];

  //for gettting community ID
  List<CommContent> joinedCommunityList = [];

  //to get evcent attendees
  List<EventAttendeesModel> getEventAttendees = [];

  //create event add image
  Future<String> addImage(
    File image,
  ) async {
    String endpoint = "${Endpoints.uploadImage}/$userId";
    String photoType1 = getMimeType(image.path.split("/").last);
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path,
          filename: image.path.split('/').last,
          contentType: MediaType.parse(photoType1)),
    });
    final response =
        await ApiClient.post(endpoint, useToken: true, body: formData);
    log(response.status.toString());
    if (response.status == 200) {
      log("this request was successfull");
      String image = response.message["fileName"];
      log(image);
      return image;
    } else {
      log("something went wrong");
      return "";
    }
  }

  Future<bool> createEvent({
    final List<String>? picUrls,
    final String? eventType,
    final String? eventName,
    final String? eventDescription,
    final String? locationType,
    final String? currency,
    final String? currentPicUrl,
    final String? eventFunnelGroupID,
    final String? link,
    final String? address,
    final String? locationDetails,
    final int? startTime,
    final int? endTime,
    final int? startDate,
    final int? endDate,
    final bool? isPublic,
    final bool? isExclusive,
    final bool? attendeesVisibility,
    final bool? toBeAnnounced,
    final List<ProductTypeDataa>? productTypeData,
  }) async {
    final data = {
      "picUrls": picUrls,
      "eventType": eventType,
      "eventName": eventName,
      "eventDescription": eventDescription,
      "locationType": locationType,
      "currency": currency,
      "currentPicUrl": currentPicUrl,
      "eventFunnelGroupID": eventFunnelGroupID,
      "mediaType": "PICTURE",
      "currentVideoUrl": "",
      "isPublic": isPublic,
      "isExclusive": isExclusive,
      "mask": true,
      "attendeesVisibility": attendeesVisibility,
      "startTime": startTime,
      "endTime": endTime,
      "startDate": startDate,
      "endDate": endDate,
      "expirationDate": 0,
      "location": {
        "link": link,
        "address": address,
        "locationDetails": locationDetails,
        "latlng": "string",
        "placeIds": "string",
        "toBeAnnounced": toBeAnnounced
      },
      "productTypeData": productTypeData
    };
    final response =
        await ApiClient.post(Endpoints.createEvent, body: data, useToken: true);

    if (response.status == 200 || response.status == 201) {
      //log("Create event response ===> ${response.message}");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createEventDraft({
    final List<String>? picUrls,
    final String? eventType,
    final String? eventName,
    final String? eventDescription,
    final String? locationType,
    final String? currency,
    final String? currentPicUrl,
    final String? eventFunnelGroupID,
    final String? link,
    final String? address,
    final String? locationDetails,
    final int? startTime,
    final int? endTime,
    final int? startDate,
    final int? endDate,
    final bool? isPublic,
    final bool? isExclusive,
    final bool? attendeesVisibility,
    final bool? toBeAnnounced,
    final List<ProductTypeDataa>? productTypeData,
  }) async {
    final data = {
      "picUrls": picUrls,
      "eventType": eventType,
      "eventName": eventName,
      "eventDescription": eventDescription,
      "locationType": locationType,
      "currency": currency,
      "currentPicUrl": currentPicUrl,
      "eventFunnelGroupID": eventFunnelGroupID,
      "mediaType": "PICTURE",
      "currentVideoUrl": "",
      "isPublic": isPublic,
      "isExclusive": isExclusive,
      "mask": true,
      "attendeesVisibility": attendeesVisibility,
      "startTime": startTime,
      "endTime": endTime,
      "startDate": startDate,
      "endDate": endDate,
      "expirationDate": 0,
      "location": {
        "link": link,
        "address": address,
        "locationDetails": locationDetails,
        "latlng": "string",
        "placeIds": "string",
        "toBeAnnounced": toBeAnnounced
      },
      "productTypeData": productTypeData
    };
    final response = await ApiClient.post(Endpoints.createDraft,
        body: data,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    if (response.status == 200 || response.status == 201) {
      //log("Create event response ===> ${response.message}");
      return true;
    } else {
      return false;
    }
  }

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
    final response = await ApiClient.post(
      Endpoints.createEventTicket,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  //to create event ticket
  Future<dynamic> createWebUrlPayStack(
      {required String? amount, required String? currency}) async {
    final url =
        "${Endpoints.createWebUrlPaystack}?orderCode=$orderCode&email=$email&amount=$amount&currency=$currency";
    final response = await ApiClient.postWithoutBody(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      //log("webUrlPaystack ======> ${response.message}");
      return response.message;
    }
    return response.message;
  }

  Future<dynamic> createWebUrlStripe() async {
    final url = "${Endpoints.createWebUrlStripe}?orderId=$orderID";
    final response = await ApiClient.postWithoutBody(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("webUrlStripe ======> ${response.message}");
      return response.message;
    }
    return response.message;
  }

  //verify event payment Stripe
  Future<dynamic> deleteDraft({String? draftID}) async {
    final url = "${Endpoints.deleteDraft}/$draftID";
    final response = await ApiClient.delete(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("verifyEventPaymentStripe ======> ${response.message}");
      return response.message;
    }
    return response.message;
  }

  //delete friend
  Future<dynamic> deleteFriend({
    final String? friendID,
  }) async {
    String url = "${Endpoints.disconnectFriend}/$friendID";

    final response = await ApiClient.delete(url,
        useToken: true,
        backgroundColor: Colors.transparent,
        widget: Container());

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
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

  //getCollegeEvents events
  Future<List<EventContent>> getCollegeEvents() async {
    final response =
        await ApiClient.get(Endpoints.corporateEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      collegeList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return collegeList;
    } else {
      return [];
    }
  }

  //Community events
  Future<List<EventContent>> getCommunityEvents() async {
    final response =
        await ApiClient.get(Endpoints.communityEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      communityList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return communityList;
    } else {
      return [];
    }
  }

  //corporate events
  Future<List<EventContent>> getCorporateEvents() async {
    final response =
        await ApiClient.get(Endpoints.corporateEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      corporateList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return corporateList;
    } else {
      return [];
    }
  }

  //getDraft events
  Future<List<EventContent>> getDraftEvents() async {
    String url = "${Endpoints.getDraftEvent}?createdBy=$userId&size=10";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> draft = response.message['content'];
      log("getDraftEvents ====> ${draft.toString()}");
      draftList = draft
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return draftList;
    } else {
      return [];
    }
  }

  Future<List<EventAttendeesModel>> getEventAttendes({String? eventId}) async {
    String url = "${Endpoints.getEventMembers}/$eventId";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEventUsers = response.message['content'];
      //log("getting full attedee details ====> ${response.message['content']}");
      getEventAttendees = allEventUsers
          .map<EventAttendeesModel>(
              (event) => EventAttendeesModel.fromJson(event))
          .toList();

      return getEventAttendees;
    } else {
      return [];
    }
  }

  Future<List<EventContent>> getEventsByID() async {
    String url = "${Endpoints.getAllEvents}?createdBy=$userId";
    final response = await ApiClient.get(url, useToken: true);

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

  //Festival events
  Future<List<EventContent>> getFestivalEvents() async {
    final response =
        await ApiClient.get(Endpoints.festivalEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      festivalList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return festivalList;
    } else {
      return [];
    }
  }

  //Fundraising events
  Future<List<EventContent>> getFundraisingEvents() async {
    final response =
        await ApiClient.get(Endpoints.fundraisingEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      fundraisingList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return fundraisingList;
    } else {
      return [];
    }
  }

  //Joined Community
  Future<List<CommContent>> getJoinedCommunity() async {
    final response =
        await ApiClient.get(Endpoints.joinedCommunity, useToken: true);

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

  Future<List<EventContent>> getMyEvents() async {
    String url = "${Endpoints.myEvents}/$userId";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];

      myEventList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();
      log("myEventList ====> ${myEventList.toString()}");

      return myEventList;
    } else {
      return [];
    }
  }

  Future<List<EventContent>> getOtherUsersEvents({String? userID}) async {
    String url = "${Endpoints.myEvents}/$userID";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      //log(allEvents.toString());
      myEventList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return myEventList;
    } else {
      return [];
    }
  }

  Future<List<EventContent>> getPastEvents() async {
    final response = await ApiClient.get(Endpoints.pastEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      pastEventList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return pastEventList;
    } else {
      return [];
    }
  }

  //popup events
  Future<List<EventContent>> getPopupEvents() async {
    final response = await ApiClient.get(Endpoints.popupEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      popupList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return popupList;
    } else {
      return [];
    }
  }

  //Religious events
  Future<List<EventContent>> getReligiousEvents() async {
    final response =
        await ApiClient.get(Endpoints.religiousEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      religiousList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return religiousList;
    } else {
      return [];
    }
  }

  Future<List<EventContent>> getSavedEvents() async {
    final url = "${Endpoints.savedEvents}/?typeID=$userId&type=EVENT";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      savedEventList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return savedEventList;
    } else {
      return [];
    }
  }

  //getSocialEvents events
  Future<List<EventContent>> getSocialEvents() async {
    final response =
        await ApiClient.get(Endpoints.socialEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      socialList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return socialList;
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

  Future<List<EventContent>> getTrendingEvents() async {
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

  //virtual events
  Future<List<EventContent>> getVirtualEvents() async {
    final response =
        await ApiClient.get(Endpoints.virtualEvents, useToken: true);

    if (response.status == 200) {
      final List<dynamic> allEvents = response.message['content'];
      // log(allEvents.toString());
      virtualList = allEvents
          .map<EventContent>((event) => EventContent.fromJson(event))
          .toList();

      return virtualList;
    } else {
      return [];
    }
  }

  //join community
  Future<dynamic> joinCommunity({
    final String? groupID,
  }) async {
    final data = {
      "groupID": groupID,
      "joinID": userId,
    };
    final response = await ApiClient.post(
      Endpoints.joinCommunity,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  //join community
  Future<dynamic> leaveCommunity({
    final String? groupID,
  }) async {
    final url = "${Endpoints.leaveCommunity}?groupID=$groupID&userID=$userId";
    final response = await ApiClient.delete(url, useToken: true);

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
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
    final response = await ApiClient.post(
      Endpoints.saveEvent,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  //this is  to save an event
  Future<dynamic> unSaveEvent({
    final String? eventID,
    final String? userID,
  }) async {
    final data = {
      "eventID": eventID,
      "typeID": userID,
      "type": "EVENT",
    };
    final response = await ApiClient.post(
      Endpoints.unSaveEvent,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  //update event  draft
  Future<bool> updateEventDraft({
    final List<String>? picUrls,
    final String? eventType,
    final String? eventName,
    final String? eventDescription,
    final String? locationType,
    final String? currency,
    final String? currentPicUrl,
    final String? eventFunnelGroupID,
    final String? link,
    final String? address,
    final String? locationDetails,
    final int? startTime,
    final int? endTime,
    final int? startDate,
    final int? endDate,
    final bool? isPublic,
    final bool? isExclusive,
    final bool? attendeesVisibility,
    final bool? toBeAnnounced,
    final List<ProductTypeDataa>? productTypeData,
  }) async {
    final data = {
      "picUrls": picUrls,
      "eventType": eventType,
      "eventName": eventName,
      "eventDescription": eventDescription,
      "locationType": locationType,
      "currency": currency,
      "currentPicUrl": currentPicUrl,
      "eventFunnelGroupID": eventFunnelGroupID,
      "mediaType": "PICTURE",
      "currentVideoUrl": "",
      "isPublic": isPublic,
      "isExclusive": isExclusive,
      "mask": true,
      "attendeesVisibility": attendeesVisibility,
      "startTime": startTime,
      "endTime": endTime,
      "startDate": startDate,
      "endDate": endDate,
      "expirationDate": 0,
      "location": {
        "link": link,
        "address": address,
        "locationDetails": locationDetails,
        "latlng": "string",
        "placeIds": "string",
        "toBeAnnounced": toBeAnnounced
      },
      "productTypeData": productTypeData
    };
    final response = await ApiClient.put(
      Endpoints.updateDraft,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      //log("Create event response ===> ${response.message}");
      return true;
    } else {
      return false;
    }
  }

  //verify event payment paystack
  Future<dynamic> verifyEventPaymentPaystack() async {
    final url = "${Endpoints.verifyEventPaystack}?orderCode=$orderCode";
    final response = await ApiClient.postWithoutBody(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("verifyEventPaymentPaystack ======> ${response.message}");
      return response.message;
    }
    return response.message;
  }

  //verify event payment Stripe
  Future<dynamic> verifyEventPaymentStripe() async {
    final url = "${Endpoints.verifyEventStripe}?orderId=$orderID";
    final response = await ApiClient.postWithoutBody(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("verifyEventPaymentStripe ======> ${response.message}");
      return response.message;
    }
    return response.message;
  }
}
