import 'dart:io';

import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/components/forgot_password_dialog.dart';
import 'package:fiberchat/Reasturant/screens/qr_scanner_screen.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';
import 'package:fiberchat/Reasturant/utils/common.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

import '../main.dart';
import 'dashboard_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();

  @override
  void initState() {
    appStore.setLoading(false);
    super.initState();
    setStatusBarColor(Colors.transparent);
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      hideKeyboard(context);
      appStore.setLoading(true);

      authService.signInWithEmailPassword(email: emailCont.text, password: passCont.text).then((value) {
        DashBoardScreen().launch(context, isNewTask: true);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Tooltip(
            message: 'Scan QR Code',
            child: IconButton(
              onPressed: () {
                QRScanner().launch(context, pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds);
              },
              icon: Icon(Icons.qr_code_scanner, color: context.iconColor),
            ).paddingRight(16),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                // Text(language.lblSignIn, style: boldTextStyle(size: 30)),
                Text(getTranslated(context, 'lblSignIn'), style: boldTextStyle(size: 30)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: radius(),
                    border: Border.all(color: context.dividerColor)),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextField(
                              textInputAction: TextInputAction.next,
                              textStyle: primaryTextStyle(),
                              controller: emailCont,
                              textFieldType: TextFieldType.EMAIL,
                              // decoration: inputDecoration(context, label: language.lblEmail).copyWith(prefixIcon: Icon(Icons.email_outlined, color: secondaryIconColor)),
                              decoration: inputDecoration(context, label: getTranslated(context, 'lblEmail')).copyWith(prefixIcon: Icon(Icons.email_outlined, color: secondaryIconColor)),
                            ),
                            16.height,
                            AppTextField(
                              textStyle: primaryTextStyle(),
                              controller: passCont,
                              textFieldType: TextFieldType.PASSWORD,
                              // decoration: inputDecoration(context, label: language.lblPassword).copyWith(prefixIcon: Icon(Icons.password_rounded, color: secondaryIconColor)),
                              decoration: inputDecoration(context, label: getTranslated(context, 'lblPassword')).copyWith(prefixIcon: Icon(Icons.password_rounded, color: secondaryIconColor)),
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (s) {
                                login();
                              },
                            ),
                            8.height,
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            showInDialog(context, dialogAnimation: DialogAnimation.SLIDE_TOP_BOTTOM, builder: (_) => ForgotPasswordScreen());
                          },
                          // child: Text('${language.lblForgotPassword}?', style: primaryTextStyle(size: 14)),
                          child: Text('${getTranslated(context, 'lblForgotPassword')}?', style: primaryTextStyle(size: 14)),
                        ),
                      ),
                      AppButton(
                        // text: language.lblSignIn,
                        text: getTranslated(context, 'lblSignIn'),
                        textColor: white,
                        width: context.width(),
                        textStyle: boldTextStyle(color: appStore.isDarkMode ? Colors.black : Colors.white),
                        onTap: () {
                          login();
                        },
                      ),
                      24.height,
                    ],
                  ),
                ).paddingSymmetric(horizontal: 16, vertical: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text("${language.lblDontHaveAnAccount}?", style: secondaryTextStyle(size: 14)).flexible(),
                    Text("${getTranslated(context, 'lblDontHaveAnAccount')}?", style: secondaryTextStyle(size: 14)).flexible(),
                    TextButton(
                      // child: Text(language.lblCreateAccountHere, style: boldTextStyle(size: 14)),
                      child: Text(getTranslated(context, 'lblCreateAccountHere'), style: boldTextStyle(size: 14)),
                      onPressed: () {
                        push(SignUpScreen(isFromLogin: false), pageRouteAnimation: PageRouteAnimation.Slide);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Divider(height: 16).expand(),
                    16.width,
                    // Text(language.lblOR, style: secondaryTextStyle()),
                    Text(getTranslated(context, 'lblOR'), style: secondaryTextStyle()),
                    16.width,
                    Divider(height: 16).expand(),
                  ],
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      width: context.width() * 0.4,
                      color: context.cardColor,
                      child: GoogleLogoWidget(),
                      onTap: () async {
                        // appStore.setLoading(true);
                        //
                        // await authService.signInWithGoogle().then(
                        //   (user) {
                        //     if (getStringAsync(SharePreferencesKey.USER_NUMBER).isEmpty) {
                        //       push(SignUpScreen(isFromLogin: true));
                        //     } else {
                        //       DashBoardScreen().launch(context, isNewTask: true);
                        //     }
                        //   },
                        // ).catchError(
                        //   (e) {
                        //     toast(e.toString());
                        //   },
                        // ).whenComplete(() => appStore.setLoading(false));
                      },
                    ),
                    16.width.visible(Platform.isIOS),
                    AppButton(
                      width: context.width() * 0.4,
                      color: context.cardColor,
                      child: Icon(Entypo.app_store, color: appStore.isDarkMode ? Colors.white : Colors.black),
                      onTap: () async {
                        // await authService.appleLogIn().then((value) {
                        //   DashBoardScreen().launch(context, isNewTask: true);
                        // }).catchError((e) {
                        //   toast(e.toString());
                        // });
                      },
                    ).visible(Platform.isIOS),
                  ],
                ),
                16.height,
              ],
            ).paddingTop(32),
            Observer(
              builder: (_) => Loader().visible(appStore.isLoading),
            ),
          ],
        ),
      ),
    );
  }
}
