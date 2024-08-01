import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrGenerateScreen extends StatefulWidget {
  @override
  _QrGenerateScreenState createState() => _QrGenerateScreenState();
}

class _QrGenerateScreenState extends State<QrGenerateScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String saveUrl = "";
  bool isTesting = false;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    screenshotController = ScreenshotController();
    saveUrl = "$mBaseURL${selectedRestaurant.uid}/";
    log(saveUrl);
    setState(() {});
  }

  void getScreenShot() async {
    screenshotController.capture(delay: const Duration(milliseconds: 10)).then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        await Share.shareFiles([imagePath.path]);
      }
    }).catchError((onError) {
      toast(language.lblTryAgain);
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          '${selectedRestaurant.name.validate()} ${language.lblQR} ',
          color: context.scaffoldBackgroundColor,
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: context.iconColor),
              onPressed: () {
                getScreenShot();
              },
            ),
            16.width,
          ],
        ),
        backgroundColor: context.cardColor,
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            padding: EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 32),
            width: context.width() - 32,
            decoration: BoxDecoration(borderRadius: radius(16), color: context.cardColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                (selectedRestaurant.logoImage.isEmptyOrNull)
                    ? Offstage()
                    : cachedImage(
                        selectedRestaurant.logoImage,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ).cornerRadiusWithClipRRect(80),
                Text(
                  "${selectedRestaurant.name.validate()}",
                  textAlign: TextAlign.center,
                  style: boldTextStyle(
                    size: 36,
                  ),
                ),
                16.height,
                Text(
                  language.lblScanForOurOnlineMenu,
                  textAlign: TextAlign.center,
                  style: primaryTextStyle(size: 20),
                ),
                16.height,
                RepaintBoundary(
                  key: qrKey,
                  child: QrImage(
                    version: 4,
                    data: isTesting ? selectedRestaurant.uid.validate() : saveUrl,
                    size: 250,
                    foregroundColor: context.iconColor,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "${language.lblUhOhSomethingWentWrong}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ).center(),
        ),
      ),
    );
  }
}
