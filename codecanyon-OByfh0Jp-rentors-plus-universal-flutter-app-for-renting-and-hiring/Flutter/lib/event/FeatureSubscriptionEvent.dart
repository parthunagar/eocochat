import 'package:rentors/event/BaseEvent.dart';

class FeatureSubscriptionEvent extends BaseEvent {
  final String productId;
  final String subscriptionid;
  final String details;

  FeatureSubscriptionEvent(this.productId, this.subscriptionid, this.details);
}
