import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rentors/dynamic_theme/dynamic_theme.dart';

class InAppWebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  InAppWebViewScreen(this.title, this.url);

  @override
  State<StatefulWidget> createState() {
    return InAppWebViewScreenState();
  }
}

class InAppWebViewScreenState extends State<InAppWebViewScreen> {
  bool nightmode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InAppWebView(
          initialFile: widget.url,
        ),
        appBar: AppBar(
          title: Text(widget.title),
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
