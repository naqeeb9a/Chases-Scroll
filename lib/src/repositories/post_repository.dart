import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/comments_model.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/helpers/getmime.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

// import 'package:minio/io.dart';
// import 'package:minio/minio.dart';

import '../config/locator.dart';

class PostRepository {
  final _storage = locator<LocalStorageService>();

  Future<bool> addComment(
    String postId,
    String comment,
  ) async {
    var body = {
      "postID": postId,
      "comment": comment,
    };
    log(body.toString());
    final response =
        await ApiClient.post(Endpoints.addComment, body: body, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return true;
    }
    return false;
  }

  Future<String> addImage(
    File image,
    String userId,
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

  Future<bool> createPost(String text, String sourceId, String? mediaRef,
      List<String>? multipleMediaRef, String? type) async {
    var body = {
      "text": text,
      "type": type,
      "isGroupFeed": false,
      "sourceId": sourceId,
      'groupId': null,
      "mediaRef": mediaRef,
      "multipleMediaRef": multipleMediaRef,
      "videoLength": 0
    };
    log(body.toString());
    final response =
        await ApiClient.post(Endpoints.createPost, body: body, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return true;
    }
    return false;
  }

  Future<CommentModel> getComment(String postId) async {
    String url = "${Endpoints.getPostComment}?postID=$postId";
    final response = await ApiClient.get(url, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return CommentModel.fromJson(response.message);
    }
    return CommentModel();
  }

  Future<PostModel> getPost() async {
    final response = await ApiClient.get(Endpoints.getPost, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return PostModel.fromJson(response.message);
    }
    return PostModel();
  }

  onSendProgress(int sent, int total) {
    if (total != -1) {
      final progress = sent / total;
      log(progress.toString());
    }
  }

  Future uploadVideo(String videoPath) async {
    try {
      String object = '';
      // Minio minio = Minio(
      //     endPoint: AwsKeys.endPoint,
      //     accessKey: AwsKeys.accessKey,
      //     secretKey: AwsKeys.secretKey,
      //     region: AwsKeys.region);

      // object = path.basename(videoPath);

      // var response = await minio.fPutObject(AwsKeys.bucket, object, videoPath);
      // var serverRespond =
      //     await minio.presignedGetObject(AwsKeys.bucket, object);
      // log(response.toString());
      // log(serverRespond.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
