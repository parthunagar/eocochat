import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/generated/l10n.dart';

class NetworkWidget extends StatefulWidget {
  NetworkWidget();

  @override
  State<StatefulWidget> createState() {
    return NetworkWidgetState();
  }
}

class NetworkWidgetState extends State<NetworkWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: config.Colors().color1C1E28,
        ),
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Lottie.asset(
                    "assets/network.json",
                    height: config.App(context).appWidth(100),
                    width: config.App(context).appWidth(100),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    S.of(context).pleaseCheckYourInternetConnection,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                OutlineButton(
                    onPressed: () {
                      RentorState.of(context).update();
                    },
                    child: Text(
                      S.of(context).retry,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: config.Colors().colorF25633),
                    ),
                    borderSide: BorderSide(color: config.Colors().colorF25633),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)))
              ],
            ),
          ),
        ));
  }
}
