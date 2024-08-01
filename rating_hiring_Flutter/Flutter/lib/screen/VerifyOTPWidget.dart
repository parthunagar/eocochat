import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentors/bloc/OTPVerifiedBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/SendOTPEvent.dart';
import 'package:rentors/event/SignWithMobileEvent.dart';
import 'package:rentors/event/VerifyOTPEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SignInWithMobileState.dart';
import 'package:rentors/widget/PinEntryTextField.dart';
import 'package:rentors/widget/ProgressDialog.dart';

class VerifyOTPWidget extends StatefulWidget {
  final String verificaitonId;
  final String mobileNumber;
  final String mobile;
  final String code;

  VerifyOTPWidget(
      this.verificaitonId, this.mobileNumber, this.mobile, this.code);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VerifyOTPWidgetState();
  }
}

class VerifyOTPWidgetState extends State<VerifyOTPWidget> {
  OTPVerifiedBloc otpVerifiedBloc = OTPVerifiedBloc();
  ProgressDialog dialog;
  String verificationid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationid = widget.verificaitonId;
    otpVerifiedBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.show();
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state is VerifiedOTPState) {
          dialog = ProgressDialog(context, isDismissible: true);
          dialog.show();
          otpVerifiedBloc
              .add(SignWithMobileEvent(widget.mobile, widget.code, 'token'));
        } else if (state is ErrorState) {
          Fluttertoast.showToast(msg: state.home);
        } else if (state is SignInWithMobileState) {
          if (state.model is UserModel) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false);
          } else {
            Fluttertoast.showToast(msg: state.model.message);
          }
        } else if (state is OtpState) {
          print(verificationid);
          verificationid = state.verificationId;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              child: Image.asset("assets/img/splash/signin_background.jpeg",
                  fit: BoxFit.fill,
                  width: config.App(context).appWidth(100),
                  height: config.App(context).appHeight(100)),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                        S.of(context).weSentYouACodeToVerifyYourPhoneNumber,
                        style: TextStyle(
                            fontSize: 16, color: config.Colors().color545454),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      S.of(context).sentTo(widget.mobileNumber),
                      style: TextStyle(
                          fontSize: 14, color: config.Colors().accentColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 30),
                    child: PinEntryTextField(
                      fieldWidth: 50.0,
                      fields: 6,
                      isTextObscure: true,
                      onSubmit: (value) {
                        if (value.length == 6) {
                          verifyOTP(value);
                        }
                      },
                      showFieldAsBox: true,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      S.of(context).iDidntRecieveACode,
                      style: TextStyle(
                          fontSize: 14, color: config.Colors().accentColor),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      resendOTP();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        S.of(context).resend,
                        style: TextStyle(
                            fontSize: 14, color: config.Colors().orangeColor),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(S.of(context).verifyPhone),
          elevation: 0,
        ));
  }

  void verifyOTP(String code) {
    print(verificationid);
    otpVerifiedBloc.add(VerifyOTPEvent(verificationid, code));
  }

  void resendOTP() {
    otpVerifiedBloc.add(SendOTPEvent(widget.code, widget.mobile));
  }
}
