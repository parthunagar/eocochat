import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/AddReviewEvent.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/RequestReviewEvent.dart';
import 'package:rentors/repo/ReviewRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';

class ReviewBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is AddReviewEvent) {
      yield LoadingState();
      var response =
          await addReview(event.productId, event.rating, event.comment);
      yield DoneState(response);
    } else if (event is RequestReviewEvent) {
      yield ProgressDialogState();
      var response =
          await requestReview(event.receiverUserId, event.productId);
      yield DoneState(response);
    }
  }
}
