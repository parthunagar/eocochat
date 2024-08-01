import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentors/dynamic_theme/dynamic_theme.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/util/Settings.dart';
import 'package:rentors/util/Utils.dart';

class LanguangeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LanguangeScreenState();
  }
}

class LanguangeScreenState extends State<LanguangeScreen> {
  var languangeMap = Map<String, String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        languangeMap["en"] = S.of(context).english;
        languangeMap["ar"] = S.of(context).arabic;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return RadioListTile<Locale>(
              value: S.delegate.supportedLocales[index],
              groupValue: mobileLanguage.value,
              onChanged: (ind) {
                Utils.languange(ind.toLanguageTag());
                mobileLanguage.value = ind;
              },
              title: Text(languangeMap[
                  S.delegate.supportedLocales[index].toLanguageTag()]),
            );
          },
          itemCount: S.delegate.supportedLocales.length,
        ),
        appBar: AppBar(
          title: Text(S.of(context).language),
        ));
  }

  void updateTheme() {
    if (Theme.of(context).brightness == Brightness.dark) {
//      setBrightness(Brightness.light);
      DynamicTheme.of(context).setBrightness(Brightness.light);
    } else {
//      setBrightness(Brightness.dark);
      DynamicTheme.of(context).setBrightness(Brightness.dark);
    }
  }
}
