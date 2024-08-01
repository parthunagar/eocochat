import 'package:rentors/event/BaseEvent.dart';

class SendEmaiEvent extends BaseEvent {
  final String msg;

  final String email;

  final String subject;

  SendEmaiEvent(this.email, this.subject, this.msg);
}
