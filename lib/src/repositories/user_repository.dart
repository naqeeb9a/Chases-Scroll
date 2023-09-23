import 'dart:developer';

import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';

import 'api/api_clients.dart';

class UserRepository {
  Future<UserModel> getUserProfile() async {
    final response = await ApiClient.get(Endpoints.getUserProfile);
    if (response.status == 200) {
      return UserModel.fromJson(response.message);
    }
    log(response.message.toString());
    return UserModel();
  }
}
