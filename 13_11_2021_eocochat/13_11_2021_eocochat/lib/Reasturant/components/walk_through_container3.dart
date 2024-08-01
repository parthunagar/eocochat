import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

class WalkThroughContainer3 extends StatefulWidget {
  const WalkThroughContainer3({Key? key}) : super(key: key);

  @override
  _WalkThroughContainer3State createState() => _WalkThroughContainer3State();
}

class _WalkThroughContainer3State extends State<WalkThroughContainer3> {
  int selectedIndex = 1;

  String _getName(ThemeModes themeModes) {
    switch (themeModes) {
      case ThemeModes.Light:
        // return language.lblLight;
        return getTranslated(context, 'lblLight');
      case ThemeModes.Dark:
        // return language.lblDark;
        return getTranslated(context, 'lblDark');
      case ThemeModes.SystemDefault:
        // return language.lblSystemDefault;
        return getTranslated(context, 'lblSystemDefault');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          50.height,
          Image.asset(AppImages.theme, height: 300, width: 300).cornerRadiusWithClipRRect(16),
          40.height,
          // Text(language.lblSelectTheme.toUpperCase(), style: boldTextStyle(size: 20)),
          Text(getTranslated(context, 'lblSelectTheme').toUpperCase(), style: boldTextStyle(size: 20)),
          16.height,
          // Text(language.lblSelectThemeDesc, style: secondaryTextStyle(), textAlign: TextAlign.center).paddingSymmetric(horizontal: 16),
          Text(getTranslated(context, 'lblSelectThemeDesc'), style: secondaryTextStyle(), textAlign: TextAlign.center).paddingSymmetric(horizontal: 16),
          40.height,
          DropdownButton(
            dropdownColor: context.cardColor,
            elevation: defaultElevation,
            value: selectedIndex,
            items: ThemeMode.values.map((e) {
              int index = ThemeMode.values.indexOf(e);
              return DropdownMenuItem<int>(
                child: Text('${_getName(ThemeModes.values[index])}', style: primaryTextStyle()),
                value: index,
              );
            }).toList(),
            onChanged: (int? v) {
              if (v == AppThemeMode.ThemeModeSystem) {
                appStore.setDarkMode(MediaQuery.of(context).platformBrightness == Brightness.dark);
              } else if (v == AppThemeMode.ThemeModeLight) {
                appStore.setDarkMode(false);
              } else if (v == AppThemeMode.ThemeModeDark) {
                appStore.setDarkMode(true);
              }
              selectedIndex = v!;
              setValue(THEME_MODE_INDEX, v);
              setState(() {});
            },
            hint: Text(
              // language.lblSelectTheme,
                getTranslated(context, 'lblSelectTheme'),
              style: primaryTextStyle(),
            ),
          )
        ],
      ),
    );
  }
}
