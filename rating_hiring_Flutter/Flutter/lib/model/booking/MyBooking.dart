import 'dart:convert';

import 'package:rentors/model/home/HomeModel.dart';

class MyBooking {
  MyBooking({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory MyBooking.fromJson(Map<String, dynamic> json) => MyBooking(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) {
                var infp = Datum.fromJson(x);
                print("BookingId " + infp.bookingId.toString());
                return infp;
              }))
            : List<Datum>(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.productId,
    this.productName,
    this.productAddress,
    this.productImage,
    this.productOwnerName,
    this.productOwnerNumber,
    this.productDetails,
    this.userId,
    this.userName,
    this.userLastName,
    this.userMobile,
    this.userEmail,
    this.userProfileImage,
    this.bookingAddress,
    this.bookingCity,
    this.bookingState,
    this.bookingPincode,
    this.bookingDocDl,
    this.bookingDocId,
    this.bookingUserName,
    this.period,
    this.priceUnit,
    this.payableAmount,
    this.bookingStatus,
    this.bookingStartDate,
    this.bookingStartTime,
    this.bookingEndDate,
    this.bookingEndTime,
  });

  int bookingId = DateTime.now().microsecondsSinceEpoch;
  String productId;
  String productName;
  String productAddress;
  List<ProductImage> productImage;
  String productOwnerName;
  String productOwnerNumber;
  Details productDetails;
  String userId;
  String userName;
  String userLastName;
  String userMobile;
  String userEmail;
  String userProfileImage;
  String bookingAddress;
  String bookingCity;
  String bookingState;
  String bookingPincode;
  String bookingDocDl;
  String bookingDocId;
  String bookingUserName;
  String period;
  String priceUnit;
  String payableAmount;
  String bookingStatus;
  DateTime bookingStartDate;
  String bookingStartTime;
  DateTime bookingEndDate;
  String bookingEndTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["product_id"],
        productName: json["product_name"],
        productAddress: json["product_address"],
        productImage: List<ProductImage>.from(
            json["product_image"].map((x) => ProductImage.fromJson(x))),
        productOwnerName: json["product_owner_name"],
        productOwnerNumber: json["product_owner_number"],
        productDetails: json["product_details"] != null
            ? Details.fromJson(jsonDecode(json["product_details"]))
            : null,
        userId: json["user_id"],
        userName: json["user_name"],
        userLastName: json["user_last_name"],
        userMobile: json["user_mobile"],
        userEmail: json["user_email"],
        userProfileImage: json["user_profile_image"],
        bookingAddress: json["booking_address"],
        bookingCity: json["booking_city"],
        bookingState: json["booking_state"],
        bookingPincode: json["booking_pincode"],
        bookingDocDl: json["booking_doc_dl"],
        bookingDocId: json["booking_doc_id"],
        bookingUserName: json["booking_user_name"],
        period: json["period"],
        priceUnit: json["price_unit"],
        payableAmount: json["payable_amount"],
        bookingStatus: json["booking_status"],
        bookingStartDate: DateTime.parse(json["booking_start_date"]),
        bookingStartTime: json["booking_start_time"],
        bookingEndDate: DateTime.parse(json["booking_end_date"]),
        bookingEndTime: json["booking_end_time"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_address": productAddress,
        "product_image":
            List<dynamic>.from(productImage.map((x) => x.toJson())),
        "product_owner_name": productOwnerName,
        "product_owner_number": productOwnerNumber,
        "product_details": productDetails,
        "user_id": userId,
        "user_name": userName,
        "user_last_name": userLastName,
        "user_mobile": userMobile,
        "user_email": userEmail,
        "user_profile_image": userProfileImage,
        "booking_address": bookingAddress,
        "booking_city": bookingCity,
        "booking_state": bookingState,
        "booking_pincode": bookingPincode,
        "booking_doc_dl": bookingDocDl,
        "booking_doc_id": bookingDocId,
        "booking_user_name": bookingUserName,
        "period": period,
        "price_unit": priceUnit,
        "payable_amount": payableAmount,
        "booking_status": bookingStatus,
        "booking_start_date": bookingStartDate.toIso8601String(),
        "booking_start_time": bookingStartTime,
        "booking_end_date": bookingEndDate.toIso8601String(),
        "booking_end_time": bookingEndTime,
      };
}

class ProductImage {
  ProductImage({
    this.image,
  });

  String image;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
