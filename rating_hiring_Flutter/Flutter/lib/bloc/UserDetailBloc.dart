import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/CityEvent.dart';
import 'package:rentors/event/UpdateUserDetailEvent.dart';
import 'package:rentors/event/UploadPhotoEvent.dart';
import 'package:rentors/event/UserDetailEvent.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/repo/BookingRepo.dart';
import 'package:rentors/repo/UserRepo.dart' as product;
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UploadPhotoDoneState.dart';
import 'package:rentors/state/UserDetailState.dart';
import 'package:rentors/util/Utils.dart';

class UserDetailBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is CityEvent) {
      yield LoadingState();
      var response = await getCity();
      yield CityState(response);
    }else if (event is UserDetailEvent) {
      yield LoadingState();
      var response = await product.getUserDetail();
      yield UserDetailState(response);
    } else if (event is UpdateUserDetailEvent) {
      yield ProgressDialogState();
      var response = await product.updateUserDetails(event.body);
      var details = await product.getUserDetail();
      UserModel model = await Utils.getUser();
      model.data.profileImage = details.data.profilePic;
      await Utils.save(jsonEncode(model.toJson()));
      yield DoneState(response);
    }else if (event is UploadPhotoEvent) {
      yield ProgressDialogState();
      try {
        var response = await uploadPhoto(event.file);
        yield UploadPhotoDoneState(response, event.typeEnum);
      } catch (ex) {}
    }
  }
}
