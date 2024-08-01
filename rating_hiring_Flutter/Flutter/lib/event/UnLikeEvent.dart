import 'package:rentors/event/BaseEvent.dart';

class UnLikeEvent extends BaseEvent {
  final String productId;

  UnLikeEvent(this.productId);
}
