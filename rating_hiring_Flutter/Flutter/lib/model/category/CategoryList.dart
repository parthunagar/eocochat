import 'package:flutter/material.dart';
import 'package:rentors/HexColor.dart';
import 'package:rentors/model/category/CategoryDetailModel.dart';

class CategoryList {
  CategoryList({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Category> data;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        status: json["status"],
        message: json["message"],
        data:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Category {
  Category(
      {this.id,
      this.name,
      this.categoryImage,
      this.categoryIcon,
      this.status,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.subCategory,
      this.color});

  String id;
  String name;
  String categoryImage;
  String categoryIcon;
  String status;
  String deleted;
  String createdAt;
  String updatedAt;
  List<SubCategory> subCategory;
  Color color;

  factory Category.fromJson(Map<String, dynamic> json) {
    String color = json["category_color"];
    if (color==null) {
      color = "#F26D42";
    }
    return Category(
        id: json["id"],
        name: json["name"],
        categoryImage: json["category_image"],
        categoryIcon: json["category_icon"],
        status: json["status"],
        deleted: json["deleted"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        subCategory: List<SubCategory>.from(
            json["sub_category"].map((x) => SubCategory.fromJson(x))),
        color: HexColor(color));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_image": categoryImage,
        "category_icon": categoryIcon,
        "status": status,
        "deleted": deleted,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}
