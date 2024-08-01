import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/BookingStatusEvent.dart';
import 'package:rentors/event/MyBookingEvent.dart';
import 'package:rentors/event/MyBookingRequestEvent.dart';
import 'package:rentors/event/MyProductBookingEvent.dart';
import 'package:rentors/repo/BookingRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/MyBookingState.dart';
import 'package:rentors/state/MyProductBookingState.dart';
import 'package:rentors/state/OtpState.dart';

class BookingBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is MyBookingEvent) {
      yield LoadingState();
      var response = await getBookingRepo();
      yield MyBookingState(response);
    } else if (event is MyProductBookingevent) {
      yield LoadingState();
      var response = await getMyProductBooking();
      yield MyProductBookingState(response);
    } else if (event is MyBookingRequestEvent) {
      yield LoadingState();
      var response = await getBookingRequestList(event.id);
      yield MyBookingState(response);
    } else if (event is BookingStatusEvent) {
      yield ProgressDialogState();
      var response = await changeBookingStatus(
          event.productId, event.buyerId, event.status);
      yield DoneState(response);
    }
  }
}
