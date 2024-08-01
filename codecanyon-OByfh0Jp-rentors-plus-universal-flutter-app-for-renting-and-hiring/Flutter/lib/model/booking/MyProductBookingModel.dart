import 'dart:convert';

import 'package:rentors/model/home/HomeModel.dart';

class MyProductBookingModel {
  MyProductBookingModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<MyProductBooking> data;

  factory MyProductBookingModel.fromJson(Map<String, dynamic> json) =>
      MyProductBookingModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<MyProductBooking>.from(
                json["data"].map((x) => MyProductBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyProductBooking {
  MyProductBooking({
    this.productId,
    this.productName,
    this.details,
    this.userId,
    this.userName,
    this.userLastName,
    this.userImage,
    this.mobile,
    this.countryCode,
    this.userEmail,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.docDl,
    this.docId,
    this.bookingUserName,
    this.priceUnit,
    this.period,
    this.status,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
  });

  int bookingId = DateTime.now().microsecondsSinceEpoch;
  String productId;
  String productName;
  Details details;
  String userId;
  String userName;
  String userLastName;
  String userImage;
  String mobile;
  String countryCode;
  String userEmail;
  String address;
  String city;
  String state;
  String pincode;
  String docDl;
  String docId;
  String bookingUserName;
  String priceUnit;
  String period;
  String status;
  DateTime startDate;
  DateTime endDate;
  String startTime;
  String endTime;

  factory MyProductBooking.fromJson(Map<String, dynamic> json) =>
      MyProductBooking(
        productId: json["product_id"] == null ? null : json["product_id"],
        productName: json["product_name"] == null ? null : json["product_name"],
        details: json["details"] == null
            ? null
            : Details.fromJson(jsonDecode(json["details"])),
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userLastName:
            json["user_last_name"] == null ? null : json["user_last_name"],
        userImage: json["user_image"] == null ? null : json["user_image"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        userEmail: json["user_email"] == null ? null : json["user_email"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        docDl: json["doc_dl"] == null ? null : json["doc_dl"],
        docId: json["doc_id"] == null ? null : json["doc_id"],
        bookingUserName: json["booking_user_name"] == null
            ? null
            : json["booking_user_name"],
        priceUnit: json["price_unit"] == null ? null : json["price_unit"],
        period: json["period"] == null ? null : json["period"],
        status: json["status"] == null ? null : json["status"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "product_name": productName == null ? null : productName,
        "details": details == null ? null : details,
        "user_id": userId == null ? null : userId,
        "user_name": userName == null ? null : userName,
        "user_last_name": userLastName == null ? null : userLastName,
        "user_image": userImage == null ? null : userImage,
        "mobile": mobile == null ? null : mobile,
        "country_code": countryCode == null ? null : countryCode,
        "user_email": userEmail == null ? null : userEmail,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "pincode": pincode == null ? null : pincode,
        "doc_dl": docDl == null ? null : docDl,
        "doc_id": docId == null ? null : docId,
        "booking_user_name": bookingUserName == null ? null : bookingUserName,
        "price_unit": priceUnit == null ? null : priceUnit,
        "period": period == null ? null : period,
        "status": status == null ? null : status,
        "start_date": startDate == null ? null : startDate.toIso8601String(),
        "end_date": endDate == null ? null : endDate.toIso8601String(),
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
      };
}
