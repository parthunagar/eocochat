import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiberchat/Reasturant/utils/model_keys.dart';

class MenuModel {
  String? uid;
  String? description;
  String? image;
  String? category;
  String? categoryId;
  bool? isJain;
  bool? isNew;
  bool? isPopular;
  bool? isSpecial;
  bool? isSpicy;
  bool? isSweet;
  bool? isVeg;
  String? name;
  List<String>? ingredient;
  int? price;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  MenuModel({
    this.uid,
    this.description,
    this.image,
    this.category,
    this.categoryId,
    this.isJain,
    this.isNew,
    this.isPopular,
    this.isSpecial,
    this.updatedAt,
    this.createdAt,
    this.isSpicy,
    this.ingredient,
    this.isSweet,
    this.isVeg,
    this.name,
    this.price,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      uid: json[CommonKeys.id],
      description: json[Menus.description],
      image: json[Menus.image],
      category: json[Menus.category],
      categoryId: json[Menus.categoryId],
      isJain: json[Menus.isJain],
      isNew: json[Menus.isNew],
      isPopular: json[Menus.isPopular],
      isSpecial: json[Menus.isSpecial],
      isSpicy: json[Menus.isSpicy],
      isSweet: json[Menus.isSweet],
      isVeg: json[Menus.isVeg],
      name: json[Menus.name],
      price: json[Menus.price],
      ingredient: json[Menus.ingredient] != null ? new List<String>.from(json[Menus.ingredient]) : null,
      createdAt: json[CommonKeys.createdAt],
      updatedAt: json[CommonKeys.updatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CommonKeys.id] = this.uid;
    data[Menus.description] = this.description;
    data[Menus.image] = this.image;
    data[Menus.category] = this.category;
    data[Menus.categoryId] = this.categoryId;
    data[Menus.isJain] = this.isJain;
    data[Menus.isNew] = this.isNew;
    data[Menus.isPopular] = this.isPopular;
    data[Menus.isSpecial] = this.isSpecial;
    data[Menus.isSpicy] = this.isSpicy;
    data[Menus.isSweet] = this.isSweet;
    data[Menus.isVeg] = this.isVeg;
    data[Menus.name] = this.name;
    data[Menus.price] = this.price;
    if (this.ingredient != null) {
      data[Menus.ingredient] = this.ingredient;
    }
    data[CommonKeys.createdAt] = this.createdAt;
    data[CommonKeys.updatedAt] = this.updatedAt;
    return data;
  }
}
