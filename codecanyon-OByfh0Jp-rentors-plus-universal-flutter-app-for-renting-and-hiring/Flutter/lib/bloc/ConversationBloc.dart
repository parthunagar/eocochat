import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/ChatEvent.dart';
import 'package:rentors/event/ConversationEvent.dart';
import 'package:rentors/event/SendMessageEvent.dart';
import 'package:rentors/repo/ChatRepo.dart' as categoryRepo;
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ChatState.dart';
import 'package:rentors/state/ConversationState.dart';
import 'package:rentors/state/OtpState.dart';

class ConversationBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ConversationEvent) {
      yield LoadingState();
      var response = await categoryRepo.getConversation();
      yield ConversationState(response);
    } else if (event is ChatEvent) {
      yield LoadingState();
      var threadId =
          await categoryRepo.getThreadId(event.senderId, event.recieverId);
      var response = await categoryRepo.getChats(threadId);
      yield ChatState(response, threadId);
    } else if (event is SendMessageEvent) {
      yield ProgressDialogState();
      await categoryRepo.sendMsg(event.senderId, event.recieverId,
          event.threadId, event.chatType, event.message, event.senderName);
      var threadId =
          await categoryRepo.getThreadId(event.senderId, event.recieverId);
      var response = await categoryRepo.getChats(threadId);
      yield ChatState(response, threadId);
    }
  }
}
