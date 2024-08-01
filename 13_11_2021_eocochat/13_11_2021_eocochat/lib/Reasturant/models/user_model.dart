import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiberchat/Reasturant/utils/model_keys.dart';

class UserModel {
  String? email;
  String? uid;
  String? name;
  String? num;
  String? image;
  bool? isEmailLogin;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  UserModel({this.email, this.uid, this.name, this.num, this.updatedAt, this.image, this.isEmailLogin, this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json[Users.email],
      uid: json[CommonKeys.id],
      name: json[Users.name],
      num: json[Users.num],
      image: json[Users.image],
      isEmailLogin: json[Users.isEmailLogin],
      createdAt: json[CommonKeys.createdAt],
      updatedAt: json[CommonKeys.updatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[Users.email] = this.email;
    data[CommonKeys.id] = this.uid;
    data[Users.name] = this.name;
    data[Users.num] = this.num;
    data[Users.image] = this.image;
    data[Users.isEmailLogin] = this.isEmailLogin;
    data[CommonKeys.createdAt] = this.createdAt;
    data[CommonKeys.updatedAt] = this.updatedAt;
    return data;
  }
}
