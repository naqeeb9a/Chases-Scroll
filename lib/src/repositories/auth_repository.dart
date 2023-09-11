import 'dart:developer';

import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';

class AuthRepository {
  login(String username, String password) async {
    final data = {
      "username": username,
      "password": password,
    };

    final response =
        await ApiClient.post(Endpoints.login, body: data, useToken: false);

    log(response.toString());
  }
}
