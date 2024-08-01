import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentors/bloc/LoginBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/SendEmaiEvent.dart';
import 'package:rentors/event/SignupEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/EmailSentState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SignInWithEmailState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/PasswordField.dart';
import 'package:rentors/widget/PinEntryTextField.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:rentors/widget/RoundedFloatingField.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  LoginBloc mBloc = LoginBloc();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  ProgressDialog dialog;

  String otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.show();
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state is DoneState) {
          Fluttertoast.showToast(msg: state.home.message);
          // Navigator.of(context).pop();
        } else if (state is EmailSentState) {
          Fluttertoast.showToast(msg: state.home.message);
          var email = emailController.text.trim().toString();
          showInputDialog(email);
        } else if (state is SignInWithEmailState) {
          Fluttertoast.showToast(msg: state.model.message);
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(S.of(context).signUpUsingEmail),
          centerTitle: true,
        ),
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
                    margin: EdgeInsets.only(top: 20),
                    child: RoundedFloatingField(
                      label: S.of(context).name,
                      controller: nameController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RoundedFloatingField(
                      controller: emailController,
                      label: S.of(context).enterYourEmail,
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: PasswordField(
                      controller: passwordController,
                      hint: S.of(context).password,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: RentorRaisedButton(
                      child: Text(
                        S.of(context).createAccount,
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      onPressed: () {
                        validate(context);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void validate(BuildContext context) {
    var email = emailController.text.trim().toString();
    var password = passwordController.text.trim().toString();
    var name = passwordController.text.trim().toString();
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterName);
      return;
    } else if (password.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterPassword);
      return;
    } else if (EmailValidator.validate(email)) {
      otp = Utils.generateOTP();
      var msg = S.of(context).yourEmailVerificationOtpIs(otp);
      mBloc.add(SendEmaiEvent(email, "Rentors", msg));
    } else {
      Fluttertoast.showToast(msg: S.of(context).enterValidEmailAddress);
    }
  }

  void showInputDialog(String mobileNumber) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: config.App(context).appHeight(30),
              width: config.App(context).appWidth(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      S.of(context).weHaveSentEmailToYourEmailAddress,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        mobileNumber,
                        style: TextStyle(
                            color: config.Colors().orangeColor, fontSize: 15),
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: PinEntryTextField(
                          fieldWidth: 25.0,
                          fields: 6,
                          onSubmit: (value) {
                            if (value.length == 6) {
                              if (value != otp) {
                                Fluttertoast.showToast(
                                    msg: S.of(context).wrongOtp);
                              } else {
                                Navigator.of(context).pop();
                                var password =
                                    passwordController.text.trim().toString();
                                var name =
                                    passwordController.text.trim().toString();
                                mBloc.add(SignupEvent(
                                    mobileNumber, password, name, "1"));
                              }
                            }
                          })),
                ],
              ),
            ),
          );
        });
  }
}
