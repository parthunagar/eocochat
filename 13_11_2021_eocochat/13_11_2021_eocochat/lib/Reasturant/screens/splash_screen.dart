import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/screens/dashboard_screen.dart';
import 'package:fiberchat/Reasturant/screens/sign_in_screen.dart';
import 'package:fiberchat/Reasturant/screens/sign_up_screen.dart';
import 'package:fiberchat/Reasturant/screens/walk_through_screen.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    if (getBoolAsync(SharePreferencesKey.IS_WALKED_THROUGH)) {
      if (getBoolAsync(SharePreferencesKey.IS_LOGGED_IN)) {
        if (getStringAsync(SharePreferencesKey.USER_NUMBER).isEmpty) {
          SignUpScreen(isFromLogin: true).launch(context, pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
        } else {
          DashBoardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
        }
      } else {
        SignInScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true, duration: 450.milliseconds);
      }
    } else {
      WalkThroughScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    }
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
            Text(AppConstant.appName, style: boldTextStyle(size: 30)),
          ],
        ),
      ).center(),
    );
  }
}
