import 'package:flutter/cupertino.dart';
import 'package:rentors/config/app_config.dart' as config;
class TermCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'I agree to the  ',
        style: TextStyle(
          fontSize: 14,
          color: config.Colors().accentDarkColor
        ),
        children: <TextSpan>[
          TextSpan(
              text: 'terms',
              style: TextStyle(
                  fontSize: 14,
                color: config.Colors().statusBlueColor,
                decoration: TextDecoration.underline
              )),
          TextSpan(text: ' and ',
            style: TextStyle(
            fontSize: 14,
          ),),
          TextSpan(
              text: 'privacy policy',
              style: TextStyle(
                  fontSize: 14,
                  color: config.Colors().statusBlueColor,
                  decoration: TextDecoration.underline
              )),
        ],
      ),
    );
  }
}