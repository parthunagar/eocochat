import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';

class AddNewComponentItem extends StatelessWidget {
  final void Function()? onTap;

  AddNewComponentItem({this.onTap});

  @override
  Widget build(BuildContext context) {
    return DottedBorderWidget(
      padding: EdgeInsets.all(1),
      child: TextIcon(
        prefix: Icon(Icons.add, color: context.iconColor, size: 20),
        // text: language.lblNew,
        text: getTranslated(context, 'lblNew'),
        textStyle: primaryTextStyle(size: 14),
      ),
      radius: defaultRadius,
      color: context.iconColor,
    ).onTap(onTap, borderRadius: radius(defaultRadius));
  }
}
