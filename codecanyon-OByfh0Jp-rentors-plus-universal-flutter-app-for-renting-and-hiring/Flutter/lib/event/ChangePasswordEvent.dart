import 'package:rentors/event/BaseEvent.dart';

class ChangePasswordEvent extends BaseEvent {
  final String newPassword;

  ChangePasswordEvent(this.newPassword);
}
