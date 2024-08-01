import 'package:rentors/event/BaseEvent.dart';

class SendMessageEvent extends BaseEvent {
  final String senderId, recieverId, threadId, message, senderName;
  final int chatType;

  SendMessageEvent(this.senderId, this.recieverId, this.threadId, this.chatType,
      this.message, this.senderName);
}
