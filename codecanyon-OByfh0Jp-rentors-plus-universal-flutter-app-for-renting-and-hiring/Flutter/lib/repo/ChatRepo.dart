import 'package:dio/dio.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/model/chat/ChatModel.dart';
import 'package:rentors/model/chat/ConversationModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<ConversationModel> getConversation() async {
  UserModel model = await Utils.getUser();
  FormData formData = new FormData.fromMap({
    "user_id": model.data.id.trim().toString(),
  });
  var response = await dio.httpClient().post("Chat/getChatHistory",
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType));
  var parsed = ConversationModel.fromJson(response.data);
  return parsed;
}

Future<String> getThreadId(String senderId, String recieverId) async {
  Map map = Map<String, String>();
  map["sender_id"] = senderId;
  map["receiver_id"] = recieverId;

  var response = await dio.httpClient().post("Chat/getThread", data: map);
  var data = response.data["data"];
  return data["id"];
}

Future<ChatModel> getChats(String threadId) async {
  var response = await dio.httpClient().get("Chat/getChat/$threadId");
  var parsed = ChatModel.fromJson(response.data);
  return parsed;
}

Future<ConversationModel> sendMsg(
  String senderId,
  String recieverId,
  String threadId,
  int chatType,
  String message,
  String senderName,
) async {
  FormData formData = new FormData.fromMap({
    "sender_id": senderId,
    "receiver_id": recieverId,
    "chat_type": chatType,
    "message": message,
    "sender_name": senderName,
    "thread_id": threadId,
  });
  var response = await dio.httpClient().post("Chat/sendmsg",
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType));
  var parsed = ConversationModel.fromJson(response.data);
  return parsed;
}
