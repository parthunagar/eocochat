import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/LikeEvent.dart';
import 'package:rentors/event/UnLikeEvent.dart';
import 'package:rentors/repo/WishListRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';

class WishBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is LikeEvent) {
      yield ProgressDialogState();
      try {
        var response = await like(event.productId);
        yield DoneState(response);
      } catch (ex) {
        yield ErrorState(ex.toString());
      }
    } else if (event is UnLikeEvent) {
      yield ProgressDialogState();
      try {
        var response = await unlike(event.productId);
        yield DoneState(response);
      } catch (ex) {
        yield ErrorState(ex.toString());
      }
    }
  }
}
