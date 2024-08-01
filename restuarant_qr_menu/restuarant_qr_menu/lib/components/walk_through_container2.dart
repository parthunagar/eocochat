import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/constants.dart';

class WalkThroughContainer2 extends StatefulWidget {
  const WalkThroughContainer2({Key? key}) : super(key: key);

  @override
  _WalkThroughContainer2State createState() => _WalkThroughContainer2State();
}

class _WalkThroughContainer2State extends State<WalkThroughContainer2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          50.height,
          Image.asset(AppImages.language, height: 300, width: 300).cornerRadiusWithClipRRect(16),
          40.height,
          Text(language.lblSelectLanguage.toUpperCase(), style: boldTextStyle(size: 20)),
          16.height,
          Text(language.lblSelectLanguageDesc, style: secondaryTextStyle(), textAlign: TextAlign.center).paddingSymmetric(horizontal: 16),
          40.height,
          LanguageListWidget(
            widgetType: WidgetType.DROPDOWN,
            onLanguageChange: (v) {
              setValue(SELECTED_LANGUAGE_CODE, v.languageCode);
              appStore.setLanguage(v.languageCode!, context: context);
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
