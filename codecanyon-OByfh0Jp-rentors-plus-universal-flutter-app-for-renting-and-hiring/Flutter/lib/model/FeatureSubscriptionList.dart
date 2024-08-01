import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FeatureSubscriptionList {
  FeatureSubscriptionList({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Feature> data;

  factory FeatureSubscriptionList.fromJson(Map<String, dynamic> json) =>
      FeatureSubscriptionList(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Feature>.from(json["data"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

@immutable
class Feature extends Equatable {
  Feature(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.status,
      this.currencyType,
      this.createdAt,
      this.updatedAt,
      this.period,
      this.type,
      this.isSelected});

  final String id;
  final String title;
  final String description;
  final String price;
  final String status;
  final String currencyType;
  final String createdAt;
  final String updatedAt;
  final String period;
  final String type;
  final bool isSelected;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      description: json["description"] == null ? null : json["description"],
      price: json["price"] == null ? null : json["price"],
      status: json["status"] == null ? null : json["status"],
      currencyType:
          json["currency_type"] == null ? null : json["currency_type"],
      createdAt: json["created_at"] == null ? null : json["created_at"],
      updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      period: json["period"] == null ? null : json["period"],
      type: json["type"] == null ? null : json["type"],
      isSelected: false);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
        "currency_type": currencyType == null ? null : currencyType,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "period": period == null ? null : period,
        "type": type == null ? null : type,
      };

  @override
  List<Object> get props => [id];
}

extension FeatureExt on Feature {
  Feature get markUnSelected {
    return Feature(
        id: this.id,
        title: this.title,
        description: this.description,
        price: this.price,
        status: this.status,
        currencyType: this.currencyType,
        createdAt: this.createdAt,
        updatedAt: this.updatedAt,
        period: this.period,
        type: this.type,
        isSelected: false);
  }

  Feature get markSelected {
    return Feature(
        id: this.id,
        title: this.title,
        description: this.description,
        price: this.price,
        status: this.status,
        currencyType: this.currencyType,
        createdAt: this.createdAt,
        updatedAt: this.updatedAt,
        period: this.period,
        type: this.type,
        isSelected: true);
  }
}
