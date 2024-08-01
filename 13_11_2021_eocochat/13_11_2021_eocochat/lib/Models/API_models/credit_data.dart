// To parse this JSON data, do
//
//     final credit = creditFromJson(jsonString);

import 'dart:convert';

Credit creditFromJson(String str) => Credit.fromJson(json.decode(str));

String creditToJson(Credit data) => json.encode(data.toJson());

class Credit {
  Credit({this.status, this.message, this.data});

  int? status;
  String? message;
  List<CreditDatum>? data;

  factory Credit.fromJson(Map<String, dynamic> json) => Credit(
    status: json["status"],
    message: json["message"],
    data: List<CreditDatum>.from(json["data"].map((x) => CreditDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CreditDatum {
  CreditDatum({
    this.id, this.userId,
    this.amount, this.charge, this.postBalance, this.trxType,
    this.trx, this.details, this.createdAt, this.updatedAt
  });

  int? id;
  var userId,amount,charge,postBalance,trxType,trx,details;
  DateTime? createdAt,updatedAt;

  factory CreditDatum.fromJson(Map<String, dynamic> json) => CreditDatum(
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
