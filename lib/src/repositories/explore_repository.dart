import 'dart:developer';

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
    log(response.toString());
    if (response.status == 200) {
      final List<dynamic> topEvents = response.message['content'];
      log(topEvents.toString());
      eventList = topEvents
          .map<ContentEvent>((event) => ContentEvent.fromJson(event))
          .toList();

      return eventList;
    } else {
      return [];
    }
  }
}
