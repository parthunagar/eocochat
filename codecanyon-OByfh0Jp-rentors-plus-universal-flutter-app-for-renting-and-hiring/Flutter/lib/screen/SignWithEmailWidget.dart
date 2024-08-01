import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentors/bloc/LoginBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/SignWithEmailEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SignInWithEmailState.dart';
import 'package:rentors/widget/PasswordField.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:rentors/widget/RoundedFloatingField.dart';

class SignWithEmailWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignWithEmailWidgetState();
  }
}

class SignWithEmailWidgetState extends State<SignWithEmailWidget> {
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final _emailIdKey = GlobalKey<FormFieldState<String>>();
  LoginBloc mBloc = new LoginBloc();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  ProgressDialog mDialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mDialog = ProgressDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mBloc.listen((state) {
        mDialog.hide();
        if (state is ProgressDialogState) {
          mDialog.show();
        } else if (state is SignInWithEmailState) {
          if (state.model is UserModel) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false);
          } else {
            Fluttertoast.showToast(msg: state.model.message);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
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
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        S.of(context).welcomeBack,
                        style: TextStyle(
                            fontSize: 25,
                            color: config.Colors().colorF26d42,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: RoundedFloatingField(
                        controller: emailController,
                        emailIdKey: _emailIdKey,
                        hint: S.of(context).enterYourEmail,
                        label: S.of(context).enterYourEmail,
                        inputType: TextInputType.emailAddress,
                        validator: (input) => EmailValidator.validate(input)
                            ? null
                            : S.of(context).pleaseEnterValidEmailAddress,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: PasswordField(
                        controller: passwordController,
                        validator: (input) => input.isEmpty
                            ? S.of(context).pleaseEnterPassword
                            : null,
                        fieldKey: _passwordFieldKey,
                        onFieldSubmitted: (String value) {
                          // setState(() {
                          //   this._password = value;
                          // });
                        },
                      ),
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 10),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("/forgot");
                            },
                            child: Text(S.of(context).forgotPassword))),
                    BlocProvider(
                        create: (BuildContext context) => LoginBloc(),
                        child: BlocBuilder<LoginBloc, BaseState>(
                            bloc: mBloc,
                            builder: (BuildContext context, BaseState state) {
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10),
                                child: RentorRaisedButton(
                                  child: Text(
                                    S.of(context).login,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  ),
                                  onPressed: () {
                                    save();
                                  },
                                ),
                              );
                            })),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: S.of(context).dontHaveAnAccount,
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed("/signup");
                                },
                              text: S.of(context).signUp,
                              style: TextStyle(
                                  color: config.Colors().orangeColor,
                                  fontWeight: FontWeight.bold)),
                        ]))),
                  ],
                ),
              )
            ],
          ),
          appBar: AppBar(
            title: Text(S.of(context).signIn),
            centerTitle: true,
            brightness: Brightness.light,
            elevation: 0,
          )),
    );
  }

  void save() {
    if (_emailIdKey.currentState.validate() &&
        _passwordFieldKey.currentState.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      mBloc.add(SignWithEmailEvent(email, password, "sfsfhsfj"));
    }
  }
}
