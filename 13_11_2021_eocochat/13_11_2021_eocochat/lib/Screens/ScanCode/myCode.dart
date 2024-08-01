import 'dart:convert';
import 'dart:developer';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
import 'package:fiberchat/Screens/StripePay/Pages/stripehomepage.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyQRViewScreen extends StatefulWidget {
  var userId;

  MyQRViewScreen({this.userId});

  @override
  State<StatefulWidget> createState() => _MyQRViewScreenState();
}

class _MyQRViewScreenState extends State<MyQRViewScreen> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 4, child: _buildQrView(context)),
        // Expanded(
        //   flex: 1,
        //   child: FittedBox(
        //     fit: BoxFit.contain,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         ///SCAN RESULT
        //         // if (result != null)
        //         //   Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
        //         // else
        //         //   Text('Scan a code'),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             ///FLASH
        //             // GestureDetector(
        //             //   onTap:  () async {
        //             //     await controller?.toggleFlash();
        //             //     setState(() {});
        //             //     },
        //             //   child: FutureBuilder(
        //             //     future: controller?.getFlashStatus(),
        //             //     builder: (context, snapshot) {
        //             //       // return Text('Flash: ${snapshot.data}');
        //             //       return Icon(snapshot.data == true ? Icons.flash_on : Icons.flash_off,color: snapshot.data == true ? Colors.blue : eocochatGrey,);
        //             //       },
        //             //    )),
        //             ///FRONT CAMERA
        //             // Container(
        //             //   margin: EdgeInsets.all(8),
        //             //   child: ElevatedButton(
        //             //       onPressed: () async {
        //             //         await controller?.flipCamera();
        //             //         setState(() {});
        //             //       },
        //             //       child: FutureBuilder(
        //             //         future: controller?.getCameraInfo(),
        //             //         builder: (context, snapshot) {
        //             //           if (snapshot.data != null) {
        //             //             return Text('Camera facing ${describeEnum(snapshot.data!)}');
        //             //           } else {
        //             //             return Text('loading');
        //             //           }
        //             //         },
        //             //       )),
        //             // )
        //           ],
        //         ),
        //         ///PAUSE AND RESUME CAMERA
        //         // Row(
        //         //   mainAxisAlignment: MainAxisAlignment.center,
        //         //   crossAxisAlignment: CrossAxisAlignment.center,
        //         //   children: <Widget>[
        //         //     Container(
        //         //       margin: EdgeInsets.all(8),
        //         //       child: ElevatedButton(
        //         //         onPressed: () async {
        //         //           await controller?.pauseCamera();
        //         //         },
        //         //         child: Text('pause', style: TextStyle(fontSize: 20)),
        //         //       ),
        //         //     ),
        //         //     Container(
        //         //       margin: EdgeInsets.all(8),
        //         //       child: ElevatedButton(
        //         //         onPressed: () async {
        //         //           await controller?.resumeCamera();
        //         //         },
        //         //         child: Text('resume', style: TextStyle(fontSize: 20)),
        //         //       ),
        //         //     )
        //         //   ],
        //         // ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: eocochatRed,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        GestureDetector(
          onTap:  () async {
            await controller?.toggleFlash();
            setState(() {});
          },
          child: FutureBuilder(
            future: controller?.getFlashStatus(),
            builder: (context, snapshot) {
              // return Text('Flash: ${snapshot.data}');
              return Container(
                margin: EdgeInsets.only(top: 20,left: 20),
                child: Icon(
                  snapshot.data == true ? Icons.flash_on : Icons.flash_off,
                  color: snapshot.data == true ? eocochatYellow : eocochatGrey));
            },
          )),
      ],
    );
  }
// //4000008260000000
  bool? setScanData = false;
  void _onQRViewCreated(QRViewController controller) {

    setState(() {  this.controller = controller;   });

    controller.scannedDataStream.listen((scanData) async {
      var userCodeData;
      setState(() {
        result = scanData;
        print('SCAN RESULT => code : ${result!.code} || format : ${result!.format} || rawBytes : ${result!.rawBytes}');
        try {
          userCodeData = UserQrCode.fromJson(json.decode(scanData.code));
          print('userCodeData : ${userCodeData.userQrCodeData!.id}');
        } catch(e) {
          print('ERROR a : $e');
        }

      });
      try{
        // if(setScanData == true) {
        //   setState(() {
        //     setScanData = false;
        //   });
        // }
        print('userCodeData.userQrCodeData!.id : ${userCodeData.userQrCodeData!.id}');
        print('widget.userId : ${widget.userId}');


          if(userCodeData.userQrCodeData!.accountNumber != null) {
            if(scanData != null && setScanData == false ){
              setScanData = true;
              await controller.pauseCamera();
              if(userCodeData.userQrCodeData!.id.toString() == widget.userId.toString() ) {
                print('User could not send your wallet number');
                Fiberchat.toast(getTranslated(this.context, 'lblUserCouldNotSendYourWalletNumber'));
                setScanData = false;
              }
              else{
                print('controller.getCameraInfo() : '+ controller.getCameraInfo().toString());
                //TODO : 24/03/2022 : change push to pushReplacement
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StripeHomePage(receiverUserCodeData: userCodeData,userId: widget.userId))).then((value){
                  setScanData = false;
                });
              }

            }
          }



      }catch(e) {

        // if(setScanData == false) {
        //   setState(() {
        //     setScanData = true;
        //   });
        //   Eocochat.toast('Invalid User QRCode');
        // }
        // Eocochat.toast('Invalid User QRCode');
        print('_onQRViewCreated => Navigate ERROR : $e');
        // return;


      }
    });
  }


  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
// class MyQRCodeScreen extends StatefulWidget {
//   const MyQRCodeScreen({Key? key}) : super(key: key);
//
//   @override
//   _MyQRCodeScreenState createState() => _MyQRCodeScreenState();
// }
//
// class _MyQRCodeScreenState extends State<MyQRCodeScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('My QR CODE'));
//   }
// }
