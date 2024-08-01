import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/AddBookingEvent.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/CityEvent.dart';
import 'package:rentors/event/UploadPhotoEvent.dart';
import 'package:rentors/repo/BookingRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UploadPhotoDoneState.dart';

class BookingProductBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();
  bool isUploading = false;

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is CityEvent) {
      yield LoadingState();
      var response = await getCity();
      yield CityState(response);
    } else if (event is UploadPhotoEvent) {
      print("isUploding $isUploading");
      yield ProgressDialogState();
      try {
        var response = await uploadPhoto(event.file);
        yield UploadPhotoDoneState(response, event.typeEnum);
      } catch (ex) {}
      isUploading = false;
    } else if (event is AddBookingEvent) {
      yield ProgressDialogState();
      var response = await addBookingProduct(event.body);
      yield DoneState(response);
    }
  }
}
