import 'package:rentors/model/home/HomeModel.dart';

class AppProductModel {
  AppProductModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  AppProduct data;

  factory AppProductModel.fromJson(Map<String, dynamic> json) =>
      AppProductModel(
        status: json["status"],
        message: json["message"],
        data: AppProduct.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class AppProduct {
  AppProduct({
    this.recommendedProduct,
    this.nearProduct,
    this.product,
  });

  List<FeaturedProductElement> recommendedProduct;
  List<FeaturedProductElement> nearProduct;
  List<FeaturedProductElement> product;

  factory AppProduct.fromJson(Map<String, dynamic> json) => AppProduct(
        recommendedProduct: List<FeaturedProductElement>.from(
            json["recommended_product"]
                .map((x) => FeaturedProductElement.fromJson(x))),
        nearProduct: List<FeaturedProductElement>.from(json["near_product"]
            .map((x) => FeaturedProductElement.fromJson(x))),
        product: List<FeaturedProductElement>.from(
            json["product"].map((x) => FeaturedProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recommended_product":
            List<dynamic>.from(recommendedProduct.map((x) => x.toJson())),
        "near_product": List<dynamic>.from(nearProduct.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}
