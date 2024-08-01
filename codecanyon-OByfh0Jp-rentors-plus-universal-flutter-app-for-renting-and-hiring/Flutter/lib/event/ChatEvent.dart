import 'package:rentors/event/BaseEvent.dart';

class ChatEvent extends BaseEvent {
  final String senderId, recieverId, threadId;

  ChatEvent(this.senderId, this.recieverId, this.threadId);
}
