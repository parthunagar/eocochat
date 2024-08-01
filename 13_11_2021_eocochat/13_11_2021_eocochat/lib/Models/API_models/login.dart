// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({this.status, this.message, this.lginData,});

  int? status;
  String? message;
  LoginData? lginData;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json["status"],
    message: json["message"],
    lginData: LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": lginData!.toJson(),
  };
}

class LoginData {
  LoginData({
    this.email, this.mobile,
    this.username, this.countryCode,
    this.accountNumber, this.updatedAt,
    this.createdAt, this.id,this.deviceToken
  });

  var email,mobile,username,countryCode,accountNumber,deviceToken;
  DateTime? updatedAt,createdAt;
  int? id;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    email: json["email"],
    mobile: json["mobile"],
    username: json["username"],
    countryCode: json["country_code"],
    accountNumber: json["account_number"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    deviceToken: json['device_token'],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "mobile": mobile,
    "username": username,
    "country_code": countryCode,
    "account_number": accountNumber,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
    "device_token" : deviceToken,
  };
}
