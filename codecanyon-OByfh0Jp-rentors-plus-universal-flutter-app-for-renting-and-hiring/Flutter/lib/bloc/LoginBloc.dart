import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/ForgotPasswordEvent.dart';
import 'package:rentors/event/SendEmaiEvent.dart';
import 'package:rentors/event/SignWithEmailEvent.dart';
import 'package:rentors/event/SignupEvent.dart';
import 'package:rentors/event/SocialLoginEvent.dart';
import 'package:rentors/repo/LoginRepo.dart' as homeRepo;
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/EmailSentState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SignInWithEmailState.dart';

class LoginBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is SignWithEmailEvent) {
      yield ProgressDialogState();
      var response = await homeRepo.signWithEmail(
          event.email, event.password, event.token);
      yield SignInWithEmailState(response);
    } else if (event is ForgotPasswordEvent) {
      yield ProgressDialogState();
      var response = await homeRepo.forgotPassword(event.emailAddress);
      yield DoneState(response);
    } else if (event is SendEmaiEvent) {
      yield ProgressDialogState();
      var response =
          await homeRepo.sendEmail(event.email, event.subject, event.msg);
      yield EmailSentState(response);
    }
    if (event is SignupEvent) {
      yield ProgressDialogState();
      var response = await homeRepo.signupEvent(
          event.email, event.password, event.name, event.type);
      yield SignInWithEmailState(response);
    }if (event is SocialLoginEvent) {
      yield ProgressDialogState();
      var response = await homeRepo.socialLoginEvent(
          event.social_type, event.social_id, event.first_name, event.last_name,event.device_token);
      yield SignInWithEmailState(response);
    }
  }
}
