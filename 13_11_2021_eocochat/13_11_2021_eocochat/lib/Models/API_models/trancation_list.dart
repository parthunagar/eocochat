// To parse this JSON data, do
//
//     final transactionList = transactionListFromJson(jsonString);

import 'dart:convert';

TransactionList transactionListFromJson(String str) => TransactionList.fromJson(json.decode(str));

String transactionListToJson(TransactionList data) => json.encode(data.toJson());

class TransactionList {
  TransactionList({this.status, this.message, this.transactionListData});

  int? status;
  String? message;
  List<TransactionListDatum>? transactionListData;

  factory TransactionList.fromJson(Map<String, dynamic> json) => TransactionList(
    status: json["status"],
    message: json["message"],
    transactionListData: List<TransactionListDatum>.from(json["TransactionListData"].map((x) => TransactionListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "TransactionListData": List<dynamic>.from(transactionListData!.map((x) => x.toJson())),
  };
}

class TransactionListDatum {
  TransactionListDatum({
    this.id, this.userId, this.amount, this.charge,
    this.postBalance, this.trxType, this.trx,
    this.details, this.createdAt, this.updatedAt
  });

  int? id;
  var userId,amount,charge,postBalance,trxType,trx,details;
  DateTime? createdAt,updatedAt;

  factory TransactionListDatum.fromJson(Map<String, dynamic> json) => TransactionListDatum(
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
