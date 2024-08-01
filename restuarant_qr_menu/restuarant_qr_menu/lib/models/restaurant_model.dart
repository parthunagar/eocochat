import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_menu/utils/model_keys.dart';

class RestaurantModel {
  String? address;
  String? contact;
  String? currency;
  String? description;
  String? email;
  String? image;
  String? logoImage;
  String? name;
  bool? isVeg;
  bool? isNonVeg;
  String? uid;
  String? userId;
  int? newItemForDays;
  Timestamp? newItemValidForDays;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  RestaurantModel({
    this.address,
    this.userId,
    this.contact,
    this.currency,
    this.logoImage,
    this.newItemValidForDays,
    this.updatedAt,
    this.createdAt,
    this.description,
    this.email,
    this.image,
    this.newItemForDays,
    this.name,
    this.isVeg,
    this.isNonVeg,
    this.uid,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      address: json[Restaurants.address],
      contact: json[Restaurants.contact],
      currency: json[Restaurants.currency],
      description: json[Restaurants.description],
      email: json[Restaurants.email],
      image: json[Restaurants.image],
      name: json[Restaurants.name],
      newItemValidForDays: json[Restaurants.newItemValidForDays],
      logoImage: json[Restaurants.logoImage],
      newItemForDays: json[Restaurants.newItemForDays],
      userId: json[Restaurants.userId],
      isVeg: json[Restaurants.isVeg],
      isNonVeg: json[Restaurants.isNonVeg],
      uid: json[CommonKeys.id],
      createdAt: json[CommonKeys.createdAt],
      updatedAt: json[CommonKeys.updatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[Restaurants.address] = this.address;
    data[Restaurants.contact] = this.contact;
    data[Restaurants.currency] = this.currency;
    data[Restaurants.description] = this.description;
    data[Restaurants.email] = this.email;
    data[Restaurants.newItemValidForDays] = this.newItemValidForDays;
    data[Restaurants.image] = this.image;
    data[Restaurants.name] = this.name;
    data[Restaurants.logoImage] = this.logoImage;
    data[Restaurants.userId] = this.userId;
    data[Restaurants.isVeg] = this.isVeg;
    data[Restaurants.newItemForDays] = this.newItemForDays;
    data[Restaurants.isNonVeg] = this.isNonVeg;
    data[CommonKeys.id] = this.uid;
    data[CommonKeys.createdAt] = this.createdAt;
    data[CommonKeys.updatedAt] = this.updatedAt;
    return data;
  }
}
