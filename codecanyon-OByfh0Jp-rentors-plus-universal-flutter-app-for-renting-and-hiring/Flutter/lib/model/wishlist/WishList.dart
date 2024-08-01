import 'dart:convert';

import 'package:rentors/model/home/HomeModel.dart';

class WishList {
  WishList({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<WishItem> data;

  factory WishList.fromJson(Map<String, dynamic> json) => WishList(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<WishItem>.from(json["data"].map((x) => WishItem.fromJson(x)))
            : List<WishItem>(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WishItem {
  WishItem({
    this.wishUserId,
    this.wishProductId,
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

  String wishUserId;
  String wishProductId;
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

  factory WishItem.fromJson(Map<String, dynamic> json) => WishItem(
        wishUserId: json["wish_user_id"],
        wishProductId: json["wish_product_id"],
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
      );

  Map<String, dynamic> toJson() => {
        "wish_user_id": wishUserId,
        "wish_product_id": wishProductId,
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
      };
}
