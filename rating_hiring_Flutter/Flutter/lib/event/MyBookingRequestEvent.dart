import 'package:rentors/event/BaseEvent.dart';

class MyBookingRequestEvent extends BaseEvent {
  final String id;
  MyBookingRequestEvent(this.id);
}
