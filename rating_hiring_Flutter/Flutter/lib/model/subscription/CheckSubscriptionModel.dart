import 'package:rentors/model/FeatureSubscriptionList.dart';

class CheckSubscriptionModel {
  CheckSubscriptionModel({
    this.status,
    this.message,
    this.isAddedProductCount,
    this.isSubscribed,
    this.data,
  });

  int status;
  String message;
  int isAddedProductCount;
  bool isSubscribed;
  List<Feature> data;

  factory CheckSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      CheckSubscriptionModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        isAddedProductCount: json["is_added_product_count"] == null
            ? null
            : json["is_added_product_count"],
        isSubscribed:
            json["is_subscribed"] == null ? null : json["is_subscribed"],
        data: json["data"] == null
            ? null
            : List<Feature>.from(json["data"].map((x) => Feature.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "is_added_product_count":
            isAddedProductCount == null ? null : isAddedProductCount,
        "is_subscribed": isSubscribed == null ? null : isSubscribed,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
