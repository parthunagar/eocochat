import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';

class EmptyWidget extends StatefulWidget {
  EmptyWidget();

  @override
  State<StatefulWidget> createState() {
    return EmptyWidgetState();
  }
}

class EmptyWidgetState extends State<EmptyWidget> {
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
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).noDataFound,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: config.Colors().orangeColor),
                ),
              ],
            ),
          ),
        ));
  }
}
