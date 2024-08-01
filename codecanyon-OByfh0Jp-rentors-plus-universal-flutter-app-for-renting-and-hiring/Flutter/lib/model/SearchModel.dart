import 'dart:convert';

import 'package:rentors/model/home/HomeModel.dart';

class SearchModel {
  SearchModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<FeaturedProductElement> data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        message: json["message"],
        data: List<FeaturedProductElement>.from(
            json["data"].map((x) => FeaturedProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchItem {
  SearchItem({
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
    this.distance,
  });

  String id;
  String productId;
  String name;
  Details details;
  String categoryId;
  String subCategoryId;
  String categoryName;
  String subCategoryName;
  String isFeatured;
  DateTime featuredAt;
  DateTime createdAt;
  String updatedAt;
  String userId;
  String status;
  String isDelete;
  String isApproved;
  String distance;

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
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
    distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
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
        "distance": distance,
      };
}
