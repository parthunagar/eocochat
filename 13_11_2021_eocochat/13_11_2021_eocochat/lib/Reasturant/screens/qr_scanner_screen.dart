import 'dart:io';

import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/screens/user_splash_screen.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isScanned = false;

  String? restName;

  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (context.width() < 400 || context.height() < 400) ? 350.0 : 350.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: primaryColor,
        borderRadius: 16,
        borderLength: 50,
        borderWidth: 8,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    setState(() {});

    controller.scannedDataStream.listen((scanData) async {
      if (!isScanned) {
        result = scanData;
        print('SCAN => result : $result');
        setState(() {});

        if (scanData.code.isNotEmpty) {
          if (result!.code.validateURL()) {
            if (result!.code.contains(mBaseURL)) {
              UserSplashScreen(result: result!.code.split('/')[3]).launch(context);
            } else {
              launch(result!.code, forceWebView: true, enableJavaScript: true);
            }
          } else {
            toast(result!.code.validate());
          }
        }
        isScanned = true;
      }
      // await restaurantOwnerService.getRestaurantFutureData(getStringAsync(USER_ID)).then((value) => setValue(USER_NAME, value.name));
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {

      // snackBar(context, title: "${language.lblNoPermission}", backgroundColor: context.cardColor, textColor: Colors.black);
      snackBar(context, title: "${getTranslated(context, 'lblNoPermission')}", backgroundColor: context.cardColor, textColor: Colors.black);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[Expanded(flex: 4, child: _buildQrView(context))],
      ),
    );
  }
}
