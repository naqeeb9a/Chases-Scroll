import 'dart:convert';
import 'dart:developer';

import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';

import '../config/keys.dart';
import '../config/locator.dart';

class AuthRepository {
  final _storage = locator<LocalStorageService>();
  Future<bool> changePassword(String password, String token) async {
    final data = {
      "token": token,
      "password": password,
    };
    final response = await ApiClient.put(Endpoints.changePassword,
        body: data, useToken: false);

    if (response.status == 200 || response.status == 201) {
      log("this is response");
      log(response.toString());
      return true;
    }
    return false;
  }

  Future<dynamic> login(String username, String password) async {
    final data = {
      "username": username,
      "password": password,
    };

    final response =
        await ApiClient.post(Endpoints.login, body: data, useToken: false);
    log(response.status.toString());
    if (response.status == 200) {
      _storage.saveDataToDisk(
          AppKeys.token, json.encode(response.message['access_token']));
      return true;
    }
    log(response.message.toString());
    return false;
  }

  Future<bool> sendEmail(String email, int emailType) async {
    final data = {
      "userEmail": email,
      "emailType": emailType,
    };

    final response =
        await ApiClient.post(Endpoints.sendEmail, body: data, useToken: false);

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }

  Future<bool> signup(
      {required String username,
      required String password,
      required String email,
      required String lastName,
      required String dob,
      required String phone,
      required String firstName}) async {
    final data = {
      "username": username,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "dob": dob,
      "password": password,
      "data": {
        "mobilePhone": {
          "objectPublic": true,
          "value": phone,
        }
      }
    };

    final response =
        await ApiClient.post(Endpoints.signup, body: data, useToken: false);

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }

  Future<bool> verifyPincode(String pinCode) async {
    final data = {
      "token": pinCode,
    };

    final response = await ApiClient.post(Endpoints.verifyEmail,
        body: data, useToken: false);

    if (response.status == 200 || response.status == 201) {
      return true;
    }
    return false;
  }
}
