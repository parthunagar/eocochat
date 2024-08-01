import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/FeatureSubscriptionListEvent.dart';
import 'package:rentors/repo/SubscriptionRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/FeatureSubcriptionListState.dart';
import 'package:rentors/state/OtpState.dart';

class FeatureBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is FeatureSubscriptionListEvent) {
      yield ProgressDialogState();
      var response = await getFeatureSubscriptionList();
      yield FeatureSubscriptionListState(response);
    }
  }
}
