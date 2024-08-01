import 'package:flutter/material.dart';
import 'package:rentors/config/app_config.dart' as config;

class SeparatorWidget extends StatelessWidget {
  final String name;

  final Color color;

  SeparatorWidget(this.name, {this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10,top: 10,bottom: 5),
      color: this.color,
      child: Text(
        name,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: config.Colors().mainDarkColor),
      ),
    );
  }
}
