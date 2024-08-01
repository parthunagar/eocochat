class ConversationModel {
  ConversationModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Conversation> data;

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    var list = List<Conversation>.from(
        json["data"].map((x) => Conversation.fromJson(x)));
    list.sort((a, b) => DateTime.fromMillisecondsSinceEpoch(b.date * 1000)
        .compareTo(DateTime.fromMillisecondsSinceEpoch(a.date * 1000)));
    return ConversationModel(
      status: json["status"],
      message: json["message"],
      data: list,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Conversation {
  Conversation({
    this.id,
    this.senderId,
    this.receiverId,
    this.image,
    this.firstName,
    this.lastName,
    this.lastMsg,
    this.senderName,
    this.date,
  });

  String id;
  String senderId;
  String receiverId;
  String image;
  String firstName;
  String lastName;
  String lastMsg;
  String senderName;
  int date;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        image: json["image"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        lastMsg: json["last_msg"],
        senderName: json["sender_name"],
        date:
            int.tryParse(json["date"]) == null ? 0 : int.tryParse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "image": image,
        "first_name": firstName,
        "last_name": lastName,
        "last_msg": lastMsg,
        "sender_name": senderName,
        "date": date,
      };
}
