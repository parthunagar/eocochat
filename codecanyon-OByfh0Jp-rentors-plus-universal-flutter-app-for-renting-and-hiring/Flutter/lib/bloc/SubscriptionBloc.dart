import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/SubscriptionListEvent.dart';
import 'package:rentors/repo/SubscriptionRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SubscriptionListState.dart';

class SubscriptionBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is SubscriptionListEvent) {
      yield LoadingState();
      try {
        var response = await getSubscriptionList();
        yield SubscriptionListState(response);
      } catch (ex) {
        yield ErrorState(ex.toString());
      }
    }
  }
}
