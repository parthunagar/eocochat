import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:fiberchat/Reasturant/screens/sign_in_screen.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';
import 'package:fiberchat/Reasturant/main.dart';

class WalkThroughContainer1 extends StatefulWidget {
  @override
  _WalkThroughContainer1State createState() => _WalkThroughContainer1State();
}

class _WalkThroughContainer1State extends State<WalkThroughContainer1> {
  bool button = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          50.height,
          Image.asset(AppImages.paperLess, height: 300, width: 300).cornerRadiusWithClipRRect(16),
          64.height,
          // Text(language.lblGoPaperless.toUpperCase(), style: boldTextStyle(size: 20)),
          Text(getTranslated(context, 'lblGoPaperless').toUpperCase(), style: boldTextStyle(size: 20)),
          16.height,
          // Text(language.lblGoPaperlessWithOurDigitalMenu, style: secondaryTextStyle(), textAlign: TextAlign.center).paddingSymmetric(horizontal: 16),
          Text(getTranslated(context, 'lblGoPaperlessWithOurDigitalMenu'), style: secondaryTextStyle(), textAlign: TextAlign.center).paddingSymmetric(horizontal: 16),
          AppButton(
            child: Icon(Icons.arrow_forward),
            onTap: () {
              setValue(SharePreferencesKey.IS_WALKED_THROUGH, true);
              SignInScreen().launch(context);
            },
            color: Colors.white.withOpacity(0.5),
          ).visible(button),
        ],
      ),
    );
  }
}
