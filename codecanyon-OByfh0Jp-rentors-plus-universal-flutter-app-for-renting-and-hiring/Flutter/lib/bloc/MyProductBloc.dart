import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/ChangeProductStatusEvent.dart';
import 'package:rentors/event/DeleteProductEvent.dart';
import 'package:rentors/event/GetMyProductEvent.dart';
import 'package:rentors/repo/MyProductRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/MyProductState.dart';
import 'package:rentors/state/OtpState.dart';

class MyProductBloc extends Bloc<BaseEvent, BaseState> {
  @override
// TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetMyProductEvent) {
      yield LoadingState();
      var response = await getMyProduct();
      yield MyProductState(response);
    } else if (event is DeleteProductEvent) {
      yield ProgressDialogState();
      var response = await deleteProduct(event.productId);
      yield DoneState(response);
    } else if (event is ChangeProductStatusEvent) {
      yield ProgressDialogState();
      var response = await changeStatus(event.id, event.status);
      yield DoneState(response);
    }
  }
}
