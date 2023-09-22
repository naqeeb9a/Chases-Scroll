import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/repositories/api/api_response.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/screens/widgets/overlay_loader.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../config/locator.dart';
import '../../services/storage_service.dart';

dynamic getTypeAsString(dynamic input) {
  log(input.toString());
  OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
  if (input.response?.data is String) {
    ToastResp.toastMsgError(resp: input.response?.data);
    return ApiResponse(
        message: input.response.data, status: input.response.statusCode);
  } else {
    log(input.response!.data.toString());
    log(input.response!.statusMessage.toString());
    log(input.response.statusCode.toString());
    // return _handleDioError(ApiResponseAsString.toApiResponse(
    //     input.response?.data ?? input.response?.statusMessage);
    return ApiResponse(
        message: input.response.data, status: input.response.statusCode);
  }
}

// void _handleDioError(ApiResponse response) {
//   // showToast(response.message!);
//   OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
//   ToastResp.toastMsgError(resp: response.message);

//   inspect(response.title);
// }

class ApiClient {
  static final _dio = Dio(
    BaseOptions(baseUrl: Endpoints.baseUrl),
  );

  static final _defaultHeader = {
    'Content-Type': 'application/json',
  };

  static String get _token => _getToken();

  static Future delete(String endpoint, {bool useToken = true}) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;

        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }

        final options = Options(headers: header);
        AppHelper.showOverlayLoader();
        final response = await _dio.delete(endpoint, options: options);
        OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
        return response;
      },
    );

    return result;
  }

  static Future get(
    String endpoint, {
    dynamic queryParameters,
    bool useToken = true,
    bool iscached = false,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;
        log('this is the token$_token');
        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }

        final options = Options(headers: header);
        log('${_dio.options.baseUrl}/$endpoint');

        final response = await _dio.get(
          endpoint,
          options: options,
          queryParameters: queryParameters,
        );
        return response;
      },
    );
    return result;
  }

  static Future patch(
    String endpoint, {
    required dynamic body,
    bool useToken = true,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;

        final options = Options(headers: header);
        log('put request');
        // ignore: prefer_single_quotes
        AppHelper.showOverlayLoader();
        log("${_dio.options.baseUrl}$endpoint $body");

        final response =
            await _dio.patch(endpoint, data: body, options: options);
        debugPrint('Response from $endpoint \n${response.data}');
        OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
        return response;
      },
    );

    return result;
  }

  static Future post(
    String endpoint, {
    required dynamic body,
    bool useToken = true,
    Function(int, int)? onSendProgress,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;

        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }

        final options = Options(headers: header);
        log("${_dio.options.baseUrl}$endpoint $body");
        AppHelper.showOverlayLoader();
        final response = await _dio.post(endpoint,
            data: body, options: options, onSendProgress: onSendProgress);
        log("$response");

        OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
        return response;
      },
    );

    return result;
  }

  static Future postImage(
    String endpoint, {
    required dynamic body,
    bool useToken = true,
    Function(int, int)? onSendProgress,
  }) async {
    final header = _defaultHeader;

    if (useToken) {
      header.addAll(
        {'Authorization': 'Bearer $_token'},
      );
    }

    try {
      final options = Options(headers: header);
      log("${_dio.options.baseUrl}$endpoint $body");

      final response = await _dio.post(endpoint,
          data: body, options: options, onSendProgress: onSendProgress);
      log("$response");

      return SuccessResponse.toApiResponse(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        // locator<GoRouter>().push(AppRoutes.login);
      }
      log(e.response!.data.toString());
      log(e.response!.statusMessage.toString());
      log(e.response!.data.toString());
    }
  }

  static Future put(
    String endpoint, {
    required dynamic body,
    bool useToken = true,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;

        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }
        final options = Options(headers: header);
        log('put request');
        AppHelper.showOverlayLoader();
        log("${_dio.options.baseUrl}$endpoint $body");
        final response = await _dio.put(endpoint, data: body, options: options);
        OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
        debugPrint('Response from $endpoint \n${response.data}');
        return response;
      },
    );

    return result;
  }

  static String _getToken() {
    String token =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.token);
    log("this is the token here");
    return json.decode(token);
  }

  static void _handleSocketException(SocketException e) {
    debugPrint('Check Internet');
  }

  static Future _makeRequest(Function request) async {
    try {
      final result = await request();

      return ApiResponse(message: result.data, status: result.statusCode);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        // locator<GoRouter>().push(AppRoutes.login);
      }
      log(e.response!.data.toString());
      OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
      if (e.response?.data is String) {
        ToastResp.toastMsgError(resp: e.response?.data.toString());
      } else {
        ToastResp.toastMsgError(resp: e.response?.data["error_description"]);
      }
      return ApiResponse(
          message: e.response?.data ?? e.response?.statusMessage,
          status: e.response?.statusCode);
    } on SocketException catch (e) {
      _handleSocketException(e);
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
