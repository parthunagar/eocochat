import 'dart:convert';

import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/store_transection.dart';
import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
import 'package:fiberchat/Models/API_models/wallet_dashborad.dart';
import 'package:fiberchat/Models/API_models/wallet_transaction.dart';
import 'package:fiberchat/Screens/StripePay/Services/payment-service.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lottie/lottie.dart';

//ignore: must_be_immutable
class StripeHomePage extends StatefulWidget {
  var receiverUserCodeData;
  var userId;

  StripeHomePage({required this.receiverUserCodeData, required this.userId});

  // HomePage({Key key}) : super(key: key);

  @override
  StripeHomePageState createState() => StripeHomePageState();
}

class StripeHomePageState extends State<StripeHomePage> {
  TextEditingController amountController = TextEditingController();
  late double w;
  late double h;
  late String received_user_id,received_user_name, user_id,sender_user_name,wallet_balance,receiverDeviceToken;
  late double walletAmount;
  late SharedPreferences sharepf;

  @override
  void initState() {
    super.initState();

    received_user_id = widget.receiverUserCodeData.userQrCodeData!.id.toString();
    received_user_name = widget.receiverUserCodeData.userQrCodeData!.username.toString();
    receiverDeviceToken = widget.receiverUserCodeData.userQrCodeData!.deviceToken.toString();

    print('received_user_id : $received_user_id');
    print('received_user_name : $received_user_name');
    print('receiverDeviceToken : $receiverDeviceToken');

    user_id = widget.userId;
    print('user_id : ' + user_id);
    StripeService.init();
    Future.delayed(const Duration(milliseconds: 500), () {
      getWalletData(user_id);
    });

  }


  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context, '1', 'EUR');
        break;
      // case 1:
      // Navigator.pushNamed(context, '/existing-cards');
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ExistingCardsPage()));
      // break;
    }
  }

  payViaNewCard(BuildContext context, String amount, String currency) async {
    showProgress(context, amount, currency);

    // var response = await StripeService.payWithNewCard(amount: '100', currency: 'INR');
    // print('response.message : ${response.message.toString()}');
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message!), duration: new Duration(milliseconds: response.success == true ? 1200 : 3000)));
  }

  Future<void> showProgress(BuildContext context, String amount, String currency) async {
    StripeTransactionResponse result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(getFuture(amount, currency),
          message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")),
    );
    if (result.success == true) {
      print('trx : ' + result.paymentIntentId!.toString());
     WalletTransaction walletTransaction =   await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        sendToWallet(user_id, amount, '0', 'credit', result.paymentIntentId!.toString(), received_user_name,received_user_id),
        message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")));
       print('walletTransaction : ' + walletTransaction.data!.trx.toString());
       if(walletTransaction.status==1) {
         StoreTransaction storeTransaction =  await showDialog(
           context: context,
           builder: (context) => FutureProgressDialog(
             addSendTransaction(user_id, received_user_id, amount, '0', result.paymentIntentId!.toString(), received_user_name,),
             message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")));
         print('walletTransaction : ' + storeTransaction.data!.receivedData!.trx.toString());
         if(storeTransaction.status==1) {
           showResultDialog(context, result, result.paymentIntentId!.toString(), received_user_name);
         }else{
           showServerErrorDialog(context, storeTransaction.message.toString(),result.paymentIntentId!.toString());
         }
       }else{
         showServerErrorDialog(context, walletTransaction.message.toString(),result.paymentIntentId!.toString());
       }
    } else {
      showResultDialog(context, result,result.paymentIntentId!.toString(), received_user_name);
    }
  }

  void showResultDialog(BuildContext context, StripeTransactionResponse result, String paymentIntentId, String received_user_name) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
            // height: h * 0.55,
            // width: w * 0.60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Spacer(),
                  // Icon(
                  //  result.success==true? Icons.cloud_done_rounded:Icons.cancel,
                  //   color: result.success==true?Colors.green:Colors.red,
                  //   size: h * 0.2,
                  // ),
                  Lottie.asset(result.success==true ? 'assets/images/payment_success.json' : 'assets/images/payment_failed.json'),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: result.success==true?Colors.green[100]:Colors.red[100],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          paymentIntentId,
                          maxLines: 2,
                          style: TextStyle(color: result.success==true?Colors.green:Colors.red,),
                          textAlign:TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     result.message!,
                  //     style: TextStyle(color: result.success==true?Colors.green:Colors.red,),
                  //   ),
                  // ),
                  // // Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     '${getTranslated(context, 'to')} '+received_user_name,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(color: result.success==true ? Colors.green:Colors.red,),
                  //   ),
                  // ),

                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(getTranslated(context, 'done'), style: TextStyle(color: result.success ==true ? Colors.green : Colors.red))),
                  // Spacer(),
                  SizedBox(height: h *0.02),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: SplashBackgroundSolidColor,
                    child: TextButton(
                      onPressed: () {
                        // int count = 0;
                        // Navigator.of(context).popUntil((route) {
                        //   return count++ == 2;
                        // });
                        Navigator.pop(dialogContext);
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: Text(getTranslated(context, 'oK'), style: TextStyle(color: Colors.black)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void showWalletResultDialog(BuildContext context, StoreTransaction result , String paymentIntentId, String received_user_name) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
            // height: h * 0.55,
            // width: w * 0.60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Spacer(),
                  // Icon(
                  //  result.status==1? Icons.cloud_done_rounded:Icons.cancel,
                  //   color: result.status==1?Colors.green:Colors.red,
                  //   size: h * 0.2,
                  // ),
                  Lottie.asset(result.status==1 ? 'assets/images/payment_success.json' : 'assets/images/payment_failed.json'),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color:result.status==1?Colors.green[100]:Colors.red[100],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          paymentIntentId,
                          maxLines: 2,
                          style: TextStyle(color: result.status==1?Colors.green:Colors.red,),
                          textAlign:TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     '${getTranslated(context, 'to')} '+received_user_name,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(color: result.status==1?Colors.green:Colors.red,),
                  //   ),
                  // ),
                  // // Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     result.message,
                  //     style: TextStyle(color: result.status==1?Colors.green:Colors.red,),
                  //   ),
                  // ),

                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(getTranslated(context, 'done'), style: TextStyle(color: result.status==1 ? Colors.green : Colors.red))),
                  // Spacer(),
                  SizedBox(height: h *0.02),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: SplashBackgroundSolidColor,
                    child: TextButton(
                      onPressed: () {
                       // int count = 0;
                       // Navigator.of(context).popUntil((route) { return count++ == 2; });
                        Navigator.pop(dialogContext);
                        Navigator.pop(context);

                      },
                      child: Text(getTranslated(context, 'oK'), style: TextStyle(color: Colors.black)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void showServerErrorDialog(BuildContext context, String result, String paymentIntentId) {
    showDialog(barrierDismissible: false,
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
            // height: h * 0.75,
            // width: w ,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spacer(),
                  // Icon(Icons.cancel, color: Colors.red, size: h * 0.2),
                  Lottie.asset('assets/images/network_issue.json'),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(result, style: TextStyle(color: Colors.red))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(paymentIntentId, maxLines: 2, style: TextStyle(color: Colors.red), textAlign:TextAlign.center),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          width: w * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: InkWell(
                            onTap: (){
                              Clipboard.setData(new ClipboardData(text: paymentIntentId)).then((_){
                                Fiberchat.toast(getTranslated(context, 'paymentIntentIdCopieToClipboard'));
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    getTranslated(context, 'copy'),
                                    maxLines: 2, style: TextStyle(color: Colors.white), textAlign:TextAlign.center),
                                SizedBox(width: 20),
                                Icon(Icons.copy_outlined, color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${getTranslated(context, 'saveThisTransactionIdForFuture')} \n"
                      "${getTranslated(context, 'amountWillBeRefundWithinWorkingDays')} \n"
                      "${getTranslated(context, 'pleaseContactOurCustomerCare')}",
                      style: TextStyle(color: Colors.red),
                      textAlign:TextAlign.center,
                    ),
                  ),
                  // Spacer(),
                  // SizedBox(height: h * 0.02),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: SplashBackgroundSolidColor,
                    child: TextButton(
                      onPressed: () {
                        // int count = 0;
                        // Navigator.of(context).popUntil((route) {
                        //   return count++ == 2;
                        // });
                        Navigator.pop(dialogContext);
                        Navigator.pop(context);
                      },
                      child: Text(getTranslated(context, 'oK'), style: TextStyle(color: Colors.black)),
                    ),
                  )
                ],
              ),
            ),),
      ),
    );
  }

  Future getFuture(String amount, String currency) {
    return Future(() async {
      double rs = double.parse(amount) * 100;

      int rss = rs.toInt();

      print('rss : ${rs.toString()}');

      var response = await StripeService.payWithNewCard(
        amount: rss.toString(),
        currency: currency,
      );

      print('response.message : ${response..message.toString()}');
      return response;
    });
  }


  bool? autoFocus = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: eocochatYellow,
          title: Text(getTranslated(context, 'payment')),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              child: Icon(Icons.arrow_back, color: Colors.white))),
      body: Column(
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
                    child: Text('${sender_user_name[0].toUpperCase()}', style: TextStyle(color: eocochatWhite,fontSize: h * 0.06,fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(sender_user_name,style: TextStyle(fontWeight: FontWeight.bold)),
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
                    child: Text('${received_user_name[0].toUpperCase()}',style: TextStyle(color: eocochatWhite,fontSize: h * 0.06,fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(received_user_name,style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),

            ],
          ),
          Spacer(),
          Text(getTranslated(context, 'enterAmount'), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(width: h * 0.05),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text('$eocoChatCurrency',style: TextStyle(fontSize: 30,color: eocochatBlack)),
              // Icon(Icons.euro_symbol, color: Colors.black, size: 30),
              Flexible(
                child: Container(
                  // color: Colors.red[100],
                  width: w * 0.65,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: amountController,
                    autofocus: autoFocus!,
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
                    cursorColor: theme.primaryColor,
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
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       autoFocus = false;
          //     });
          //     // UserQrCode userQRCode = new UserQrCode();
          //     // userQRCode = jsonEncode(widget.code) as UserQrCode;
          //     // print('userQRCode : ${userQRCode.message}');
          //     try {
          //       print('widget.code => widget.userCodeData.userQrCodeData.id : ${widget.receiverUserCodeData.userQrCodeData.id}');
          //       print('widget.code => widget.userCodeData.message : ${widget.receiverUserCodeData.message}');
          //     } catch (e) {
          //       print('widget.code ERROR: $e');
          //     }
          //     if (amountController.text != '') {
          //       if (double.parse(amountController.text) > 0 && double.parse(amountController.text) < 1000000) {
          //
          //         //TODO replace comment
          //         payViaNewCard(context, amountController.text.toString(), 'EUR');
          //         // showResultDialog(context, "Transaction successful");
          //       } else {
          //         Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
          //       }
          //     } else {
          //       Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
          //     }
          //     // onItemPress(context, 0);
          //   },
          //   // onTap: (){
          //   //   setState(() {
          //   //     autoFocus = false;
          //   //
          //   //     FocusScope.of(context).unfocus();
          //   //   });
          //   //
          //   //   //void showResultDialog(BuildContext context, StripeTransactionResponse result, String paymentIntentId, String received_user_name) {
          //   //   // showResultDialog(context,  StripeTransactionResponse(),'', 'received_user_name');
          //   //   showServerErrorDialog(context,' walletTransaction.message'.toString(),'result.paymentIntentId'.toString());
          //   // },
          //   child: Container(
          //       height: h * 0.08,
          //       width: w,
          //       color: theme.primaryColor,
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.credit_card, color: Colors.white),
          //           SizedBox(width: w * 0.05),
          //           Text(getTranslated(context, 'payViaCard'), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          //         ],
          //       )),
          // ),

          Visibility(
            visible: walletAmount > 0,
              child: SizedBox(height: 15)),
          Visibility(
            visible: walletAmount > 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  autoFocus = false;
                });
                if (amountController.text != '') {
                  if (double.parse(amountController.text) > 0 &&
                      double.parse(amountController.text) < 1000000) {
                    if (double.parse(amountController.text) <= walletAmount) {
                      walletTransactionData(user_id,received_user_id,amountController.text.toString());
                    } else {
                      Fiberchat.toast(getTranslated(context, 'pleaseEnterLessAmountThenWalletAmount'));
                    }
                  } else {
                    Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
                  }
                } else {
                  Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
                }
                // onItemPress(context, 0);
              },
              child: Container(
                  height: h * 0.08,
                  // width: w,
                  color: theme.primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            // Icon(Icons.euro_symbol, color: Colors.white, size: 15),
                            Text('$eocoChatCurrency',style: TextStyle(fontSize: 15,color: eocochatWhite)),
                            SizedBox(width: 10),
                            Text(wallet_balance, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.account_balance_wallet_rounded, color: Colors.white),
                      SizedBox(width: w * 0.05),
                      Expanded(child: Text(getTranslated(context, 'payViaWallet'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))),

                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future sendToWallet(String user_id, String amount, String charge, String trx_type, String trx, String details,String receiverUserId) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    return APIServices.sendWalletData(user_id, amount, charge, trx_type, trx, details,fcmToken!,receiverUserId);
    //     .then((walletTransactionSnapshot) {
    //   print('walletTransactionSnapshot.toString() : ' + walletTransactionSnapshot.toString());
    //
    //
    //   WalletTransaction walletTransaction = walletTransactionFromJson(walletTransactionSnapshot.toString());
    //
    //   print('walletTransaction : ' + walletTransaction.data.trx);
    //
    // });
  }

  Future addSendTransaction(String user_id, String received_user_id, String amount, String charge, String trx, String details) async {
    debugPrint('addSendTransaction => user_id : $user_id || received_user_id : $received_user_id || amount : $amount || charge : $charge || trx : $trx || details : $details || receiverDeviceToken : $receiverDeviceToken');
    return APIServices.sendTransactionData(user_id,received_user_id, amount, charge, trx, details,receiverDeviceToken);
    //     .then((walletTransactionSnapshot) {
    //   print('walletTransactionSnapshot.toString() : ' + walletTransactionSnapshot.toString());
    //
    //
    //   WalletTransaction walletTransaction = walletTransactionFromJson(walletTransactionSnapshot.toString());
    //
    //   print('walletTransaction : ' + walletTransaction.data.trx);
    //
    // });
  }

   getWalletData(String user_id) async{
    sharepf = await SharedPreferences.getInstance();

     WalletDashBoardData?  walletDashBoardData= await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
        getWalletDataApi(user_id),
        message: Text(getTranslated(context, 'pleaseWait'))));
     print('walletDashBoardData' + walletDashBoardData!.balance.toString());
     setState(() {
       sender_user_name =  sharepf.getString(Dbkeys.nickname).toString();
       walletAmount = double.parse(double.parse(walletDashBoardData.balance.toString()).toStringAsFixed(2)) ;
       wallet_balance = walletAmount.toString();
     });

  }

  Future getWalletDataApi(String user_id) {
     return APIServices.getWalletDashBoardData(user_id);
  }

  Future<void> walletTransactionData(String userId, String receivedUserId, String amount) async {
    print('walletTransactionData => userId : $userId || receivedUserId : $receivedUserId || amount : $amount');
    StoreTransaction storeTransaction =  await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        addSendTransaction(userId, receivedUserId, amount, '0', 'wallet' ,received_user_name),
        message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")));
    print('walletTransaction : ' + storeTransaction.data!.receivedData!.trx!);
    if(storeTransaction.status==1) {
      showWalletResultDialog(context,storeTransaction,'wallet', received_user_name);
    }else{
      showWalletResultDialog(context,storeTransaction,'wallet', received_user_name);
    }
  }
}
