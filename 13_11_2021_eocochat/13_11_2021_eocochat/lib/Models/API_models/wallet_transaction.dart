// To parse this JSON data, do
//
//     final walletTransaction = walletTransactionFromJson(jsonString);

import 'dart:convert';

WalletTransaction walletTransactionFromJson(String str) => WalletTransaction.fromJson(json.decode(str));

String walletTransactionToJson(WalletTransaction data) => json.encode(data.toJson());

class WalletTransaction {
  WalletTransaction({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) => WalletTransaction(
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

  int? userId;
  var amount,charge,trxType,postBalance,trx,details;
  DateTime? updatedAt,createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
