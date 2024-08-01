import 'dart:convert';

import 'package:rentors/model/home/HomeModel.dart';

class MyProductModel {
  MyProductModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<MyProduct> data;

  factory MyProductModel.fromJson(Map<String, dynamic> json) => MyProductModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<MyProduct>.from(
                json["data"].map((x) => MyProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyProduct {
  MyProduct({
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

  factory MyProduct.fromJson(Map<String, dynamic> json) => MyProduct(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        name: json["name"] == null ? null : json["name"],
        details: json["details"] == null
            ? null
            : Details.fromJson(jsonDecode(json["details"])),
        categoryId: json["category_id"] == null ? null : json["category_id"],
        subCategoryId:
            json["sub_category_id"] == null ? null : json["sub_category_id"],
        categoryName: json["category_name"],
        subCategoryName: json["sub_category_name"],
        isFeatured: json["is_featured"] == null ? null : json["is_featured"],
        featuredAt: json["featured_at"] == null
            ? null
            : DateTime.parse(json["featured_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        userId: json["user_id"] == null ? null : json["user_id"],
        status: json["status"] == null ? null : json["status"],
        isDelete: json["is_delete"] == null ? null : json["is_delete"],
        isApproved: json["is_approved"] == null ? null : json["is_approved"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "name": name == null ? null : name,
        "details": details == null ? null : details,
        "category_id": categoryId == null ? null : categoryId,
        "sub_category_id": subCategoryId == null ? null : subCategoryId,
        "category_name": categoryName,
        "sub_category_name": subCategoryName,
        "is_featured": isFeatured == null ? null : isFeatured,
        "featured_at": featuredAt == null ? null : featuredAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt,
        "user_id": userId == null ? null : userId,
        "status": status == null ? null : status,
        "is_delete": isDelete == null ? null : isDelete,
        "is_approved": isApproved == null ? null : isApproved,
      };
}
