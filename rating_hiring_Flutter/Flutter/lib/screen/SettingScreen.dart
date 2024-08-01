import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentors/dynamic_theme/dynamic_theme.dart';
import 'package:rentors/generated/l10n.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingScreenState();
  }
}

class SettingScreenState extends State<SettingScreen> {
  bool nightmode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        nightmode =
            Theme.of(context).brightness == Brightness.dark ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
            child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).nightMode),
                  Switch(
                      value: nightmode,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        setState(() {
                          nightmode = value;
                          updateTheme();
                        });
                      })
                ],
              ),
              Divider(),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/complaint");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(S.of(context).complaint),
                      ),
                      Icon(CupertinoIcons.forward)
                    ],
                  )),
              Divider(),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/change_password");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(S.of(context).changePassword),
                      ),
                      Icon(CupertinoIcons.forward)
                    ],
                  )),
              Divider(),
              InkWell(
                onTap: () {
                  var map = Map();
                  map["title"] = S.of(context).contactUs;
                  map["url"] = "https://www.rentors.applatus.com/#contact";
                  Navigator.of(context).pushNamed('/webview', arguments: map);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(S.of(context).contactUs),
                    ),
                    Icon(CupertinoIcons.forward)
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/lang');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(S.of(context).language),
                    ),
                    Icon(CupertinoIcons.forward)
                  ],
                ),
              ),
            ],
          ),
        )),
        appBar: AppBar(
          title: Text(S.of(context).settings),
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
