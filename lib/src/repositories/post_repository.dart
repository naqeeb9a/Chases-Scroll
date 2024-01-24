import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/comments_model.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/models/user_list_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
// import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/helpers/getmime.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

// import 'package:minio/io.dart';
// import 'package:minio/minio.dart';

// import '../config/locator.dart';

class PostRepository {
  // final _storage = locator<LocalStorageService>();

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

  Future<String> addDocument(
    File image,
    String userId,
  ) async {
    String endpoint = "${Endpoints.uploadImage}/$userId";

    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });
    final response = await ApiClient.postWithoutOverlay(endpoint,
        useToken: true, body: formData);
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
    final response = await ApiClient.postWithoutOverlay(endpoint,
        useToken: true, body: formData);
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

  Future<bool> addSubComment(
    String postId,
    String comment,
  ) async {
    var body = {
      "commentID": postId,
      "comment": comment,
    };
    log(body.toString());
    final response =
        await ApiClient.post(Endpoints.subComment, body: body, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return true;
    }
    return false;
  }

  Future<String> addVideo(
    File video,
    String userId,
  ) async {
    String endpoint = "${Endpoints.uploadVideo}/$userId";

    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(video.path,
          filename: video.path.split('/').last,
          contentType: MediaType.parse("video/mp4")),
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

  Future createPost(String text, String sourceId, String? mediaRef,
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

  Future<bool> deletePost(String postId) async {
    String endpoint = '${Endpoints.removePost}/$postId';

    final response = await ApiClient.delete(endpoint);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> editPost({
    required String postId,
    required String postText,
    required String type,
    String? mediaRef,
    List<String>? multipleMediaRef,
  }) async {
    var body = {
      "id": postId,
      "text": postText,
      "type": type,
      "mediaRef": mediaRef,
      "multipleMediaRef": multipleMediaRef,
    };
    log(body.toString());
    final response =
        await ApiClient.put(Endpoints.editPost, body: body, useToken: true);

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

  Future<UserListModel> getFriends(String id) async {
    final response =
        await ApiClient.get("${Endpoints.userFriends}/$id", useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return UserListModel.fromJson(response.message);
    }
    return UserListModel();
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

  Future<SubComment> getSubComment(String commentId) async {
    String endpoint = "${Endpoints.getSubComment}?commentID=$commentId";
    final response = await ApiClient.get(endpoint, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return SubComment.fromJson(response.message);
    }
    return SubComment();
  }

  Future<bool> likeComment(String commentId) async {
    String endpoint = "${Endpoints.likeComment}/$commentId";
    final response = await ApiClient.postWithoutOverlay(endpoint,
        body: null, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return true;
    }
    return false;
  }

  Future<bool> likePost(String postId) async {
    String endpoint = "${Endpoints.likePost}/$postId";
    final response = await ApiClient.postWithoutOverlay(endpoint,
        body: null, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return true;
    }
    return false;
  }

  onSendProgress(int sent, int total) {
    if (total != -1) {
      final progress = sent / total;
      log(progress.toString());
    }
  }

  Future<bool> sharePost(
    String shareId,
    List<String> friends,
  ) async {
    var body = {
      "publicPost": true,
      "postType": "SHARE",
      "shareID": shareId,
      "shareWith": friends
    };
    log(body.toString());
    final response =
        await ApiClient.post(Endpoints.sharePost, body: body, useToken: true);

    if (response.status == 200 || response.status == 201) {
      log("this is the message");
      log(response.message.toString());
      return true;
    }
    return false;
  }
}
