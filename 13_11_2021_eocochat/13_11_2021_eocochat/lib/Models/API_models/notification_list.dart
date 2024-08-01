// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    this.status,
    this.message,
    this.notificationData,
  });

  int? status;
  String? message;
  List<NotificationDatum>? notificationData;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    status: json["status"],
    message: json["message"],
    notificationData: List<NotificationDatum>.from(json["NotificationData"].map((x) => NotificationDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "NotificationData": List<dynamic>.from(notificationData!.map((x) => x.toJson())),
  };
}

class NotificationDatum {
  NotificationDatum({
    this.id,
    this.senderUserId,
    this.receiverUserId,
    this.senderUsername,
    this.receiverUsername,
    this.transactionId,
    this.trxType,
    this.trx,
    this.amount,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  var id,senderUserId,receiverUserId,transactionId;
  String? senderUsername,receiverUsername;
  String? trxType,trx,amount,title,description;
  DateTime? createdAt,updatedAt;

  factory NotificationDatum.fromJson(Map<String, dynamic> json) => NotificationDatum(
    id: json["id"],
    senderUserId: json["sender_user_id"],
    receiverUserId: json["receiver_user_id"],
    senderUsername: json["sender_username"],
    receiverUsername: json["receiver_username"],
    transactionId: json["transaction_id"],
    trxType: json["trx_type"],
    trx: json["trx"],
    amount: json["amount"],
    title: json["title"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_user_id": senderUserId,
    "receiver_user_id": receiverUserId,
    "sender_username": senderUsername,
    "receiver_username": receiverUsername,
    "transaction_id": transactionId,
    "trx_type": trxType,
    "trx": trx,
    "amount": amount,
    "title": title,
    "description": description,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
