import 'package:rentors/state/BaseState.dart';

class LoadingState extends BaseState {}

class ProgressDialogState extends BaseState {}

class EmptyState extends BaseState {}

class OtpState extends BaseState {
  final String verificationId;
  final String mobileNumber;
  final String countryCode;
  final String number;

  OtpState(this.verificationId, this.mobileNumber,
      {this.number, this.countryCode});
}

class VerifiedOTPState extends BaseState {
  VerifiedOTPState();
}
