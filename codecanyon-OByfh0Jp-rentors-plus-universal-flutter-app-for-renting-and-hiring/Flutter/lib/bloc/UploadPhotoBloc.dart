import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/UploadPhotoEvent.dart';
import 'package:rentors/repo/BookingRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UploadPhotoDoneState.dart';

class UploadPhotoBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is UploadPhotoEvent) {
      yield ProgressDialogState();
      try {
        var response = await uploadPhoto(event.file);
        yield UploadPhotoDoneState(response, event.typeEnum);
      } catch (ex) {}
    }
  }
}
