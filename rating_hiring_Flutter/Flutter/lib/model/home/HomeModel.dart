import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentors/HexColor.dart';
import 'package:rentors/model/home/HomeBean.dart';
import 'package:rentors/util/Utils.dart';

class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.homeSliderImage,
    this.category,
    this.featuredProducts,
    this.products,
    this.near_by_search,
    this.sliderImage,
  });

  List<HomeSliderImage> homeSliderImage;
  List<Category> category;
  List<FeaturedProductElement> featuredProducts;
  List<PurpleProduct> products;
  List<FeaturedProductElement> near_by_search;
  List<dynamic> sliderImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        homeSliderImage: List<HomeSliderImage>.from(
            json["home_slider_image"].map((x) => HomeSliderImage.fromJson(x))),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        featuredProducts: List<FeaturedProductElement>.from(
            json["featured_products"]
                .map((x) => FeaturedProductElement.fromJson(x))),
        products: List<PurpleProduct>.from(
            json["products"].map((x) => PurpleProduct.fromJson(x))),
    near_by_search: List<FeaturedProductElement>.from(
            json["near_by_search"].map((x) => FeaturedProductElement.fromJson(x))),
        sliderImage: List<dynamic>.from(json["slider_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "home_slider_image":
            List<dynamic>.from(homeSliderImage.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "featured_products":
            List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "slider_image": List<dynamic>.from(sliderImage.map((x) => x)),
      };
}

class Category {
  Category(
      {this.id, this.name, this.categoryIcon, this.color, this.subCategory});

  String id;
  String name;
  String categoryIcon;
  Color color;
  List<CategorySubCategory> subCategory;

  factory Category.fromJson(Map<String, dynamic> json) {
    String color = json["category_color"];
    if (color==null||color.isEmpty) {
      color = "#F26D42";
    }
    return Category(
      id: json["id"],
      name: json["name"],
      categoryIcon: json["category_icon"],
      color: HexColor(color),
      subCategory: json["sub_category"] == null
          ? null
          : List<CategorySubCategory>.from(
              json["sub_category"].map((x) => CategorySubCategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_icon": categoryIcon,
        "sub_category": subCategory == null
            ? null
            : List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class CategorySubCategory {
  CategorySubCategory({
    this.id,
    this.name,
    this.subCatIcon,
  });

  String id;
  String name;
  String subCatIcon;

  factory CategorySubCategory.fromJson(Map<String, dynamic> json) =>
      CategorySubCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subCatIcon: json["sub_cat_icon"] == null ? null : json["sub_cat_icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "sub_cat_icon": subCatIcon == null ? null : subCatIcon,
      };
}

class FeaturedProductElement extends HomeBean {
  FeaturedProductElement({
    this.subscriptionId,
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
    this.distance,
  });

  dynamic subscriptionId;
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
  String distance;

  factory FeaturedProductElement.fromJson(Map<String, dynamic> json) =>
      FeaturedProductElement(
        subscriptionId: json["subscription_id"],
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
        isLike: json["is_like"].toString(),
        distance: json["distance"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "subscription_id": subscriptionId,
        "id": id,
        "product_id": productId,
        "name": name,
        "details": details.toJson(),
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
      };
}

class Details {
  Details(
      {this.address,
      this.category,
      this.city,
      this.description,
      this.document,
      this.fileds,
      this.images,
      this.minBookingAmount,
      this.mobileNo,
      this.name,
      this.price,
      this.priceUnit,
      this.productName,
      this.subcategory,
      this.allImages,this.lat,this.lng,this.city_id});

  String address;
  String category;
  String city;
  String description;
  String document;
  List<Filed> fileds;
  String images;
  String minBookingAmount;
  String mobileNo;
  String name;
  String price;
  PriceUnit priceUnit;
  String productName;
  String subcategory;
  String allImages;
  String lat;
  String lng;
  String city_id;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
      address: json["address"],
      category: json["category"],
      city: json["city"],
      description: json["description"],
      document: json["document"],
      fileds: json["fileds"] != null
          ? List<Filed>.from(json["fileds"].map((x) => Filed.fromJson(x)))
          : List<Filed>(),
      images: Utils.getImageUrl(json["images"]),
      minBookingAmount: json["min_booking_amount"],
      mobileNo: json["mobile_no"],
      name: json["name"],
      price: json["price"],
      priceUnit: priceUnitValues.map[json["price_unit"]],
      productName: json["product_name"],
      subcategory: json["subcategory"],
      allImages: json["images"],city_id:json["city_id"],lat: json["lat"],lng: json['lng']);

  Map<String, dynamic> toJson() => {
        "address": address,
        "category": category,
        "city": city,
        "description": description,
        "document": document,
        "fileds": List<dynamic>.from(fileds.map((x) => x.toJson())),
        "images": images,
        "min_booking_amount": minBookingAmount,
        "mobile_no": mobileNo,
        "name": name,
        "price": price,
        "price_unit": priceUnitValues.reverse[priceUnit],
        "product_name": productName,
        "subcategory": subcategory,
        "lat": lat,
        "lng": lng,
        "city_id": city_id,
      };
}

class Filed {
  Filed({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Filed.fromJson(Map<String, dynamic> json) => Filed(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

enum PriceUnit { DAY, MONTH, HOUR }

final priceUnitValues = EnumValues(
    {"Day": PriceUnit.DAY, "Hour": PriceUnit.HOUR, "Month": PriceUnit.MONTH});

class HomeSliderImage {
  HomeSliderImage({
    this.image,
  });

  String image;

  factory HomeSliderImage.fromJson(Map<String, dynamic> json) =>
      HomeSliderImage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class PurpleProduct {
  PurpleProduct({
    this.category,
    this.subCategory,
  });

  String category;
  List<SubCategory> subCategory;

  factory PurpleProduct.fromJson(Map<String, dynamic> json) => PurpleProduct(
        category: json["category"],
        subCategory: List<SubCategory>.from(
            json["sub_category"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class SubCategory extends HomeBean {
  SubCategory({
    this.subCategoryName,
    this.products,
  });

  String subCategoryName;
  String subCategoryId;
  List<FeaturedProductElement> products;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subCategoryName: json["sub_category_name"],
        products: List<FeaturedProductElement>.from(
            json["products"].map((x) => FeaturedProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sub_category_name": subCategoryName,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
