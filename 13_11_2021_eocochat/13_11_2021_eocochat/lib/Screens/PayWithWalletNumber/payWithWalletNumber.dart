// import 'package:fiberchat/Configs/Dbkeys.dart';
// import 'package:fiberchat/Configs/app_constants.dart';
// import 'package:fiberchat/Models/API_models/store_transection.dart';
// import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
// import 'package:fiberchat/Models/API_models/wallet_dashborad.dart';
// import 'package:fiberchat/Screens/StripePay/Services/payment-service.dart';
// import 'package:fiberchat/Services/API/api_service.dart';
// import 'package:fiberchat/Services/localization/language_constants.dart';
// import 'package:fiberchat/Utils/utils.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:future_progress_dialog/future_progress_dialog.dart';
// import 'package:lottie/lottie.dart';
// import 'package:share/share.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:developer' as logger;


// class PayWithWalletNumberScreen extends StatefulWidget {
//   UserQrCode? userCodeData;
//   // String? userId;
//   PayWithWalletNumberScreen({this.userCodeData,
//     // this.userId
//   });
//
//   @override
//   _PayWithWalletNumberScreenState createState() => _PayWithWalletNumberScreenState();
// }
//
// class _PayWithWalletNumberScreenState extends State<PayWithWalletNumberScreen> {
//
//   TextEditingController cWalletNo = new TextEditingController(
//     // text: 'EOCO211644254148'
//   );
//   TextEditingController amountController = new TextEditingController(
//     // text: '1'
//   );
//
//   String? userName, userId,userWalletNumber;
//   double? walletAmount;
//   SharedPreferences? sharepf;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     userName = widget.userCodeData!.userQrCodeData!.username.toString();
//     userWalletNumber = widget.userCodeData!.userQrCodeData!.accountNumber.toString();
//     userId = widget.userCodeData!.userQrCodeData!.id.toString();
//     print('userId : ' + userId!);
//     print('userWalletNumber : ' + userWalletNumber!);
//
//     StripeService.init();
//     Future.delayed(const Duration(milliseconds: 500), () {
//       getWalletData(userId!);
//     });
//
//   }
//
//   getWalletData(String userId) async {
//     String? fcmToken = await FirebaseMessaging.instance.getToken();
//     print('getWalletData => fcmToken : ' + fcmToken!);
//     sharepf = await SharedPreferences.getInstance();
//     WalletDashBoardData? walletDashBoardData= await showDialog(
//         context: context,
//         builder: (context) => FutureProgressDialog(
//             getWalletDataApi(userId),
//             message: Text(getTranslated(context, 'pleaseWait'))));
//     print('getWalletData => walletDashBoardData : ${walletDashBoardData!.balance.toString()}');
//     setState(() {
//       walletAmount = double.parse(double.parse(walletDashBoardData.balance.toString()).toStringAsFixed(2)) ;
//       print('getWalletData => walletAmount : $walletAmount');
//     });
//   }
//
//   Future getWalletDataApi(String userId) {
//     return APIServices.getWalletDashBoardData(userId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       // backgroundColor: eocochatYellow,
//       appBar: AppBar(
//         backgroundColor: eocochatYellow,
//         elevation: 0,
//         title: Text(
//           // 'Pay Via Wallet Number'
//             getTranslated(context, 'lblPayViaWalletNumber')
//         ),
//         leading: GestureDetector(
//             onTap: () async {
//               Navigator.pop(context);
//               //GET PREFERENCE DATA
//               final prefs = await SharedPreferences.getInstance();
//               final keys = prefs.getKeys();
//               final prefsMap = Map<String, dynamic>();
//               for(String key in keys) {
//                 prefsMap[key] = prefs.get(key);
//               }
//               logger.log('getAllPreferenceData => prefsMap ; ${prefsMap.toString()}');
//             },
//             child: Icon(Icons.arrow_back, color: Colors.white)),
//         actions: [
//           Container(
//             padding: EdgeInsets.only(right: w * 0.04),
//             child: GestureDetector(
//                 onTap: () {
//                   print('userCodeData : ${widget.userCodeData!.userQrCodeData!.username}');
//                   print('userCodeData : ${widget.userCodeData!.userQrCodeData!.accountNumber}');
//                   print('userCodeData : ${widget.userCodeData!.userQrCodeData!.id}');
//                   print('userCodeData : ${widget.userCodeData!.userQrCodeData!.email}');
//                   print('userCodeData : ${widget.userCodeData!.userQrCodeData!.mobile}');
//                   Share.share(widget.userCodeData!.userQrCodeData!.accountNumber!);
//                 },
//                 child: Icon(Icons.share)),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: w * 0.04),
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: h * 0.04),
//                 // Text('Pay to Wallet Number',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
//                 Flexible(
//                   child: TextField(
//                     controller: cWalletNo,
//                     cursorColor: Theme.of(context).primaryColor,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: )),
//                         focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: eocochatYellow)),
//                         contentPadding: EdgeInsets.only(right: w *0.15),
//                         // hintText: 'Enter Wallet Number',
//                         hintText: getTranslated(context, 'lblEnterWalletNumber'),
//                         // border: InputBorder.none,
//                         hintStyle: TextStyle(fontWeight: FontWeight.bold)),
//                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,// fontSize: 50
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: h * 0.03),
//                 // Text('Amount Number',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
//                 Flexible(
//                   child: TextField(
//                     controller: amountController,
//                     cursorColor: Theme.of(context).primaryColor,
//                     keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//                       LengthLimitingTextInputFormatter(6),
//                     ],
//                     decoration: InputDecoration(
//                       // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: )),
//                         focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: eocochatYellow)),
//                         contentPadding: EdgeInsets.only(right: w *0.15),
//                         // hintText: 'Enter Amount',
//                         hintText: getTranslated(context, 'lblEnterAmount'),
//                         // border: InputBorder.none,
//                         hintStyle: TextStyle(fontWeight: FontWeight.bold)),
//                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,// fontSize: 50
//                     ),
//                   ),
//                 ),
//                 // Spacer(),
//
//               ],
//             ),
//             Positioned(
//               bottom: 10,
//               child: GestureDetector(
//                 onTap: () {
//
//                   if(cWalletNo.text != '') {
//                     if(userWalletNumber != cWalletNo.text.toString()) {
//                       if (amountController.text != '') {
//                         if (double.parse(amountController.text) > 0 && double.parse(amountController.text) < 1000000) {
//                           if (double.parse(amountController.text) <= walletAmount!) {
//                             print('userId : $userId');
//                             // print('amountController : $amountController');
//                             print('wallet number : ${cWalletNo.text.trim().toString()}');
//                             walletTransaction(h,w,userWalletNumber,cWalletNo.text.trim().toString(),amountController.text.toString());
//                           } else {
//                             Fiberchat.toast(getTranslated(context, 'pleaseEnterLessAmountThenWalletAmount'));
//                           }
//                         } else {
//                           Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
//                         }
//                       } else {
//                         Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
//                       }
//                     }
//                     else {
//                       Fiberchat.toast(getTranslated(context, 'lblUserCouldNotSendYourWalletNumber'));
//                     }
//                   }
//                   else{
//                     Fiberchat.toast(getTranslated(context, 'lblPleaseEnterTheValidWalletNumber'));
//                   }
//
//                 },
//                 child: Container(
//                     height: h * 0.08,
//                     width: w * 0.95,
//                     color: eocochatYellow,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.credit_card, color: Colors.white),
//                         SizedBox(width: w * 0.05),
//                         Text(
//                             getTranslated(context, 'lblPayViaWalletNumber'),
//                             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
//                       ],
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> walletTransaction(var h, var w,String? senderWalletNumber, String? receivedWalletNumber, String amount) async {
//     // StoreTransaction? storeTransaction;
//     // try{
//     StoreTransaction storeTransaction =  await showDialog(
//         context: context,
//         builder: (context) => FutureProgressDialog(
//             addSendTransaction(senderWalletNumber!, receivedWalletNumber!, amount, '0', 'wallet' ,userName!),
//             message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")));
//
//     if(storeTransaction.status == 0) {
//       showWalletResultDialog(h,w,context,storeTransaction,'wallet', userName!);
//     }else{
//       showWalletResultDialog(h,w,context,storeTransaction,'wallet', userName!);
//     }
//   }
//
//   Future addSendTransaction(String senderWalletNumber, String receivedWalletNumber, String amount, String charge, String trx, String details) async {
//     String? fcmToken = await FirebaseMessaging.instance.getToken();
//     return APIServices.sendTransactionUsingWalletData(senderWalletNumber,receivedWalletNumber, amount, charge, trx, details,fcmToken!);
//   }
//
//   void showWalletResultDialog(var h, var w, BuildContext context, StoreTransaction result , String paymentIntentId, String received_user_name) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           backgroundColor: Colors.transparent,
//           content: Container(
//               height: h * 0.70,
//               width: w * 0.60,
//               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Spacer(),
//                     Lottie.asset(result.status == 1 ? 'assets/images/payment_success.json' : 'assets/images/payment_failed.json'),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: result.status==1 ? Colors.green[100] : Colors.red[100],
//                             borderRadius: BorderRadius.all(Radius.circular(20))),
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             paymentIntentId,
//                             maxLines: 2,
//                             style: TextStyle(color: result.status == 1 ? Colors.green : Colors.red,),
//                             textAlign:TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Spacer(),
//                     // Padding(
//                     //   padding:  EdgeInsets.all(8.0),
//                     //   child: Text(
//                     //     '${getTranslated(context, 'to')} '+ received_user_name,
//                     //     textAlign: TextAlign.center,
//                     //     style: TextStyle(color: result.status==1?Colors.green:Colors.red,),
//                     //   ),
//                     // ),
//                     // // Spacer(),
//                     // Padding(
//                     //   padding: EdgeInsets.all(8.0),
//                     //   child: Text(result.message, style: TextStyle(color: result.status==1?Colors.green:Colors.red))),
//                     Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(getTranslated(context, 'done'), style: TextStyle(color: result.status==1?Colors.green:Colors.red))),
//                     // Spacer(),
//                     SizedBox(height: h * 0.02),
//                     Container(
//                       width: w,
//                       color: SplashBackgroundSolidColor,
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.pop(dialogContext);
//                           Navigator.pop(context);
//                         },
//                         child: Text(getTranslated(context, 'oK'), style: TextStyle(color: Colors.black)),
//                       ),
//                     )
//                   ],
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }


import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/store_transection.dart';
import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
import 'package:fiberchat/Models/API_models/wallet_dashborad.dart';
import 'package:fiberchat/Screens/StripePay/Services/payment-service.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as logger;


class PayWithWalletNumberScreen extends StatefulWidget {
  UserQrCode? userCodeData;
  // String? userId;
  UserQrCode? userDetailWithMobileNo;
  PayWithWalletNumberScreen({this.userCodeData,this.userDetailWithMobileNo
    // this.userId
  });

  @override
  _PayWithWalletNumberScreenState createState() => _PayWithWalletNumberScreenState();
}

class _PayWithWalletNumberScreenState extends State<PayWithWalletNumberScreen> {

  // TextEditingController cWalletNo = new TextEditingController(
  //     // text: 'EOCO211644254148'
  // );
  TextEditingController amountController = new TextEditingController(
    // text: '1'
  );

  String? userName, userId,userWalletNumber,receiverDeviceToken,receiverWalletNumber,receiverName;
  double? walletAmount;
  SharedPreferences? sharepf;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName = widget.userCodeData!.userQrCodeData!.username.toString();
    userWalletNumber = widget.userCodeData!.userQrCodeData!.accountNumber.toString();
    userId = widget.userCodeData!.userQrCodeData!.id.toString();
    receiverDeviceToken =  widget.userDetailWithMobileNo!.userQrCodeData!.deviceToken.toString();
    receiverWalletNumber =  widget.userDetailWithMobileNo!.userQrCodeData!.accountNumber.toString();
    receiverName =  widget.userDetailWithMobileNo!.userQrCodeData!.username.toString();


    print('userId : ' + userId!);
    print('userWalletNumber : ' + userWalletNumber!);
    print('receiverDeviceToken : ' + receiverDeviceToken!);
    print('receiverWalletNumber : ' + receiverWalletNumber!);
    StripeService.init();
    Future.delayed(const Duration(milliseconds: 500), () {
      getWalletData(userId!);
    });

  }



  getWalletData(String userId) async {
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    // print('getWalletData => fcmToken : ' + fcmToken!);
    sharepf = await SharedPreferences.getInstance();
    WalletDashBoardData? walletDashBoardData= await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        getWalletDataApi(userId),
        message: Text(getTranslated(context, 'pleaseWait'))));
    print('getWalletData => walletDashBoardData : ${walletDashBoardData!.balance.toString()}');
    setState(() {
      walletAmount = double.parse(double.parse(walletDashBoardData.balance.toString()).toStringAsFixed(2)) ;
      print('getWalletData => walletAmount : $walletAmount');
    });
  }

  Future getWalletDataApi(String userId) {
    return APIServices.getWalletDashBoardData(userId);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: eocochatYellow,
      appBar: AppBar(
          backgroundColor: eocochatYellow,
          elevation: 0,
          title: Text(
            // 'Pay Via Wallet Number'
              getTranslated(context, 'lblPayViaWalletNumber')
          ),
          leading: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                //GET PREFERENCE DATA
                final prefs = await SharedPreferences.getInstance();
                final keys = prefs.getKeys();
                final prefsMap = Map<String, dynamic>();
                for(String key in keys) {
                  prefsMap[key] = prefs.get(key);
                }
                logger.log('getAllPreferenceData => prefsMap ; ${prefsMap.toString()}');
              },
              child: Icon(Icons.arrow_back, color: Colors.white)),
      actions: [
        Container(
          padding: EdgeInsets.only(right: w * 0.04),
          child: GestureDetector(
            onTap: () {
              print('userCodeData : ${widget.userCodeData!.userQrCodeData!.username}');
              print('userCodeData : ${widget.userCodeData!.userQrCodeData!.accountNumber}');
              print('userCodeData : ${widget.userCodeData!.userQrCodeData!.id}');
              print('userCodeData : ${widget.userCodeData!.userQrCodeData!.email}');
              print('userCodeData : ${widget.userCodeData!.userQrCodeData!.mobile}');
              Share.share(widget.userCodeData!.userQrCodeData!.accountNumber!);
            },
            child: Icon(Icons.share)),
        )
      ],
      ),
      body: Column(

          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: h * 0.1,
                              width: w * 0.2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: eocochatYellow),
                              child: Text('${userName![0].toUpperCase()}', style: TextStyle(color: eocochatWhite,fontSize: h * 0.06,fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(height: h * 0.01),
                            Text('$userName',style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(width: w * 0.02),
                        Padding(
                            padding: EdgeInsets.only(bottom: h *0.025),
                            child: Icon(Icons.arrow_forward,color: eocochatYellow,size: h * 0.04)),
                        SizedBox(width: w * 0.02),
                        Column(
                          children: [
                            Container(
                              height: h * 0.1,
                              width: w * 0.2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: eocochatYellow),
                              child: Text('${receiverName![0].toUpperCase()}',style: TextStyle(color: eocochatWhite,fontSize: h * 0.06,fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(height: h * 0.01),
                            Text('$receiverName',style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),



                      ],
                    ),
                    // Text('Pay to Wallet Number',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    // Flexible(
                    //   child: TextField(
                    //     controller: cWalletNo,
                    //     cursorColor: Theme.of(context).primaryColor,
                    //     keyboardType: TextInputType.text,
                    //     decoration: InputDecoration(
                    //         // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: )),
                    //         focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: eocochatYellow)),
                    //         contentPadding: EdgeInsets.only(right: w *0.15),
                    //         // hintText: 'Enter Wallet Number',
                    //         hintText: getTranslated(context, 'lblEnterWalletNumber'),
                    //         // border: InputBorder.none,
                    //         hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                    //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,// fontSize: 50
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: h * 0.03),
                    // Text('Amount Number',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),

                    Spacer(),
                    Center(
                      child: Text(getTranslated(context, 'lblEnterAmount'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                    ),

                    // SizedBox(width: h * 0.03),
                    // Flexible(
                    //
                    //   child: TextField(
                    //     controller: amountController,
                    //     cursorColor: Theme.of(context).primaryColor,
                    //     keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                    //     inputFormatters: <TextInputFormatter>[
                    //       FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    //       LengthLimitingTextInputFormatter(6),
                    //     ],
                    //     decoration: InputDecoration(
                    //       // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: )),
                    //         focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: eocochatYellow)),
                    //         contentPadding: EdgeInsets.only(right: w *0.15),
                    //         // hintText: 'Enter Amount',
                    //         hintText: getTranslated(context, 'lblEnterAmount'),
                    //         // border: InputBorder.none,
                    //         hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                    //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,// fontSize: 50
                    //     ),
                    //   ),
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$eocoChatCurrency',style: TextStyle(fontSize: 30,color: eocochatBlack)),
                        Flexible(
                          child: Container(
                            // color: Colors.red[100],
                            width: w * 0.65,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: amountController,
                              // autofocus: autoFocus!,
                              textAlign: TextAlign.center,
                              // textAlignVertical: TextAlignVertical.center,
                              onChanged: (val) {
                                print('Val : $val');
                                print('Val : ' + val.length.toString());
                              },
                              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                LengthLimitingTextInputFormatter(6),
                              ],
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: w *0.15),
                                  hintText: '0',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 50)),
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                if (amountController.text != '') {
                  if (double.parse(amountController.text) > 0 && double.parse(amountController.text) < 1000000) {
                    if (double.parse(amountController.text) <= walletAmount!) {
                      print('userId : $userId');
                      // print('amountController : $amountController');
                      print('receiverWalletNumber => ${receiverWalletNumber.toString()}');
                      walletTransaction(h,w,userWalletNumber,receiverWalletNumber,amountController.text.toString());
                    } else {
                      Fiberchat.toast(getTranslated(context, 'pleaseEnterLessAmountThenWalletAmount'));
                    }
                  } else {
                    Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
                  }
                } else {
                  Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
                }
              },
              child: Container(
                  height: h * 0.08,
                  // width: w * 0.95,
                  width: w,
                  // margin: EdgeInsets.only(bottom: h * 0.02),
                  color: eocochatYellow,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            // Icon(Icons.euro_symbol, color: Colors.white, size: 15),
                            Text('$eocoChatCurrency',style: TextStyle(fontSize: 15,color: eocochatWhite)),
                            SizedBox(width: 10),
                            Text('$walletAmount', style: TextStyle(color: eocochatWhite, fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        ),
                      ),
                      SizedBox(width: w * 0.05),
                      Icon(Icons.credit_card, color: Colors.white),
                      SizedBox(width: w * 0.05),
                      Container(
                        // color: Colors.red[200],
                        width: w * 0.35,
                        child: Text(
                          getTranslated(context, 'lblPayViaWalletNumber'),
                          textAlign: TextAlign.center,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ],
                  )),
            )
          ],
      ),
    );
  }

  Future<void> walletTransaction(var h, var w,String? senderWalletNumber, String? receivedWalletNumber, String amount) async {
    // StoreTransaction? storeTransaction;
    // try{
    StoreTransaction storeTransaction =  await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          addSendTransaction(senderWalletNumber!, receivedWalletNumber!, amount, '0', 'wallet' ,userName!),
          message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")));

    if(storeTransaction.status == 0) {
      showWalletResultDialog(h,w,context,storeTransaction,'wallet', userName!);
    } else {
      showWalletResultDialog(h,w,context,storeTransaction,'wallet', userName!);
    }
  }

  Future addSendTransaction(String senderWalletNumber, String receivedWalletNumber, String amount, String charge, String trx, String details) async {
    return APIServices.sendTransactionUsingWalletData(senderWalletNumber,receivedWalletNumber, amount, charge, trx, details,receiverDeviceToken!);
  }


  void showWalletResultDialog(var h, var w, BuildContext context, StoreTransaction result , String paymentIntentId, String received_user_name) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
              height: h * 0.70,
              width: w * 0.60,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Lottie.asset(result.status == 1 ? 'assets/images/payment_success.json' : 'assets/images/payment_failed.json'),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: result.status==1 ? Colors.green[100] : Colors.red[100],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            paymentIntentId,
                            maxLines: 2,
                            style: TextStyle(color: result.status == 1 ? Colors.green : Colors.red,),
                            textAlign:TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    // Spacer(),
                    // Padding(
                    //   padding:  EdgeInsets.all(8.0),
                    //   child: Text(
                    //     '${getTranslated(context, 'to')} '+ received_user_name,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(color: result.status==1?Colors.green:Colors.red,),
                    //   ),
                    // ),
                    // // Spacer(),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(result.message, style: TextStyle(color: result.status==1?Colors.green:Colors.red))),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(getTranslated(context, 'done'), style: TextStyle(color: result.status==1?Colors.green:Colors.red))),
                    // Spacer(),
                    SizedBox(height: h * 0.02),
                    Container(
                      width: w,
                      color: SplashBackgroundSolidColor,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          Navigator.pop(context);
                        },
                        child: Text(getTranslated(context, 'oK'), style: TextStyle(color: Colors.black)),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
