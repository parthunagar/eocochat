
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CustomProgressBar extends StatefulWidget {
  Color? valueColor;
  CustomProgressBar({this.valueColor});

  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(widget.valueColor ?? eocochatWhite)));
  }
}
