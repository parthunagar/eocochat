// To parse this JSON data, do
//
//     final depositList = depositListFromJson(jsonString);

import 'dart:convert';

DepositList depositListFromJson(String str) => DepositList.fromJson(json.decode(str));

String depositListToJson(DepositList data) => json.encode(data.toJson());

class DepositList {
  DepositList({this.status, this.message, this.depositListData});

  int? status;
  String? message;
  List<DepositListDatum>? depositListData;

  factory DepositList.fromJson(Map<String, dynamic> json) => DepositList(
    status: json["status"],
    message: json["message"],
    depositListData: List<DepositListDatum>.from(json["data"].map((x) => DepositListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(depositListData!.map((x) => x.toJson())),
  };
}

class DepositListDatum {
  DepositListDatum({
    this.id, this.userId, this.amount, this.charge,
    this.postBalance, this.trxType, this.trx,
    this.details, this.createdAt, this.updatedAt
  });

  int? id;
  var userId,amount,charge,postBalance,trxType,trx,details;
  DateTime? createdAt,updatedAt;

  factory DepositListDatum.fromJson(Map<String, dynamic> json) => DepositListDatum(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    charge: json["charge"],
    postBalance: json["post_balance"],
    trxType: json["trx_type"],
    trx: json["trx"],
    details: json["details"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "charge": charge,
    "post_balance": postBalance,
    "trx_type": trxType,
    "trx": trx,
    "details": details,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
