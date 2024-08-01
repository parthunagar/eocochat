// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({this.status, this.message, this.registerData});

  int? status;
  String? message;
  RegisterData? registerData;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    status: json["status"],
    message: json["message"],
    registerData: RegisterData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": registerData!.toJson(),
  };
}

class RegisterData {
  RegisterData({
    this.email, this.mobile, this.username,
    this.countryCode, this.accountNumber, this.updatedAt,
    this.createdAt, this.id});

  var email,mobile,username,countryCode,accountNumber;
  DateTime? updatedAt,createdAt;
  int? id;

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
    email: json["email"],
    mobile: json["mobile"],
    username: json["username"],
    countryCode: json["country_code"],
    accountNumber: json["account_number"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
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
  };
}
