import 'package:rentors/model/home/HomeModel.dart';

class SubCategoryDetailModel {
  SubCategoryDetailModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory SubCategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryDetailModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.recommendedProduct,
    this.nearProduct,
    this.product,
  });

  List<FeaturedProductElement> recommendedProduct;
  List<FeaturedProductElement> nearProduct;
  List<FeaturedProductElement> product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        recommendedProduct: json["recommended_product"] == null
            ? null
            : List<FeaturedProductElement>.from(json["recommended_product"]
                .map((x) => FeaturedProductElement.fromJson(x))),
        nearProduct: json["near_product"] == null
            ? null
            : List<FeaturedProductElement>.from(json["near_product"]
                .map((x) => FeaturedProductElement.fromJson(x))),
        product: json["product"] == null
            ? null
            : List<FeaturedProductElement>.from(
                json["product"].map((x) => FeaturedProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recommended_product": recommendedProduct == null
            ? null
            : List<dynamic>.from(recommendedProduct.map((x) => x.toJson())),
        "near_product": nearProduct == null
            ? null
            : List<dynamic>.from(nearProduct.map((x) => x.toJson())),
        "product": product == null
            ? null
            : List<dynamic>.from(product.map((x) => x.toJson())),
      };
}
