import 'dart:async';
import 'dart:io';

import 'package:fiberchat/Configs/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

// WebViewController controllerGlobal;
//
// Future<bool> _exitApp(BuildContext context) async {
//   if (await controllerGlobal.canGoBack()) {
//     print("onwill goback");
//     controllerGlobal.goBack();
//   } else {
//     Scaffold.of(context).showSnackBar(
//       const SnackBar(content: Text("No back history item")),
//     );
//     return Future.value(false);
//   }
// }
final String url = 'https://eocochat.com/news/';
class WebViewExampleState extends State<WebViewExample> {
  bool isLoading = false;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    // var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 40,
            width: w,
            child: NavigationControls(_controller.future)),
        Expanded(
          child: Stack(
            children: [
              WebView(
                initialUrl: url,
                gestureNavigationEnabled: true,
                gestureRecognizers: [
                  Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())
                ].toSet(),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                  print('onWebViewCreated: ');
                  setState(() {
                    isLoading = true;
                  });
                },
                onPageStarted: (String url) {
                  print('Page started loading : $url');
                  setState(() {
                    // isLoading = false;
                  });
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(eocochatYellow)))
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,size: 25),

              color: Colors.black,
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller!.canGoBack()) {
                  await controller.goBack();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: !webViewReady
                  ? null
                  : () async {


                await controller!.loadUrl(url);
                // if (await controller!.canGoForward()) {
                //
                // } else {
                //   // ignore: deprecated_member_use
                //   Scaffold.of(context).showSnackBar(
                //     const SnackBar(
                //         content: Text('No forward history item')),
                //   );
                //   return;
                // }
              },
            ),
            // IconButton(
            //   icon: const Icon(Icons.replay),
            //   onPressed: !webViewReady
            //       ? null
            //       : () {
            //     controller!.reload();
            //   },
            // ),
          ],
        );
      },
    );
  }
}
