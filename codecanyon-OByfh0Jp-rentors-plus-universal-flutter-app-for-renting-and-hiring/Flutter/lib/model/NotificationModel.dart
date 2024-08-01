class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Notification> data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Notification>.from(
                json["data"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Notification {
  Notification({
    this.id,
    this.userId,
    this.title,
    this.type,
    this.msg,
    this.createdAt,
  });

  String id;
  String userId;
  String title;
  String type;
  String msg;
  DateTime createdAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        msg: json["msg"] == null ? null : json["msg"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "msg": msg == null ? null : msg,
        "created_at": createdAt == null ? null : createdAt,
      };
}
