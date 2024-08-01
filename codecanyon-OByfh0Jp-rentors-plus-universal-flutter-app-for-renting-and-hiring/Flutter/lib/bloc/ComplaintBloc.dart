import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/ComplaintEvent.dart';
import 'package:rentors/repo/ComplaintRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';

class ComplaintBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ComplaintEvent) {
      yield ProgressDialogState();
      var response = await complaint(event.title, event.message);
      yield DoneState(response);
    }
  }
}
