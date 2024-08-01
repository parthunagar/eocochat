import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/GetNotificationEvent.dart';
import 'package:rentors/repo/NotificationRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/NotificationListState.dart';
import 'package:rentors/state/OtpState.dart';

class NotificationBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetNotificationEvent) {
      yield LoadingState();
      var response = await getNotification();
      yield NotificationListState(response);
    }
  }
}
