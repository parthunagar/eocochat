import 'dart:convert';
import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
import 'package:fiberchat/Models/API_models/wallet_transaction.dart';
import 'package:fiberchat/Screens/StripePay/Services/payment-service.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as logger;

class AddToWalletScreen extends StatefulWidget {

  @override
  _AddToWalletScreenState createState() => _AddToWalletScreenState();
}

class _AddToWalletScreenState extends State<AddToWalletScreen> {
  TextEditingController amountController = TextEditingController();

  var userId,userName,userFcmToken;

  getPrefData() async {
    await SharedPreferences.getInstance().then((value) {
      SharedPreferences val = value;
      print('getPrefData USER ID : ${val.getString(Dbkeys.sharedPrefUserId).toString()}');
      setState(() {
        userId = val.getString(Dbkeys.sharedPrefUserId).toString();
      });
      APIServices.getMakeUserQRCode(val.getString(Dbkeys.sharedPrefUserId).toString()).then((userQrCodeSnapshotValue) async {
        print('userQrCodeSnapshotValue : $userQrCodeSnapshotValue');
        setState(() {
          var userCodeData = UserQrCode.fromJson(json.decode(userQrCodeSnapshotValue));
          print('userCodeData id : ${userCodeData.userQrCodeData!.id}');
          print('userCodeData accountNumber : ${userCodeData.userQrCodeData!.accountNumber}');
          print('userCodeData deviceToken : ${userCodeData.userQrCodeData!.deviceToken}');
          userName = userCodeData.userQrCodeData!.username;
          userFcmToken = userCodeData.userQrCodeData!.deviceToken;

        });
        if(userFcmToken == null) {
          await FirebaseMessaging.instance.getToken().then((tokenVal) {
            setState(() {
              userFcmToken = tokenVal;
              print('userFcmToken : $userFcmToken');
            });
          });
        }
      }).onError((e, stackTrace) {
        print('getMakeUserQRCode ERROR : $e');
      });

    }).onError((e, stackTrace) {
      print('SharedPreferences.getInstance() ERROR : $e');
    });
  }

  getData(){
    var registrationSuccess = {
      "status" : 1,
      "message": "Registration Successfully",
      "data" : {
        "email" : "test@string.com",
        "mobile" : "919988776655",
        "username" : "test1",
        "country_code" : "+91",
        "account_number" : "4545542323231",
        "updated_at" : "",
        "created_at" : "",
        "id" : 1,

      }
    };

    var registrationFail = {
      "status" : 0,
      "message": "Registration Failed",
      "data" : null
    };

    var loginSuccess = {
      "status" : 1,
      "message": "Login Successfully",
      "data" : {
        "email" : "test@string.com",
        "mobile" : "919988776655",
        "username" : "test1",
        "country_code" : "+91",
        "account_number" : "4545542323231",
        "updated_at" : DateTime,
        "created_at" : DateTime,
        "id" : 1,
        "device_token" : "FCM_Token",
      }
    };

    var loginFail = {
      "status" : 0,
      "message": "Login Failed",
      "data" : null
    };

    var dashboardSuccess = {
      "status" : 1,
      "message": "get dashboard data Successfully",
      "data" : {
        "User_data" : {
          "id":1,
          "account_number":"34232323",
          "firstname":"test",
          "lastname":"name",
          "username":"tstname",
          "email":"test@text.com",
          "country_code":"+91",
          "mobile":"7878787878",
          "ref_by":"",
          "balance":"0.00000000",
          "image":"",
          "status":"1",
          "ev":"1",
          "sv":"1",
          "ver_code":"",
          "ver_code_send_at":"",
          "ts":"0",
          "tv":"1",
          "tsc":"",
          "created_at":DateTime,
          "updated_at":DateTime,
        },
        "address" : {
          "address" : "",
          "city" : "",
          "state" : "",
          "zip" : "",
          "country" : "",
        },
        "Account_number" : "4545542323231",
        "Balance" : "232323232323",
        "total_deposit" : "12112",
        "total_withdraw" : "4544545",
        "total_transaction" : "45445",
      }
    };

    var dashboardFail = {
      "status" : 0,
      "message": "get dashboard data failed",
      "data" : null
    };

    var creditSuccess = {
      "status": 1,
      "message": "get credit data successfully",
      "data": [
        {
          "id" : 0,
          "user_id": 1,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        },
        {
          "id" : 1,
          "user_id": 2,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        }
      ]
    };

    var creditFailed = {
      "status": 0,
      "message": "get credit data failed",
      "data": null
    };

    var debitSuccess = {
      "status": 1,
      "message": "get debit data successfully",
      "data": [
        {
          "id" : 0,
          "user_id": 1,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        },
        {
          "id" : 1,
          "user_id": 2,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        }
      ]
    };

    var debitFailed = {
      "status": 0,
      "message": "get debit data failed",
      "data": null
    };

    var depositListSuccess = {
      "status": 1,
      "message": "get deposit list data successfully",
      "data": [
        {
          "id" : 0,
          "user_id": 1,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        },
        {
          "id" : 1,
          "user_id": 2,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        }
      ]
    };

    var depositListFailed = {
      "status": 0,
      "message": "get deposit list data failed",
      "data": null
    };

    var withdrawListSuccess = {
      "status": 1,
      "message": "get withdraw list data successfully",
      "data": [
        {
          "id" : 0,
          "user_id": 1,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        },
        {
          "id" : 1,
          "user_id": 2,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        }
      ]
    };

    var withdrawListFailed = {
      "status": 0,
      "message": "get withdraw list data failed",
      "data": null
    };

    var transactionListSuccess = {
      "status": 1,
      "message": "get transaction list data successfully",
      "data": [
        {
          "id" : 0,
          "user_id": 1,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        },
        {
          "id" : 1,
          "user_id": 2,
          "amount" : "121212",
          "charge" : "23",
          "post_balance" : "2323",
          "trx_type" : "type",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime
        }
      ]
    };

    var transactionListFailed = {
      "status": 0,
      "message": "get transaction list data failed",
      "data": null
    };

    var userQRCodeDataSuccess = {
      "status": 1,
      "message": "get qr code data successfully",
      "data": {
          "id" : 0,
          "account_number": "232323267676323",
          "username" : "testname",
          "email" : "test@gmail.com",
          "mobile" : "6767676767",
          "device_token" : "token",
        }
    };

    var userQRCodeDataFailed = {
      "status": 0,
      "message": "get qr code data failed",
      "data": null
    };

    var getUserDetailsSuccess = {
      "status": 1,
      "message": "get user details data successfully",
      "data": {
        "id" : 0,
        "account_number": "232323267676323",
        "username" : "testname",
        "email" : "test@gmail.com",
        "mobile" : "6767676767",
        "device_token" : "token",
      }
    };

    var getUserDetailsFailed = {
      "status": 0,
      "message": "get user details data failed",
      "data": null
    };

    var storeTransactionSuccess = {
      "status": 1,
      "message": "get store transaction data successfully",
      "data": {
        "sender_data" : {
          "user_id": 1,
          "amount" : "121212",
          "charge" : "23",
          "trx_type" : "type",
          "post_balance" : "2323",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime,
          "id" : 0,
        },
        "received_data" : {
          "user_id": 1,
          "amount" : "121212",
          "charge" : "23",
          "trx_type" : "type",
          "post_balance" : "2323",
          "trx" : "trx",
          "details" : "details",
          "created_at": DateTime,
          "updated_at": DateTime,
          "id" : 0,
        },
      }
    };

    var storeTransactionFailed = {
      "status": 0,
      "message": "get store transaction data failed",
      "data": null
    };

    var walletTransactionSuccess = {
      "status": 1,
      "message": "get wallet transaction data successfully",
      "data": {
        "user_id": 1,
        "amount" : "121212",
        "charge" : "23",
        "trx_type" : "type",
        "post_balance" : "2323",
        "trx" : "trx",
        "details" : "details",
        "created_at": DateTime,
        "updated_at": DateTime,
        "id" : 0,
      }
    };

    var walletTransactionFailed = {
      "status": 0,
      "message": "get wallet transaction data failed",
      "data": null
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
    getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: eocochatYellow,
        title: Text(getTranslated(context, 'addToWallet')),
        leading: GestureDetector(
          onTap: () async {
            Navigator.pop(context);

            //GET TOKEN
            await FirebaseMessaging.instance.getToken().then((tokenVal) {
              print('fcmToken : $tokenVal');
            });

            //GET PREFERENCE DATA
            final prefs = await SharedPreferences.getInstance();
            final keys = prefs.getKeys();
            final prefsMap = Map<String, dynamic>();
            for(String key in keys) {
              prefsMap[key] = prefs.get(key);
            }
            logger.log('getAllPreferenceData => prefsMap : ${prefsMap.toString()}');
          },
          child: Icon(Icons.arrow_back, color: Colors.white))),
      body: Column(
        children: [
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
          GestureDetector(
            onTap: () {
              if (amountController.text != '') {
                if (double.parse(amountController.text) > 0 && double.parse(amountController.text) < 1000000) {
                  // payViaNewCard(h,w,context, amountController.text.toString(), 'EUR', '$userId', '$userName');
                  showProgress(h,w,context, amountController.text.toString(), 'EUR', '$userId', '$userName');
                } else {
                  Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
                }
              } else {
                Fiberchat.toast(getTranslated(context, 'pleaseEnterValidAmount'));
              }
            },
            child: Container(
              height: h * 0.08,
              width: w,
              color: eocochatYellow,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card, color: Colors.white),
                  SizedBox(width: w * 0.05),
                  Text(getTranslated(context, 'addAmountIntoWallet'), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              )),
          ),
        ],
      ),
    );
  }

  Future<void> showProgress(var h,var w,BuildContext context, String amount, String currency,String userId, String receivedUserName) async {
    StripeTransactionResponse result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(getFuture(amount, currency),
          message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")));
    if (result.success == true) {
      print('result.paymentIntentId : ' + result.paymentIntentId.toString());
      WalletTransaction walletTransaction =   await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
            callAddToWallet(userId, amount, '0', 'credit', result.paymentIntentId.toString(), receivedUserName,''),
          message: Text("${getTranslated(context, 'pleaseWait')} \n ${getTranslated(context, 'doNotPressBackLeaveAppWhileDoingTransaction')}")));
      // print('walletTransaction : ' + walletTransaction.data!.trx.toString());
      print('showProgress => walletTransaction.status : ${walletTransaction.status}');
      if(walletTransaction.status == 1 ) {
        showResultDialog(h,w,context, result,result.paymentIntentId.toString(), receivedUserName);
      } else {
        showServerErrorDialog(h,w,context, walletTransaction.message.toString(),result.paymentIntentId.toString());
      }
    } else {
      showResultDialog(h,w,context, result,result.paymentIntentId.toString(), receivedUserName);
    }
  }

  Future callAddToWallet(String userId, String amount, String charge, String trxType, String trx, String details,String receiverUserId) async {
    print('callAddToWallet => : userId : $userId || amount : $amount || charge : $charge || trxType : $trxType || trx : $trx || details : $details || userFcmToken : $userFcmToken');
    return APIServices.sendWalletData(userId, amount, charge, trxType, trx, details,userFcmToken,receiverUserId);
  }

  Future getFuture(String amount, String currency) {
    return Future(() async {
      double rs = double.parse(amount) * 100;
      int rss = rs.toInt();
      print('rss : ${rs.toString()}');
      var response = await StripeService.payWithNewCard(amount: rss.toString(), currency: currency);
      print('response.message : ${response..message.toString()}');
      return response;
    });
  }

  void showResultDialog(var h,var w,BuildContext context, StripeTransactionResponse result, String paymentIntentId, String receivedUserName) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
            // height: h * 0.70,
            // width: w * 0.60,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(result.success==true ? 'assets/images/payment_success.json' : 'assets/images/payment_failed.json'),
                  SizedBox(height: h *0.02),
                  result.paymentIntentId!=null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(color: result.success==true?Colors.green[100]:Colors.red[100], borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Padding(padding: const EdgeInsets.all(8.0), child: Text(paymentIntentId, maxLines: 2, style: TextStyle(color: result.success==true?Colors.green:Colors.red,), textAlign:TextAlign.center))))
                    : SizedBox.shrink(),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(getTranslated(context, 'done'), style: TextStyle(color: result.success ==true ? Colors.green : Colors.red))),
                  SizedBox(height: h *0.02),
                  Container(
                    width: MediaQuery.of(context).size.width,
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
      ),
    );
  }

  void showServerErrorDialog(var h,var w,BuildContext context, String result, String paymentIntentId) {
    showDialog(barrierDismissible: false,
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(paymentIntentId, maxLines: 2, style: TextStyle(color: Colors.red), textAlign:TextAlign.center))),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: w * 0.4,
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              Text(getTranslated(context, 'copy'), maxLines: 2, style: TextStyle(color: Colors.white), textAlign:TextAlign.center),
                              SizedBox(width: 20),
                              Icon(Icons.copy_outlined, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
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
                // Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width,
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
          ),),
      ),
    );
  }

}
