import 'package:flutter/material.dart';
import 'package:rentors/util/Utils.dart';

class SplashScreenWidget extends StatelessWidget {
  checkLogin(BuildContext context) async {
    Future.delayed(Duration(milliseconds: 1000)).then((value) async {
      var user = await Utils.getUser();
      try {
        if (user != null) {
          Navigator.of(context).popAndPushNamed("/home");
        } else {
          Navigator.of(context).popAndPushNamed("/pager");
        }
      } catch (ex) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLogin(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Image.asset(
        "assets/img/splash/splash.png",
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
