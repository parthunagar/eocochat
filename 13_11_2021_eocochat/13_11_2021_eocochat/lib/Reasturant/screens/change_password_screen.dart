import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';
import 'package:fiberchat/Reasturant/utils/common.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var formKey = GlobalKey<FormState>();

  var oldPassCont = TextEditingController();
  var newPassCont = TextEditingController();
  var confNewPassCont = TextEditingController();

  var newPassFocus = FocusNode();
  var confPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    afterBuildCreated(() {
      setStatusBarColor(context.scaffoldBackgroundColor);
    });
  }

  Future<void> submit() async {
    hideKeyboard(context);

    if (formKey.currentState!.validate()) {
      appStore.setLoading(true);
      setState(() {});

      await authService.changePassword(newPassCont.text.trim()).then((value) async {
        finish(context);
        toast(language.lblPasswordSuccessfullyChanged);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() {
        appStore.setLoading(false);
        setState(() {});
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: !isIos,
      child: Scaffold(
        appBar: appBarWidget(language.lblChangePassword, showBack: true, elevation: 0, color: context.scaffoldBackgroundColor),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Observer(
            builder: (_) => SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    AppTextField(
                      controller: oldPassCont,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: inputDecoration(context, label: "${language.lblOldPassword}").copyWith(
                        prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.password, color: secondaryIconColor))),
                      nextFocus: newPassFocus,
                      textStyle: primaryTextStyle(),
                      autoFillHints: [AutofillHints.password],
                      validator: (String? s) {
                        if (s!.isEmpty) return errorThisFieldRequired;
                        if (s != getStringAsync(SharePreferencesKey.PASSWORD)) return '${language.lblOldPasswordIsNotCorrect}';

                        return null;
                      },
                    ),
                    16.height,
                    AppTextField(
                      controller: newPassCont,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: inputDecoration(context, label: '${language.lblNewPassword}').copyWith(
                        prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.password, color: secondaryIconColor))),
                      focus: newPassFocus,
                      nextFocus: confPassFocus,
                      textStyle: primaryTextStyle(),
                      autoFillHints: [AutofillHints.newPassword],
                    ),
                    16.height,
                    AppTextField(
                      controller: confNewPassCont,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: inputDecoration(context, label: '${language.lblConfirmPassword}').copyWith(
                        prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.password, color: secondaryIconColor)),
                      ),
                      focus: confPassFocus,
                      validator: (String? value) {
                        if (value!.isEmpty) return errorThisFieldRequired;
                        if (value.length < passwordLengthGlobal) return '${language.lblPasswordLengthShouldBeMoreThanSix}';
                        if (value.trim() != newPassCont.text.trim()) return '${language.lblBothPasswordShouldBeMatched}';
                        if (value.trim() == oldPassCont.text.trim()) return '${language.lblOldPasswordShouldNotBeSameAsNewPassword}';

                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (s) {
                        submit();
                      },
                      textStyle: primaryTextStyle(),
                      autoFillHints: [AutofillHints.newPassword],
                    ),
                    30.height,
                    AppButton(
                      onTap: () {
                        submit();
                      },
                      text: language.lblSave,
                      width: context.width(),
                      textStyle: boldTextStyle(color: appStore.isDarkMode ? Colors.black : Colors.white),
                    ),
                  ],
                ),
              ),
            ).visible(!appStore.isLoading, defaultWidget: Loader()),
          ),
        ),
      ),
    );
  }
}
