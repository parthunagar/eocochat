import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/models/user_model.dart';
import 'package:qr_menu/screens/dashboard_screen.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';

import '../main.dart';

class SignUpScreen extends StatefulWidget {
  final bool? isFromLogin;
  final User? user;

  SignUpScreen({this.user, this.isFromLogin = true});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController numCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController createdAtCont = TextEditingController();
  TextEditingController updatedAtCont = TextEditingController();

  FocusNode contactFocus = FocusNode();

  late UserModel socialLoginData;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    init();
    setStatusBarColor(Colors.transparent);
  }

  Future<void> init() async {
    if (widget.isFromLogin!) {
      appStore.setLoading(true);

      userService.userByEmail(getStringAsync(SharePreferencesKey.USER_EMAIL)).then((UserModel value) {
        //
        nameCont.text = value.name.validate();
        emailCont.text = value.email.validate();
        numCont.text = value.num.validate();
        createdAtCont.text = value.createdAt.toString();
        updatedAtCont.text = value.updatedAt.toString();
        socialLoginData = value;
        //
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    }
  }

  saveDataOfUser() async {
    appStore.setLoading(true);
    if (widget.isFromLogin!) {
      UserModel data = UserModel();

      data.email = emailCont.text;
      data.name = nameCont.text;
      data.num = numCont.text;
      data.uid = socialLoginData.uid;
      data.isEmailLogin = socialLoginData.isEmailLogin;
      data.image = socialLoginData.image;
      data.createdAt = socialLoginData.createdAt;
      data.updatedAt = Timestamp.now();

      userService.updateDocument(data.toJson(), socialLoginData.uid.validate()).then((value) {
        setValue(SharePreferencesKey.USER_NUMBER, numCont.text);
        push(DashBoardScreen(),isNewTask: true);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    } else {
      if (await userService.isUserExist(emailCont.text)) {
        toast(language.lblUserAlreadyRegisterWithEmail);
        appStore.setLoading(false);
      } else {
        authService
            .signUpWithEmailPassword(
          name: nameCont.text.trim(),
          email: emailCont.text.trim(),
          password: passCont.text.trim(),
          mobileNumber: numCont.text.trim(),
        )
            .then((value) {
          DashBoardScreen().launch(context, isNewTask: true);
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() {
          appStore.setLoading(false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent, iconTheme: IconThemeData(color: context.iconColor)),
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text(language.lblSignUp, style: boldTextStyle(size: 30)),
                Container(
                  decoration: BoxDecoration(borderRadius: radius(), border: Border.all(color: context.dividerColor)),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      16.height,
                      Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: Column(
                            children: [
                              AppTextField(
                                autoFocus: false,
                                textInputAction: TextInputAction.next,
                                textStyle: primaryTextStyle(),
                                controller: nameCont,
                                textFieldType: TextFieldType.NAME,
                                decoration: inputDecoration(context, label: language.lblName).copyWith(prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.person_outline, color: secondaryIconColor))),
                              ),
                              16.height,
                              AppTextField(
                                textInputAction: TextInputAction.next,
                                textStyle: primaryTextStyle(),
                                controller: emailCont,
                                enabled: !widget.isFromLogin!,
                                textFieldType: TextFieldType.EMAIL,
                                decoration: inputDecoration(context, label: language.lblEmail).copyWith(prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.email_outlined, color: secondaryIconColor))),
                              ),
                              16.height,
                              widget.isFromLogin!
                                  ? Offstage()
                                  : AppTextField(
                                      textStyle: primaryTextStyle(),
                                      textInputAction: TextInputAction.next,
                                      controller: passCont,
                                      textFieldType: TextFieldType.PASSWORD,
                                      nextFocus: contactFocus,
                                      decoration: inputDecoration(context, label: language.lblPassword).copyWith(prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.password, color: secondaryIconColor))),
                                    ),
                              16.height,
                              AppTextField(
                                focus: contactFocus,
                                textInputAction: TextInputAction.done,
                                textStyle: primaryTextStyle(),
                                isValidationRequired: false,
                                controller: numCont,
                                maxLength: 12,
                                buildCounter: (context, {required currentLength, required isFocused, maxLength}) {},
                                textFieldType: TextFieldType.PHONE,
                                decoration: inputDecoration(context, label: language.lblPhoneNumber).copyWith(prefixIcon: IconButton(onPressed: null, icon: Icon(LineIcons.phone, color: secondaryIconColor))),
                              ),
                              widget.isFromLogin! ? Offstage() : 24.height,
                            ],
                          )),
                      16.height,
                      AppButton(
                          text: language.lblSignUp,
                          textStyle: boldTextStyle(color: appStore.isDarkMode ? Colors.black : Colors.white),
                          width: context.width(),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              saveDataOfUser();
                            }
                          }),
                    ],
                  ),
                ).paddingAll(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${language.lblAlreadyHaveAccount}?", style: secondaryTextStyle(size: 14)).flexible(),
                    TextButton(
                      child: Text(language.lblSignInHere, style: boldTextStyle(size: 14)),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Observer(
            builder: (_) => Loader().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}
