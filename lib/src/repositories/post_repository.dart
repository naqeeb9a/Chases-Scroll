import 'dart:developer';

import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';

import '../../config/locator.dart';

class PostRepository {
  final _storage = locator<LocalStorageService>();

  Future<PostModel> getPost() async {
    final response = await ApiClient.get(Endpoints.getPost, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return PostModel.fromJson(response.message);
    }
    return PostModel();
  }
}
