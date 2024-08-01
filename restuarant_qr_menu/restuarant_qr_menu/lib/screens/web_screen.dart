import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/constants.dart';

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
        child: Text(language.lblWaitToScan, style: boldTextStyle()),
      ).center(),
    );
  }
}
