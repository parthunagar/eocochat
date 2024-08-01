import 'package:rentors/model/FeatureSubscriptionList.dart';
import 'package:rentors/model/SubscriptionList.dart';
import 'package:rentors/model/subscription/CheckSubscriptionModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<FeatureSubscriptionList> getFeatureSubscriptionList() async {
  var response =
      await dio.httpClient().get("Subscription/get_feature_subscription");
  return FeatureSubscriptionList.fromJson(response.data);
}

Future<SubscriptionList> getSubscriptionList() async {
  var user = await Utils.getUser();
  var response = await dio
      .httpClient()
      .get("subscription/get_subscription_list/" + user.data.id);
  return SubscriptionList.fromJson(response.data);
}

Future<CheckSubscriptionModel> checkSubscription() async {
  var user = await Utils.getUser();
  var response = await dio
      .httpClient()
      .get("subscription/check_user_subscription/" + user.data.id);
  return CheckSubscriptionModel.fromJson(response.data);
}
