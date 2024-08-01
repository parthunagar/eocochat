import 'package:rentors/model/chat/ChatModel.dart';
import 'package:rentors/state/BaseState.dart';

class ChatState extends BaseState {
  final ChatModel chat;
  final String threadId;

  ChatState(this.chat, this.threadId);
}
