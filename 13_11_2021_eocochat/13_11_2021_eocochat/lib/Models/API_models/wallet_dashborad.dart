// To parse this JSON data, do
//
//     final walletDashBoard = walletDashBoardFromJson(jsonString);

import 'dart:convert';

WalletDashBoard walletDashBoardFromJson(String str) => WalletDashBoard.fromJson(json.decode(str));

String walletDashBoardToJson(WalletDashBoard data) => json.encode(data.toJson());

class WalletDashBoard {
  int? status;
  String? message;
  WalletDashBoardData? walletDashBoardData;

  WalletDashBoard({this.status, this.message, this.walletDashBoardData});

  factory WalletDashBoard.fromJson(Map<String, dynamic> json) => WalletDashBoard(
    status: json["status"],
    message: json["message"],
    walletDashBoardData: WalletDashBoardData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": walletDashBoardData!.toJson(),
  };
}

class WalletDashBoardData {
  UserData? userData;
  var accountNumber,balance,totalDeposit,totalWithdraw,totalTransaction;

  WalletDashBoardData({this.userData, this.accountNumber, this.balance, this.totalDeposit, this.totalWithdraw, this.totalTransaction});

  factory WalletDashBoardData.fromJson(Map<String, dynamic> json) => WalletDashBoardData(
    userData: UserData.fromJson(json["User_data"]) ,
    accountNumber: json["Account_number"],
    balance: json["Balance"],
    totalDeposit: json["total_deposit"],
    totalWithdraw: json["total_withdraw"],
    totalTransaction: json["total_transaction"],
  );

  Map<String, dynamic> toJson() => {
    "User_data": userData!.toJson(),
    "Account_number": accountNumber,
    "Balance": balance,
    "total_deposit": totalDeposit,
    "total_withdraw": totalWithdraw,
    "total_transaction": totalTransaction,
  };
}

class UserData {
  UserData({
    this.id, this.accountNumber, this.firstname,
    this.lastname, this.username, this.email, this.countryCode, this.mobile, this.refBy,
    this.balance, this.image, this.address, this.status, this.ev, this.sv, this.verCode,
    this.verCodeSendAt, this.ts, this.tv, this.tsc, this.createdAt, this.updatedAt,
  });

  int? id;
  var accountNumber,firstname,lastname,username,email,countryCode,mobile,refBy,balance,status,ev,sv,ts,tv;
  Address? address;
  dynamic image,tsc,verCode,verCodeSendAt;
  DateTime? createdAt,updatedAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    accountNumber: json["account_number"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    refBy: json["ref_by"],
    balance: json["balance"],
    image: json["image"],
    // address: Address.fromJson(json["address"] == null ? [] : json["address"]),
    status: json["status"],
    ev: json["ev"],
    sv: json["sv"],
    verCode: json["ver_code"],
    verCodeSendAt: json["ver_code_send_at"],
    ts: json["ts"],
    tv: json["tv"],
    tsc: json["tsc"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_number": accountNumber,
    "firstname": firstname,
    "lastname": lastname,
    "username": username,
    "email": email,
    "country_code": countryCode,
    "mobile": mobile,
    "ref_by": refBy,
    "balance": balance,
    "image": image,
    // "address": address!.toJson(),
    "status": status,
    "ev": ev,
    "sv": sv,
    "ver_code": verCode,
    "ver_code_send_at": verCodeSendAt,
    "ts": ts,
    "tv": tv,
    "tsc": tsc,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Address {
  Address({this.address, this.city, this.state, this.zip, this.country});

  String? address,city,zip,country;
  dynamic state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "state": state,
    "zip": zip,
    "country": country,
  };
}
