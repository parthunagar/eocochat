import 'package:rentors/model/Response.dart';

class UserModel extends Response {
  UserModel({
    this.status,
    this.message,
    this.data,
  }) : super(status, message);

  int status;
  String message;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data(
      {this.id,
      this.token,
      this.email,
      this.password,
      this.name,
      this.profileImage});

  String id;
  String token;
  String email;
  String password;
  String name;
  String profileImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      token: json["token"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      profileImage: json['user_profile']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "email": email,
        "password": password,
        "name": name,
        "user_profile": profileImage
      };
}
