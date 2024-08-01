import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

class WebScreen extends StatefulWidget {
  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() {
      appStore.setLanguage(getStringAsync(SharePreferencesKey.Language, defaultValue: AppConstant.defaultLanguage), context: context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // child: Text(language.lblWaitToScan, style: boldTextStyle()),
        child: Text(getTranslated(context, 'lblWaitToScan'), style: boldTextStyle()),
      ).center(),
    );
  }
}
