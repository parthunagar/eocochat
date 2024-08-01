import 'package:rentors/event/BaseEvent.dart';

class BookingStatusEvent extends BaseEvent {
  final String productId, buyerId, status;

  BookingStatusEvent(this.productId, this.buyerId, this.status);
}
