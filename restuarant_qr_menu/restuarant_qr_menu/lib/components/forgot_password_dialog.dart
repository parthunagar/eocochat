import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String tag = '/ForgotPasswordScreen';

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotEmailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${language.lblForgetPassword}", style: boldTextStyle(size: 20)),
            Text(language.lblEnterYouEmail, style: secondaryTextStyle()),
            16.height,
            Observer(
              builder: (_) => AppTextField(
                controller: forgotEmailController,
                textFieldType: TextFieldType.EMAIL,
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration(context, label: language.lblEmail).copyWith(prefixIcon: Icon(Icons.email_outlined, color: secondaryIconColor)),
                errorInvalidEmail: language.lblEnterValidEmail,
                errorThisFieldRequired: errorThisFieldRequired,
              ).visible(!appStore.isLoading, defaultWidget: Loader()),
            ),
            16.height,
            AppButton(
              child: Text(language.lblResetPassword, style: boldTextStyle(color: appStore.isDarkMode ? Colors.black : Colors.white)),
              width: context.width(),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  hideKeyboard(context);
                  appStore.setLoading(true);
                  authService.forgotPassword(email: forgotEmailController.text.trim()).then((value) {
                    toast(language.lblResetPasswordLinkHasSentYourMail);
                    finish(context);
                  }).catchError((error) {
                    toast(error.toString());
                  }).whenComplete(() => appStore.setLoading(false));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
