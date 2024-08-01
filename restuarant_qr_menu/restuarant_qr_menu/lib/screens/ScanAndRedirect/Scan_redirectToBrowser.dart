
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';



class ScanAndOpenBrowserScreen extends StatefulWidget {
  const ScanAndOpenBrowserScreen({Key? key}) : super(key: key);

  @override
  _ScanAndOpenBrowserScreenState createState() => _ScanAndOpenBrowserScreenState();
}

class _ScanAndOpenBrowserScreenState extends State<ScanAndOpenBrowserScreen> {

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
        cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {

    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      if (!isScanned) {

        setState(() {
          result = scanData;
          print('scanData : ${scanData.code}');
          if (scanData.code.isNotEmpty) {
            if (result!.code.validateURL()) {
              launch(result!.code);
              // Navigator.pop(context);
            } else {
              toast(result!.code.validate());
            }
          }
          isScanned = true;
        });
      }
      // await restaurantOwnerService.getRestaurantFutureData(getStringAsync(USER_ID)).then((value) => setValue(USER_NAME, value.name));
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      snackBar(context, title: "${language.lblNoPermission}", backgroundColor: context.cardColor, textColor: Colors.black);
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
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

}
