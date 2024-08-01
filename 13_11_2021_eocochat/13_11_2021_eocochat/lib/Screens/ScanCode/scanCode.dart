
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/widgets/ProgressBar/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

//ignore: must_be_immutable
class ScanScreen extends StatefulWidget {
  var userId;
  ScanScreen({this.userId});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08,vertical: h * 0.06),
      child: FutureBuilder(
          future: APIServices.getMakeUserQRCode(widget.userId),
          // future: fetchData,
          builder: (context,AsyncSnapshot userQrCodeSnapshot) {
            print('ScanScreen => widget.userId : ${widget.userId}');
            if(userQrCodeSnapshot.connectionState == ConnectionState.waiting ) {
              return CustomProgressBar();
            }
            else {
              if(userQrCodeSnapshot.hasData) {
                print('userQrCodeSnapshot : ${userQrCodeSnapshot.data}');
                return QrImage(data:  '${userQrCodeSnapshot.data}', version: QrVersions.auto);
              }
              else {
                print('userQrCodeSnapshot.data : ${userQrCodeSnapshot.data}');
                return Padding(padding: EdgeInsets.only(top: h * 0.02), child: Center(child: Text('QR Code No Found.',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))));
              }
            }
          }
      ),
    );

    // return Container(
    //   // color: Colors.red[100],
    //   padding: EdgeInsets.symmetric(horizontal: w * 0.08,vertical: h * 0.06),
    //   child: FutureBuilder<UserQrCode?>(
    //     future: APIServices.getUserQRCode(widget.userId),
    //     builder: (context,AsyncSnapshot<UserQrCode?> userQrCodeSnapshot) {
    //       print('ScanScreen => widget.userId : ${widget.userId}');
    //       if(userQrCodeSnapshot.connectionState == ConnectionState.waiting ) {
    //         return CustomProgressBar();
    //       }
    //       else if(userQrCodeSnapshot.data == null) {
    //         print('userQrCodeSnapshot.data : ${userQrCodeSnapshot.data}');
    //         return Padding(
    //           padding: EdgeInsets.only(top: h * 0.02),
    //           child: Center(child: Text('QR Code No Found.',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))),
    //         );
    //       }
    //       else {
    //         print('userQrCodeSnapshot ==> 1 : ${userQrCodeSnapshot.data!.userQrCodeData!.toJson().toString()}');
    //         print('userQrCodeSnapshot ==> 2 : ${userQrCodeSnapshot.data!.toJson().toString()}');
    //         return QrImage(
    //           data: userQrCodeSnapshot.data!.toJson().toString(),
    //           version: QrVersions.auto,
    //           // dataModuleStyle: QrDataModuleStyle(
    //           //   dataModuleShape: QrDataModuleShape.circle,
    //           //   color: Colors.red
    //           // ),
    //           // size: 200.0,
    //           // errorCorrectionLevel: QrErrorCorrectLevel.levels[3]
    //           // eyeStyle: QrEyeStyle(
    //           //   eyeShape: QrEyeShape.circle,
    //           //   color: Colors.red
    //           // ),
    //           // embeddedImageEmitsError: true,
    //           // foregroundColor: Colors.red
    //           // backgroundColor: Colors.white,
    //           // gapless: false,
    //
    //         );
    //       }
    //     }
    //   ),
    // );
  }
}

// class ScanCodeScreenWidget extends StatelessWidget {
//   var userId;
//   ScanCodeScreenWidget({this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Container(
//       // color: Colors.red[100],
//       padding: EdgeInsets.symmetric(horizontal: w * 0.08,vertical: h * 0.06),
//       child: FutureBuilder(
//           future: APIServices.getMakeUserQRCode(userId),
//           // future: fetchData,
//           builder: (context,AsyncSnapshot userQrCodeSnapshot) {
//             print('ScanScreen => widget.userId : ${userId}');
//             if(userQrCodeSnapshot.connectionState == ConnectionState.waiting ) {
//               return CustomProgressBar();
//             }
//             // else if(userQrCodeSnapshot.hasData == null) {
//             //   print('userQrCodeSnapshot.data : ${userQrCodeSnapshot.data}');
//             //   return Padding(
//             //     padding: EdgeInsets.only(top: h * 0.02),
//             //     child: Center(child: Text('QR Code No Found.',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))),
//             //   );
//             // }
//             else {
//               if(userQrCodeSnapshot.hasData) {
//                 print('userQrCodeSnapshot : ${userQrCodeSnapshot.data}');
//                 return QrImage(data:  '${userQrCodeSnapshot.data}', version: QrVersions.auto);
//               }
//               else{
//                 print('userQrCodeSnapshot.data : ${userQrCodeSnapshot.data}');
//                 return Padding(padding: EdgeInsets.only(top: h * 0.02), child: Center(child: Text('QR Code No Found.',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))));
//               }
//
//             }
//           }
//       ),
//     );
//   }
// }