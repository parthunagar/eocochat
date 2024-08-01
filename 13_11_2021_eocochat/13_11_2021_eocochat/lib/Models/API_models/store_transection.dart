// To parse this JSON data, do
//
//     final storeTransaction = storeTransactionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StoreTransaction storeTransactionFromJson(String str) => StoreTransaction.fromJson(json.decode(str));

String storeTransactionToJson(StoreTransaction data) => json.encode(data.toJson());

class StoreTransaction {
  StoreTransaction({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory StoreTransaction.fromJson(Map<String, dynamic> json) => StoreTransaction(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.senderData,
    this.receivedData,
  });

  ReceivedDataClass? senderData;
  ReceivedDataClass? receivedData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    senderData: ReceivedDataClass.fromJson(json["sender_data"]),
    receivedData: ReceivedDataClass.fromJson(json["received_data"]),
  );

  Map<String, dynamic> toJson() => {
    "sender_data": senderData!.toJson(),
    "received_data": receivedData!.toJson(),
  };
}

class ReceivedDataClass {
  ReceivedDataClass({
    this.userId,
    this.amount,
    this.charge,
    this.trxType,
    this.postBalance,
    this.trx,
    this.details,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? userId,id;
  var amount,charge,trxType,trx,details,postBalance;
  DateTime? updatedAt,createdAt;

  factory ReceivedDataClass.fromJson(Map<String, dynamic> json) => ReceivedDataClass(
    userId: json["user_id"],
    amount: json["amount"],
    charge: json["charge"],
    trxType: json["trx_type"],
    postBalance: json["post_balance"],
    trx: json["trx"],
    details: json["details"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "amount": amount,
    "charge": charge,
    "trx_type": trxType,
    "post_balance": postBalance,
    "trx": trx,
    "details": details,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
  };
}
