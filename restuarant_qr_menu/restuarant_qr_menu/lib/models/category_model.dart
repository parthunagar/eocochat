import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_menu/utils/model_keys.dart';

class CategoryModel {
  String? description;
  String? image;
  String? name;
  String? uid;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  CategoryModel({this.description, this.updatedAt, this.createdAt, this.image, this.name, this.uid});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      description: json[Categories.description],
      image: json[Categories.image],
      name: json[Categories.name],
      uid: json[CommonKeys.id],
      createdAt: json[CommonKeys.createdAt],
      updatedAt: json[CommonKeys.updatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[Categories.description] = this.description;
    data[Categories.image] = this.image;
    data[Categories.name] = this.name;
    data[CommonKeys.id] = this.uid;
    data[CommonKeys.createdAt] = this.createdAt;
    data[CommonKeys.updatedAt] = this.updatedAt;
    return data;
  }
}
