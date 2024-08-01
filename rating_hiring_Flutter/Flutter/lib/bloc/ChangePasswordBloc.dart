import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/ChangePasswordEvent.dart';
import 'package:rentors/repo/ChangePasswordRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';

class ChangePasswordBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ChangePasswordEvent) {
      yield ProgressDialogState();
      var response = await changePassword(event.newPassword);
      yield DoneState(response);
    }
  }
}
