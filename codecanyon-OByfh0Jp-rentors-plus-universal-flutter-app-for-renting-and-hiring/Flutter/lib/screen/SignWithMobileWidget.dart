import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentors/bloc/OTPVerifiedBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/SendOTPEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';

class SignWithMobileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignWithMobileWidgetState();
  }
}

class SignWithMobileWidgetState extends State<SignWithMobileWidget> {
  OTPVerifiedBloc otpVerifiedBloc = OTPVerifiedBloc();
  TextEditingController mobilenumberController = TextEditingController();
  String countryC0de = "+91";
  ProgressDialog dialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpVerifiedBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.show();
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state is OtpState) {
          var map = Map();
          map["verificationId"] = state.verificationId;
          map["mobileNumber"] = state.mobileNumber;
          map["number"] = mobilenumberController.text.trim();
          map["code"] = countryC0de;
          Navigator.of(context).pushNamed("/verify", arguments: map);
        } else if (state is ErrorState) {
          Fluttertoast.showToast(msg: state.home);
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
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).welcome,
                    style: TextStyle(
                        fontSize: 20, color: config.Colors().colorF26d42),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      autofocus: false,
                      controller: mobilenumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: S.of(context).mobileNumber,
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).mobileNumber,
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          prefixIcon: CountryCodePicker(
                            flagWidth: 20,
                            onChanged: (country) {
                              countryC0de = country.dialCode;
                            },
                            initialSelection: countryC0de,
                            showFlag: true,
                            showFlagDialog: true,
                            comparator: (a, b) => b.name.compareTo(a.name),
                            //Get the country information relevant to the initial selection
                          )),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: RentorRaisedButton(
                      child: Text(
                        S.of(context).login,
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      onPressed: () {
                        sendOTP();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        appBar: AppBar(
          title: Text(S.of(context).signinWithMobile),
          elevation: 0,
        ));
  }

  void sendOTP() {
    var mobileNumber = mobilenumberController.text.trim();
    if (mobileNumber.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter valid mobile number");
    } else {
      otpVerifiedBloc.add(SendOTPEvent(countryC0de, mobileNumber));
    }
  }
}
