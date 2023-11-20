import 'package:chases_scroll/src/models/chat_detail_model.dart';
import 'package:chases_scroll/src/models/chat_model.dart';
import 'package:chases_scroll/src/models/notification_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';

class ChatRepository {
  Future<ChatModel> getChat({String? userId, String? search}) async {
    final response = await ApiClient.get(
      Endpoints.getChat,
      useToken: true,
    );

    if (response.status == 200) {
      return ChatModel.fromJson(response.message);
    }
    return ChatModel();
  }

  Future<ChatDetailsModel> getChatDetails({String? chatId}) async {
    final response = await ApiClient.get(
      "${Endpoints.getChatMessage}?chatID=$chatId",
      useToken: true,
    );

    if (response.status == 200) {
      return ChatDetailsModel.fromJson(response.message);
    }
    return ChatDetailsModel();
  }

  Future<NotificationModel> getNotification() async {
    final response = await ApiClient.get(
      Endpoints.notifications,
      useToken: true,
    );

    if (response.status == 200) {
      return NotificationModel.fromJson(response.message);
    }
    return NotificationModel();
  }

  Future<bool> postChat(
      {String? chatId,
      String? message,
      String? media,
      String? mediaType}) async {
    var body = {
      "message": message,
      "media": media,
      "chatID": chatId,
      "mediaType": mediaType
    };
    final response =
        await ApiClient.post(Endpoints.sendChat, useToken: true, body: body);

    if (response.status == 200) {
      return true;
    }
    return false;
  }
}
