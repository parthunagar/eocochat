import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/AddProductEvent.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/UserDetailEvent.dart';
import 'package:rentors/repo/AddProductRepo.dart';
import 'package:rentors/repo/UserRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UserDetailState.dart';

class AddProductBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is AddProductEvent) {
      yield ProgressDialogState();
      var response;
      if (event.oldProduct != null) {
        response = await updateProduct(event.body, event.oldProduct.id);
      } else {
        response = await addProduct(event.body);
      }

      yield DoneState(response);
    }else if (event is UserDetailEvent) {
      yield LoadingState();
      var response = await getUserDetail();
      yield UserDetailState(response);
    }
  }
}
