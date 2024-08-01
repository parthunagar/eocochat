import 'package:rentors/event/BaseEvent.dart';

class ForgotPasswordEvent extends BaseEvent {
  final String emailAddress;

  ForgotPasswordEvent(this.emailAddress);
}
