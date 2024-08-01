import 'package:rentors/event/BaseEvent.dart';

class AddBookingEvent extends BaseEvent {
  final Map<String, dynamic> body;

  AddBookingEvent(this.body);
}
