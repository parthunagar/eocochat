// To parse this JSON data, do
//
//     final userQrCode = userQrCodeFromJson(jsonString);

import 'dart:convert';

UserQrCode userQrCodeFromJson(String str) => UserQrCode.fromJson(json.decode(str));

String userQrCodeToJson(UserQrCode data) => json.encode(data.toJson());

class UserQrCode {
  UserQrCode({this.status, this.message, this.userQrCodeData});

  int? status;
  String? message;
  UserQrCodeData? userQrCodeData;

  factory UserQrCode.fromJson(Map<String, dynamic> json) => UserQrCode(
    status: json["status"],
    message: json["message"],
    userQrCodeData: UserQrCodeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": userQrCodeData!.toJson(),
  };
}

class UserQrCodeData {
  UserQrCodeData({this.id, this.accountNumber, this.username, this.email, this.mobile,this.deviceToken});

  int? id;
  var accountNumber,username,email,mobile,deviceToken;

  factory UserQrCodeData.fromJson(Map<String, dynamic> json) => UserQrCodeData(
    id: json["id"],
    accountNumber: json["account_number"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_number": accountNumber,
    "username": username,
    "email": email,
    "mobile": mobile,
    "device_token": deviceToken,
  };
}
