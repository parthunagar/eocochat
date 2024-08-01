import 'package:rentors/event/BaseEvent.dart';

class SignWithEmailEvent extends BaseEvent {
  final String email;
  final String password;
  final String token;

  SignWithEmailEvent(this.email, this.password, this.token);
}
