// To parse this JSON data, do
//
//     final debit = debitFromJson(jsonString);

import 'dart:convert';

Debit debitFromJson(String str) => Debit.fromJson(json.decode(str));

String debitToJson(Debit data) => json.encode(data.toJson());

class Debit {
  Debit({this.status, this.message, this.data});

  int? status;
  String? message;
  List<DebitDatum>? data;

  factory Debit.fromJson(Map<String, dynamic> json) => Debit(
    status: json["status"],
    message: json["message"],
    data: List<DebitDatum>.from(json["data"].map((x) => DebitDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DebitDatum {
  DebitDatum({
    this.id, this.userId, this.amount, this.charge,
    this.postBalance, this.trxType, this.trx,
    this.details, this.createdAt, this.updatedAt
  });

  int? id;
  var userId,amount,charge,postBalance,trxType,trx,details;
  DateTime? createdAt,updatedAt;

  factory DebitDatum.fromJson(Map<String, dynamic> json) => DebitDatum(
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
