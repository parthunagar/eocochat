import 'package:rentors/event/BaseEvent.dart';

class UpdateUserDetailEvent extends BaseEvent {
  final Map body;

  UpdateUserDetailEvent(this.body);
}
