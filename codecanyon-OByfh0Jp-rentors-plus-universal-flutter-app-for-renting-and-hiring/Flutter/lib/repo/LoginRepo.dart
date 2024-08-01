import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flurry_event/flurry.dart';
import 'package:flutter/material.dart';
import 'package:rentors/model/Response.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

ValueNotifier<bool> sessionExpired = ValueNotifier(false);

Future<Response> signWithEmail(
    String email, String password, String token) async {
  var map = Map<String, String>();
  map["email"] = email;
  map["password"] = password;
  var firebase = FirebaseMessaging.instance;
  token = await firebase.getToken();

  map["device_token"] = token;
  var response = await dio.httpClient().post("auth/login", data: map);
  var parse = Response.fromJson(response.data);
  if (parse.status == 200) {
    await Utils.save(response.toString());
    var userModel = UserModel.fromJson(response.data);
    var map = Map<String, String>();
    map["email"] = userModel.data.email;
    map["token"] = token;
    await FlurryEvent.logEvent("Token", params: map);
    return userModel;
  } else {
    return parse;
  }
}

Future<Response> signWithMobile(
    String mobileNumber, String countryCode, String token) async {
  var map = Map<String, String>();
  map["mobile"] = mobileNumber;
  map["country_code"] = countryCode;
  var firebase = FirebaseMessaging.instance;
  token = await firebase.getToken();
  map["device_token"] = token;
  var response = await dio.httpClient().post("auth/loginMobile", data: map);
  var parse = Response.fromJson(response.data);
  if (parse.status == 200) {
    await Utils.save(response.toString());
    return UserModel.fromJson(response.data);
  } else {
    return parse;
  }
}

Future<Response> forgotPassword(String emailAddress) async {
  var map = Map<String, String>();
  map["email"] = emailAddress;
  var response =
      await dio.httpClient().post("auth/forgotUserPassword", data: map);
  var parse = Response.fromJson(response.data);
  if (parse.status == 200) {
    await Utils.save(response.toString());
    return UserModel.fromJson(response.data);
  } else {
    return parse;
  }
}

Future<Response> sendEmail(
    String emailAddress, String subject, String msg) async {
  var map = Map<String, String>();
  map["emailto"] = emailAddress;
  map["text"] = msg;
  map["subject"] = subject;
  var response =
      await dio.httpClient().post("auth/send_email_to_user", data: map);
  var parse = Response.fromJson(response.data);
  return parse;
}

Future<Response> signupEvent(
    String emailAddress, String password, String name, String type) async {
  var map = Map<String, String>();
  map["email"] = emailAddress;
  map["password"] = password;
  map["type"] = type;
  map["name"] = name;
  var response = await dio.httpClient().post("auth/signup", data: map);
  var parse = Response.fromJson(response.data);

  return parse;
}
Future<Response> socialLoginEvent(String social_type, String social_id,
    String first_name, String last_name, String device_token) async {
  var map = Map<String, String>();
  map["social_type"] = social_type;
  map["social_id"] = social_id;
  map["first_name"] = first_name;
  map["last_name"] = last_name;
  map["device_token"] = device_token;
  var response =
  await dio.httpClient().post("auth/socialMobileLogin", data: map);
  var parse = Response.fromJson(response.data);
  if (parse.status == 200) {
    await Utils.save(response.toString());
    return UserModel.fromJson(response.data);
  } else {
    return parse;
  }
}
