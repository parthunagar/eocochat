// To parse this JSON data, do
//
//     final withDrawList = withDrawListFromJson(jsonString);

import 'dart:convert';

WithDrawList withDrawListFromJson(String str) => WithDrawList.fromJson(json.decode(str));

String withDrawListToJson(WithDrawList data) => json.encode(data.toJson());

class WithDrawList {
  WithDrawList({this.status, this.message, this.withDrawListData});

  int? status;
  String? message;
  List<WithDrawListDatum>? withDrawListData;

  factory WithDrawList.fromJson(Map<String, dynamic> json) => WithDrawList(
    status: json["status"],
    message: json["message"],
    withDrawListData: List<WithDrawListDatum>.from(json["data"].map((x) => WithDrawListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(withDrawListData!.map((x) => x.toJson())),
  };
}

class WithDrawListDatum {
  WithDrawListDatum({
    this.id, this.userId, this.amount, this.charge,
    this.postBalance, this.trxType, this.trx,
    this.details, this.createdAt, this.updatedAt
  });

  int? id;
  var userId,amount,charge,postBalance,trxType,trx,details;
  DateTime? createdAt,updatedAt;

  factory WithDrawListDatum.fromJson(Map<String, dynamic> json) => WithDrawListDatum(
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
