import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/screens/user_menu_listing_screen.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

class UserSplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  late String? result;

  UserSplashScreen({this.result});

  @override
  _UserSplashScreenState createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      appStore.setLanguage(getStringAsync(SharePreferencesKey.Language, defaultValue: AppConstant.defaultLanguage), context: context);
    });
    await 2.seconds.delay;
    UserMenuListingScreen(id: widget.result.validate()).launch(context, isNewTask: true);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        width: context.width(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(appStore.isDarkMode ? AppImages.app_logo : AppImages.app_logo_dark, height: 150, width: 150).cornerRadiusWithClipRRect(defaultRadius),
            26.height,
            Text(AppConstant.appName, style: boldTextStyle(size: 30, fontFamily: GoogleFonts.roboto().fontFamily)),
          ],
        ),
      ).center(),
    );
  }
}
