class ChatModel {
  ChatModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Chat> data;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<Chat>.from(json["data"].map((x) => Chat.fromJson(x)))
            : List<Chat>(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.id,
    this.threadId,
    this.userId,
    this.userIdReceiver,
    this.message,
    this.senderName,
    this.date,
    this.media,
    this.chatType,
    this.chatState,
  });

  String id;
  String threadId;
  String userId;
  String userIdReceiver;
  String message;
  String senderName;
  String date;
  String media;
  String chatType;
  String chatState;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        threadId: json["thread_id"],
        userId: json["user_id"],
        userIdReceiver: json["user_id_receiver"],
        message: json["message"],
        senderName: json["sender_name"],
        date: json["date"],
        media: json["media"],
        chatType: json["chat_type"],
        chatState: json["chat_state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thread_id": threadId,
        "user_id": userId,
        "user_id_receiver": userIdReceiver,
        "message": message,
        "sender_name": senderName,
        "date": date,
        "media": media,
        "chat_type": chatType,
        "chat_state": chatState,
      };
}
