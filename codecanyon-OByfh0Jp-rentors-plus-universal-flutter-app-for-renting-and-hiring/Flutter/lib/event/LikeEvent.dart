import 'package:rentors/event/BaseEvent.dart';

class LikeEvent extends BaseEvent {
 final String productId;

  LikeEvent(this.productId);
}
