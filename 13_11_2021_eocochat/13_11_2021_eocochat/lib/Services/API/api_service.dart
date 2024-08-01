
import 'dart:convert';
import 'package:fiberchat/API/api_url.dart';
import 'package:fiberchat/Models/API_models/credit_data.dart';
import 'package:fiberchat/Models/API_models/debit_data.dart';
import 'package:fiberchat/Models/API_models/deposit_list.dart';
import 'package:fiberchat/Models/API_models/login.dart';
import 'package:fiberchat/Models/API_models/notification_list.dart';
import 'package:fiberchat/Models/API_models/register.dart';
import 'package:fiberchat/Models/API_models/trancation_list.dart';
import 'package:fiberchat/Models/API_models/store_transection.dart';
import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
import 'package:fiberchat/Models/API_models/wallet_dashborad.dart' as wallet;
import 'package:fiberchat/Models/API_models/withdraw_list.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:fiberchat/Models/API_models/wallet_transaction.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class APIServices {

  static Future<List<CreditDatum>> getLatestCreditListData(String userId) async {
    http.Response response = await http.post(Uri.parse(getCreditDataURL),body: {'user_id': '$userId'});
    // print("response : ${response.toString()}");
    var resp = json.decode(response.body);
    print("getLatestCreditListData resp => : ${resp.toString()}");
    List responseJson = resp['data'];
    return responseJson.map((m) => new CreditDatum.fromJson(m)).toList();
  }

  static Future<List<DebitDatum>?> getLatestDebitListData(String userId) async {
    http.Response response = await http.post(Uri.parse(getDebitDataURL),body: {'user_id': '$userId'});
    // print("response : ${response.toString()}");
    var resp = json.decode(response.body);
    print("getLatestCreditListData resp => : ${resp.toString()}");
    List responseJson = resp['data'];
    if(resp['data'] == null){
      return null;
    }else{
      return responseJson.map((m) => new DebitDatum.fromJson(m)).toList();
    }

  }


  static Future<wallet.WalletDashBoardData?> getWalletDashBoardData(String userId) async {
    // wallet.WalletDashBoardData? student;
    print("getWalletDashBoardData userId => : ${userId.toString()}");
    http.Response response = await http.post(Uri.parse(getWalletDataURL),body: {'user_id': '$userId'});
    // print("response : ${response.toString()}");
    var resp = json.decode(response.body);
    print("getWalletDashBoardData resp => : ${resp.toString()}");
    if(resp['data'] == null){
      print("getWalletDashBoardData resp['data'] : ${resp['data'].toString()}");
      return null;
    }else{
      print("getWalletDashBoardData resp['data'] : ${resp['data'].toString()}");
      print("getWalletDashBoardData resp['data'] : ${resp['data']['Account_number'].toString()}");
     // try{
     //   print("wallet.WalletDashBoardData.fromJson(resp['data']) : ${wallet.WalletDashBoardData.fromJson(resp['data']).toString()}");
     // }catch(e){
     //   print('ERROR : $e');
     // }
      return wallet.WalletDashBoardData.fromJson(resp['data']) ;
    }
  }

  static Future<LoginData?> getLoginData(String mobileNo) async {
    print('getLoginData => mobileNo : $mobileNo');
   try{
     String? fcmToken = await FirebaseMessaging.instance.getToken();
     print('getLoginData => fcmToken : $fcmToken');
     http.Response response = await http.post(Uri.parse(getLoginDataURL),body: {'mobile_number': '$mobileNo','device_token': "${fcmToken.toString()}"});
     var resp = json.decode(response.body);
     print("getLoginData resp => : ${resp.toString()}");
     if (resp['data'] == null) {
       return null;
     } else {
       return LoginData.fromJson(resp['data']) ;
     }
   }
   catch(e){
     print('getLoginData => ERROR : $e');
   }
  }

  static Future<RegisterData?> getRegisterData(String username,String email,String mobile,String countryCode) async {
    print('getRegisterData => username : $username || email : $email || mobile : $mobile || countryCode : $countryCode');
    http.Response response = await http.post(Uri.parse(getRegisterDataURL),
      body: {
        'username': '$username',
        'email': '$email',
        'mobile': '$mobile',
        'country_code': '$countryCode',
      });
    var resp = json.decode(response.body);
    print("getRegisterData resp => : ${resp.toString()}");
    if(resp['data'] == null) {
      if(resp['status'] == 0 ) {
        Fiberchat.toast("${resp['message']}");
        // if(resp['message']['email'] != null) { Fiberchat.toast("${resp['message']['email'][0]}"); }
        // else { print("resp['message']['email'] IS NULL"); }
        //
        // if(resp['message']['mobile'] != null) { Fiberchat.toast("${resp['message']['mobile'][0]}");  }
        // else { print("resp['message']['mobile'] IS NULL"); }
        //
        // if(resp['message']['username'] != null) { Fiberchat.toast("${resp['message']['username'][0]}");  }
        // else { print("resp['message']['username'] IS NULL"); }

      }
      return null;
    }else{
      return RegisterData.fromJson(resp['data']) ;
    }
  }

  static Future getMakeUserQRCode(String userId) async {
    http.Response response = await http.post(Uri.parse(getUserQRCodeDataURL), body: { 'user_id': '$userId'});
    return response.body;
    // var resp = json.decode(response.body);
    // print("getRegisterData resp => : ${resp.toString()}");
    // if(resp == null){
    //   return null;
    // }else{
    //   return UserQrCode.fromJson(resp) ;
    // }
    // if(resp['data'] == null) {
    //   return null;
    // }else{
    //   return UserQrCode.fromJson(resp['data']) ;
    // }
  }

  static Future sendTransactionData(String senderUserId,String receivedUserId,String amount, String charge,String trx,String details,String receiverDeviceToken) async {
    print('sendTransactionData => senderUserId : $senderUserId || receivedUserId : $receivedUserId || amount : $amount || charge : $charge || trx : $trx || details : $details || receiverDeviceToken : $receiverDeviceToken');
    http.Response response = await http.post(Uri.parse(getStoreTransactionDataURL), body: {
      'sender_user_id': '$senderUserId',
      'received_user_id':'$receivedUserId',
      'amount': '$amount',
      'charge' : '$charge',
      'trx' : '$trx',
      'details' : '$details',
      'reciver_device_token': '$receiverDeviceToken'});
    print('sendTransactionData => response.body : ${response.body}');
    return storeTransactionFromJson(response.body.toString());
  }



  static Future sendTransactionUsingWalletData(String senderWalletNumber,String receivedWalletNumber,String amount, String charge,String trx,String details, String receiverDeviceToken) async {
    // print('sendTransact  ionData => fcmToken : $fcmToken');
    http.Response response = await http.post(Uri.parse(getStoreTransactionDataURL), body: {
      'sender_wallet_account': '$senderWalletNumber',
      'received_wallet_account':'$receivedWalletNumber',
      'amount': '$amount',
      'charge' : '$charge',
      'trx' : '$trx',
      'details' : '$details',
      'reciver_device_token': '${receiverDeviceToken.toString()}'});
    print('sendTransactionUsingWalletData => response.body : ${response.body} ');
    // print('response.body[1] : ${response.body[1]}');
    var resp = json.decode(response.body);
    print('sendTransactionUsingWalletData => resp : $resp');
    if(resp['data'] == null) {
      if(resp['status'] == 0 ) {
        Fiberchat.toast("${resp['message']}");
        // return null;
      }
      // return resp['status'];
    }
    else{
      return storeTransactionFromJson(response.body.toString());
    }
  }

  static Future getUserDetailWithMobileNumber(String mobileNo) async {
    // print('sendTransactionData => fcmToken : $fcmToken');
    http.Response response = await http.post(Uri.parse(getUserDetailWithMobileNoDataURL), body: { 'mobile_number': '$mobileNo'});
    print('sendTransactionUsingWalletData => response.body : ${response.body} ');
    // print('response.body[1] : ${response.body[1]}');
    var resp = json.decode(response.body);
    print('resp : $resp');
    // print('resp : ${resp['message']}');
    if(resp['data'] == null) {
      if(resp['status'] == 0 ) {
        Fiberchat.toast("${resp['message']}");
        // return null;
      }
      // return resp['status'];
    }
    else{
      return userQrCodeFromJson(response.body.toString());
    }
  }

   static Future sendWalletData(String userId,String amount, String charge,String trxType,String trx,String details,String senderDeviceToken,String receiverUserId) async {
    print('sendWalletData => senderDeviceToken : $senderDeviceToken');
    http.Response response = await http.post(Uri.parse(getWalletTransactionDataURL),
        body: {
          // 'user_id': '$userId',
          'amount': '$amount',
          'charge' : '$charge',
          'trx_type' : '$trxType',
          'trx' : '$trx',
          'details' : '$details',
          'sender_device_token' : '${senderDeviceToken.toString()}',
          'sender_user_id' :'$userId',
          'received_user_id':'$receiverUserId'
        });
    print('sendWalletData => response.body : ${response.body}');
    print('sendWalletData => response.body : ${response.statusCode}');
    print('sendWalletData => response.body : ${response.toString()}');
    return walletTransactionFromJson(response.body.toString());
  }

  static Future<UserQrCode?> getUserQRCode(String userId) async {
    http.Response response = await http.post(Uri.parse(getUserQRCodeDataURL), body: { 'user_id': '$userId'});
    var resp = json.decode(response.body);
    print("getRegisterData resp => : ${resp.toString()}");
    if(resp == null){
      return null;
    }else{
      return UserQrCode.fromJson(resp) ;
    }
    // if(resp['data'] == null){
    //   return null;
    // }else{
    //   return UserQrCode.fromJson(resp['data']) ;
    // }
  }

  static Future<List<WithDrawListDatum>?> getWithDrawList(String userId) async {
    http.Response response = await http.post(Uri.parse(getWithDrawListDataURL), body: { 'user_id': '$userId'});
    var resp = json.decode(response.body);
    print("getWithDrawList resp => : ${resp.toString()}");
    List responseJson = resp['data'];
    if(resp['data'] == null){
      return null;
    }else{
      return responseJson.map((m) => new WithDrawListDatum.fromJson(m)).toList();
    }
  }

  static Future<List<DepositListDatum>?> getDepositList(String userId) async {
    http.Response response = await http.post(Uri.parse(getDepositListDataURL), body: { 'user_id': '$userId'});
    var resp = json.decode(response.body);
    print("getDepositList resp => : ${resp.toString()}");
    List responseJson = resp['data'];
    if(resp['data'] == null){
      return null;
    }else{
      return responseJson.map((m) => new DepositListDatum.fromJson(m)).toList();
    }
  }

  static Future<List<TransactionListDatum>?> getTransactionList(String userId) async {
    print("getTransactionList resp => : URL : $getTransactionListDataURL || userId : $userId");
    http.Response response = await http.post(Uri.parse(getTransactionListDataURL), body: { 'user_id': '$userId'});
    var resp = json.decode(response.body);
    print("getTransactionList resp => : ${resp.toString()}");
    List responseJson = resp['data'];
    if(resp['data'] == null){
      print("resp['data'] == null");
      return null;
    }else{
      print("resp['data'] != null");
      return responseJson.map((m) => new TransactionListDatum.fromJson(m)).toList();
    }
  }


    static Future<List<NotificationDatum>?> getNotificationList(String userId) async {
    print("getTransactionList resp => : URL : $getNotificationListDataURL || userId : $userId");
    http.Response response = await http.post(Uri.parse(getNotificationListDataURL), body: { 'user_id': '$userId'});
    var resp = json.decode(response.body);
    print("getTransactionList resp => : ${resp.toString()}");
    List responseJson = resp['data'];
    print("getTransactionList responseJson => : ${responseJson.toString()}");
    if( resp['data'] == null){
      print('IS NULL getNotificationList => snapshot.data : ${resp['data']}');
      return null;
    } else {
      print('IS NOT NULL getNotificationList => snapshot.data : ${resp['data']}');
      return responseJson.map((m) => new NotificationDatum.fromJson(m)).toList();
    }
  }
}