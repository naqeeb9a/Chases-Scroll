import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:flutter/material.dart';

class EventRepository {
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
