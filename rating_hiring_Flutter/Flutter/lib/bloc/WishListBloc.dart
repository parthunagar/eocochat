import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/WishListEvent.dart';
import 'package:rentors/repo/WishListRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/WishListState.dart';

class WishListBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is WishListEvent) {
      try {
        yield LoadingState();
        var response = await getWishList();
        yield WishListState(response);
      } catch (exception) {
        yield ErrorState(exception.toString());
      }
    }
  }
}
