import 'package:rentors/model/Response.dart';
import 'package:rentors/state/BaseState.dart';

class EmailSentState extends BaseState {
  final Response home;

  EmailSentState(this.home);
}
