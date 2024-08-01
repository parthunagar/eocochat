import 'dart:convert';

import 'package:rentors/model/home/HomeModel.dart';

class ProductDetailModel {
  ProductDetailModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.productId,
    this.name,
    this.details,
    this.categoryId,
    this.subCategoryId,
    this.categoryName,
    this.subCategoryName,
    this.isFeatured,
    this.featuredAt,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.status,
    this.isDelete,
    this.isApproved,
    this.isLike,
    this.userName,
    this.userImage,
    this.avgRatting,
    this.verificationRequired,
    this.reviewdata,
    this.distance,
    this.lat,
    this.lng,
  });

  String id;
  String productId;
  String name;
  Details details;
  String categoryId;
  String subCategoryId;
  dynamic categoryName;
  dynamic subCategoryName;
  String isFeatured;
  DateTime featuredAt;
  DateTime createdAt;
  String updatedAt;
  String userId;
  String status;
  String isDelete;
  String isApproved;
  String isLike;
  String userName;
  String userImage;
  String avgRatting;
  String distance;
  String lat;
  String lng;
  bool verificationRequired;
  List<Reviewdatum> reviewdata;

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
          id: json["id"],
          productId: json["product_id"],
          name: json["name"],
          details: Details.fromJson(jsonDecode(json["details"])),
          categoryId: json["category_id"],
          subCategoryId: json["sub_category_id"],
          categoryName: json["category_name"],
          subCategoryName: json["sub_category_name"],
          isFeatured: json["is_featured"],
          featuredAt: DateTime.parse(json["featured_at"]),
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"],
          userId: json["user_id"],
          status: json["status"],
          isDelete: json["is_delete"],
          isApproved: json["is_approved"],
          isLike: json["is_like"],
          userName: json["user_name"],
          userImage: json["user_image"],
          avgRatting: json["avg_ratting"],
        distance: json["distance"].toString(),
        lat: json["lat"],
        lng: json["lng"],
          verificationRequired:
          json["verification_required"] != null ? json["verification_required"]
              .toLowerCase() == '1' : false,
          reviewdata: List<Reviewdatum>.from(
      json["reviewdata"].map((x)

  =>

  Reviewdatum.fromJson(x)

  )

  )

  ,

  );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "product_id": productId,
        "name": name,
        "details": details,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "category_name": categoryName,
        "sub_category_name": subCategoryName,
        "is_featured": isFeatured,
        "featured_at": featuredAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "user_id": userId,
        "status": status,
        "is_delete": isDelete,
        "is_approved": isApproved,
        "is_like": isLike,
        "user_name": userName,
        "user_image": userImage,
        "avg_ratting": avgRatting,
        "verification_required": verificationRequired,
        "reviewdata": List<dynamic>.from(reviewdata.map((x) => x.toJson())),
      };
}

class Reviewdatum {
  Reviewdatum({
    this.userId,
    this.ratting,
    this.review,
    this.createdAt,
    this.name,
    this.email,
    this.profilePic,
  });

  String userId;
  String ratting;
  String review;
  DateTime createdAt;
  String name;
  String email;
  String profilePic;

  factory Reviewdatum.fromJson(Map<String, dynamic> json) =>
      Reviewdatum(
        userId: json["user_id"],
        ratting: json["ratting"],
        review: json["review"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        email: json["email"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() =>
      {
        "user_id": userId,
        "ratting": ratting,
        "review": review,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "email": email,
        "profile_pic": profilePic,
      };
}
