import 'dart:convert';

import 'package:rentors/model/home/HomeModel.dart';

class AddProductModel {
  AddProductModel({
    this.categoryId,
    this.details,
    this.name,
    this.subCategoryId,
    this.userId,
  });

  String categoryId;
  Details details;
  String name;
  String subCategoryId;
  String userId;

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      AddProductModel(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        details: json["details"] == null ? null : json["details"],
        name: json["name"] == null ? null : json["name"],
        subCategoryId:
            json["sub_category_id"] == null ? null : json["sub_category_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId == null ? null : categoryId,
        "details": details == null ? null : jsonEncode(details.toJson()),
        "name": name == null ? null : name,
        "sub_category_id": subCategoryId == null ? null : subCategoryId,
        "user_id": userId == null ? null : userId,
      };
}
