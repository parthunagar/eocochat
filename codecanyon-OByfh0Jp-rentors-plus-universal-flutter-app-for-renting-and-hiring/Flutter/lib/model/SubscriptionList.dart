import 'package:rentors/model/FeatureSubscriptionList.dart';

class SubscriptionList {
  SubscriptionList({
    this.status,
    this.message,
    this.subscriptionData,
  });

  int status;
  String message;
  List<Feature> subscriptionData;

  factory SubscriptionList.fromJson(Map<String, dynamic> json) =>
      SubscriptionList(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        subscriptionData: json["Subscription_data"] == null
            ? null
            : List<Feature>.from(
                json["Subscription_data"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "Subscription_data": subscriptionData == null
            ? null
            : List<dynamic>.from(subscriptionData.map((x) => x.toJson())),
      };
}
