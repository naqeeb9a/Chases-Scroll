import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';

import 'api/api_clients.dart';

class UserRepository {
  final _storage = locator<LocalStorageService>();
  Future<UserModel> getUserProfile() async {
    final response = await ApiClient.get(Endpoints.getUserProfile);
    if (response.status == 200) {
      UserModel profile = UserModel.fromJson(response.message);
      _storage.saveDataToDisk(
          AppKeys.fullName, "${profile.firstName} ${profile.lastName}");
      return UserModel.fromJson(response.message);
    }
    log(response.message.toString());
    return UserModel();
  }
}
