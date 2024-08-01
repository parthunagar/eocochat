import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/SendOTPEvent.dart';
import 'package:rentors/event/SignWithMobileEvent.dart';
import 'package:rentors/event/VerifyOTPEvent.dart';
import 'package:rentors/model/ErrorResponse.dart';
import 'package:rentors/model/OtpResponse.dart';
import 'package:rentors/repo/LoginRepo.dart';
import 'package:rentors/repo/OTPRepositry.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SignInWithMobileState.dart';

class OTPVerifiedBloc extends Bloc<BaseEvent, BaseState> {
  @override
// TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is SendOTPEvent) {
      yield ProgressDialogState();
      var response = await sendOTP(event.countryCode, event.phoneNumber);
      if (response is OtpResponse) {
        yield OtpState(
            response.verificationId, event.countryCode + event.phoneNumber);
      } else if (response is ErrorResponse) {
        yield ErrorState(response.message);
      }
    } else if (event is VerifyOTPEvent) {
      yield ProgressDialogState();
      var response = await verifyOTP(event.verifiedId, event.smsCode);
      if (response is ErrorResponse) {
        yield ErrorState(response.message);
      } else {
        yield VerifiedOTPState();
      }
    } else if (event is SignWithMobileEvent) {
      yield ProgressDialogState();
      var response = await signWithMobile(
          event.mobileNumber, event.mobileNumber, event.token);
      yield SignInWithMobileState(response);
    }
  }
}
