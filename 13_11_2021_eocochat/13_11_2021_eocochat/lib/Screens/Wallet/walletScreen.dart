

import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/Enum.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/wallet_dashborad.dart' as wallet;
import 'package:fiberchat/Screens/AddToWallet/addToWallet.dart';
import 'package:fiberchat/Screens/Wallet/transactionList.dart';
import 'package:fiberchat/Screens/Wallet/wallet_bottomsheet.dart';
import 'package:fiberchat/Screens/Wallet/withDrawList.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/widgets/ProgressBar/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'despositList.dart';

class WalletScreen extends StatefulWidget {
  // var pref;
  // WalletScreen({this.pref});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {


  getAllPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final prefsMap = Map<String, dynamic>();
    for(String key in keys) {
      prefsMap[key] = prefs.get(key);
    }

    print('getAllPreferenceData => prefsMap ; ${prefsMap.toString()}');
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // print('pref: ${widget.pref!.getString()}');
    return Scaffold(
      backgroundColor: eocochatYellow,
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
         if(snapshot.data == null) {
           return CustomProgressBar();
         }
         else {
           final keys = snapshot.data!.getKeys();
           final prefsMap = Map<String, dynamic>();
           for(String key in keys) {
             prefsMap[key] = snapshot.data!.get(key);
           }
           print('prefsMap : ${prefsMap.toString()}');
           print('snapshot.data!.getString(Dbkeys.phone) : ${snapshot.data!.getString(Dbkeys.id).toString()}');
           print('snapshot.data!.getString(Dbkeys.sharedPrefAccountNumber) : ${snapshot.data!.getString(Dbkeys.sharedPrefAccountNumber).toString()}');
           print('snapshot.data!.getString(Dbkeys.sharedPrefUserId) : ${snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString()}');
           return FutureBuilder<wallet.WalletDashBoardData?>(
               future: APIServices.getWalletDashBoardData(snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString()),
               // future: APIServices.getWalletDashBoardData('1'),
               builder: (context, AsyncSnapshot<wallet.WalletDashBoardData?> getUserDataSnapshot) {
                 print('sharedPrefUserId : ${snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString()}');
                 if(getUserDataSnapshot.connectionState == ConnectionState.waiting ) {
                   return CustomProgressBar();
                 }
                 // else if(getUserDataSnapshot.data == null) {
                 //   // try{
                 //   //   print('getUserDataSnapshot : ${getUserDataSnapshot.data!.accountNumber.toString()}');
                 //   // }catch(e){
                 //   //   print('getUserDataSnapshot ERROR : $e');
                 //   // }
                 //   return Center(child: Text('Data Not Found'));
                 // }
                 else{
                   print('getUserDataSnapshot : $getUserDataSnapshot');
                   try{
                     print('getUserDataSnapshot : ${getUserDataSnapshot.data!.accountNumber.toString()}');

                   }catch(e){
                     print('getUserDataSnapshot ERROR : $e');
                   }
                   return Stack(
                     children: [
                       Padding(
                         padding: EdgeInsets.only(left: w *0.04,right: w*0.04),
                         child: Column(
                           children: [
                             SizedBox(height: h * 0.05),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(children: [
                                   GestureDetector(
                                     onTap: () {
                                       Navigator.pop(context);
                                     },
                                     child: Container(
                                       padding: EdgeInsets.only(right: w *0.02),
                                       // decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(10)),
                                       child: Icon(Icons.arrow_back_ios, size: 24, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack),
                                     ),
                                     // child:  Container(
                                     //   height: h * 0.05, width: w * 0.1,
                                     //   alignment: Alignment.center,
                                     //   decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(10)),
                                     //   child: Icon(Icons.arrow_back_ios, size: 24, color: eocochatYellow),
                                     // ),
                                   ),
                                   // SizedBox(width: w * 0.02),
                                   // IconButton(
                                   //   onPressed: () {  Navigator.of(context).pop();  },
                                   //   icon: Icon( Icons.arrow_back_ios, size: 24,color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack)),
                                   Container(
                                     height: h * 0.08,
                                     width: w * 0.16,
                                     decoration: BoxDecoration(color: eocochatBlack.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: SvgPicture.asset('assets/images/profile.svg', color: eocochatBlack),
                                     ),
                                   ),
                                   SizedBox(width: w * 0.02),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(getTranslated(context, 'hello'),style: TextStyle(color: eocochatGrey,fontSize: h * 0.02)),

                                       //TODO: COMMENT
                                       snapshot.hasData || snapshot.data != null
                                         ? Text('${snapshot.data!.getString(Dbkeys.sharedPrefUsername).toString()}',style: TextStyle(fontSize: h * 0.025,fontWeight: FontWeight.bold))
                                         : Text(getTranslated(context, 'user'),style: TextStyle(fontSize: h * 0.025,fontWeight: FontWeight.bold)),
                                       //  Text(getTranslated(context, 'user'),style: TextStyle(fontSize: h * 0.025,fontWeight: FontWeight.bold)),
                                     ],
                                   ),
                                 ],),
                                 GestureDetector(
                                   onTap: () async {
                                     print(' ======> ON CLICK ADD AMOUNT INTO WALLET <====== ');
                                     //TODO : 24/03/2022 : change push to pushReplacement
                                     Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => AddToWalletScreen()));
                                   },
                                   child: Container(
                                     height: h * 0.05,
                                     width: w * 0.1,
                                     decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(10)),
                                     child: Center(
                                       // padding: const EdgeInsets.all(8.0),
                                       // child: SvgPicture.asset('assets/images/notification.svg', color: eocochatBlack)
                                       child: Icon(Icons.add,size: 25),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                             SizedBox(height: h * 0.04),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Flexible(
                                   child: Container(
                                     width: w * 0.5,
                                     decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(10), border: Border.all(color: eocochatBlack)),
                                     padding: EdgeInsets.symmetric(vertical: h * 0.022,horizontal: w * 0.025),
                                     child: Column(
                                       children: [
                                         Text(getTranslated(context, 'walletNumber'),style: TextStyle(color: eocochatGrey)),
                                         SizedBox(height: h*0.035),
                                         Text(
                                           // 'VB21213114595476',
                                           getUserDataSnapshot.data!.accountNumber.toString(),
                                           softWrap: false,
                                           maxLines: 1,
                                           overflow: TextOverflow.fade,style: TextStyle(color: eocochatBlack,fontSize: h * 0.02,fontWeight: FontWeight.bold)),
                                       ],
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: w * 0.04,),
                                 Flexible(
                                   child: GestureDetector(
                                     onTap: (){
                                       // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                       //     TransferToBankScreen(userId: snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString())));
                                     },
                                     child: Container(
                                       width: w * 0.5,
                                       decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(10), border: Border.all(color: eocochatBlack)),
                                       padding: EdgeInsets.symmetric(vertical: h * 0.022,horizontal: w * 0.025),
                                       child: Column(
                                         children: [
                                           Text(getTranslated(context, 'available_balance'),style: TextStyle(color: eocochatGrey)),
                                           SizedBox(height: h*0.035),
                                           Text(
                                             double.parse(getUserDataSnapshot.data!.balance!).toStringAsFixed(2),
                                             // 'XFA0.00',
                                             softWrap: false,
                                             maxLines: 1,
                                             overflow: TextOverflow.fade, style: TextStyle(color: eocochatBlack,fontSize: h * 0.02,fontWeight: FontWeight.bold)),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                             SizedBox(height: h * 0.04),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Flexible(
                                   child: GestureDetector(
                                     onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>DepositListScreen(userId: snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString())));
                                     },
                                     child: Container(
                                       decoration: BoxDecoration(
                                         color: eocochatWhite,
                                         borderRadius: BorderRadius.circular(10),
                                         border: Border.all(color: eocochatBlack)),
                                       padding: EdgeInsets.symmetric(vertical: h * 0.007,horizontal: w * 0.06),
                                       child: Column(
                                         children: [
                                           SvgPicture.asset('assets/images/deposits.svg'),
                                           SizedBox(height: h * 0.007),
                                           Text(
                                             double.parse(getUserDataSnapshot.data!.totalDeposit.toString()).toStringAsFixed(2),
                                             // 'XFA0.00',
                                             softWrap: false,
                                             maxLines: 1,
                                             overflow: TextOverflow.clip,style: TextStyle(color: eocochatBlack,fontSize: h * 0.016,fontWeight: FontWeight.bold)),
                                           SizedBox(height: h * 0.007),
                                           Text(getTranslated(context, 'deposits'),overflow: TextOverflow.ellipsis,style: TextStyle(color: eocochatGrey)),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: w * 0.04,),
                                 Flexible(
                                   child: GestureDetector(
                                     onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>WithDrawListScreen(userId: snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString())));
                                     },
                                     child: Container(
                                       decoration: BoxDecoration(
                                         color: eocochatWhite,
                                         borderRadius: BorderRadius.circular(10),
                                         border: Border.all(color: eocochatBlack)),
                                       padding: EdgeInsets.symmetric(vertical: h * 0.007,horizontal: w * 0.06),
                                       child: Column(
                                         children: [
                                           SvgPicture.asset('assets/images/withdraw.svg'),
                                           SizedBox(height: h * 0.007),
                                           Text(
                                             double.parse(getUserDataSnapshot.data!.totalWithdraw.toString()).toStringAsFixed(2),
                                             // 'XFA0.00',
                                             softWrap: false,
                                             maxLines: 1,
                                             overflow: TextOverflow.fade,style: TextStyle(color: eocochatBlack,fontSize: h * 0.016,fontWeight: FontWeight.bold)),
                                           SizedBox(height: h * 0.007),
                                           Text(
                                             getTranslated(context, 'withdraw'),
                                             // 'Withdraw',
                                             overflow: TextOverflow.ellipsis,style: TextStyle(color: eocochatGrey)),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: w * 0.04),
                                 Flexible(
                                   child: GestureDetector(
                                     onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionListScreen(userId: snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString())));
                                     },
                                     child: Container(
                                       decoration: BoxDecoration(
                                         color: eocochatWhite,
                                         borderRadius: BorderRadius.circular(10),
                                         border: Border.all(color: eocochatBlack)),
                                       padding: EdgeInsets.symmetric(vertical: h * 0.007,horizontal: w * 0.06),
                                       child: Column(
                                         children: [
                                           SvgPicture.asset('assets/images/trabsactions.svg'),
                                           SizedBox(height: h * 0.007),
                                           Text(
                                             double.parse(getUserDataSnapshot.data!.totalTransaction.toString()).toStringAsFixed(2),
                                             // '0',
                                             softWrap: false,
                                             maxLines: 1,
                                             overflow: TextOverflow.fade,style: TextStyle(color: eocochatBlack,fontSize: h * 0.016,fontWeight: FontWeight.bold)),
                                           SizedBox(height: h * 0.007),
                                           Text(getTranslated(context, 'transactions'),overflow: TextOverflow.ellipsis,style: TextStyle(color: eocochatGrey)),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                       WalletBottomSheetWidget(userId: '${snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString()}'),
                     ],
                   );
                 }
               }
           );
         }
          // print('snapshot.data!.getString(Dbkeys.aliasName) : ${snapshot.data!.getString(Dbkeys.aliasName).toString()}');
          // print('snapshot.data!.getString(Dbkeys.nickname) : ${snapshot.data!.getString(Dbkeys.nickname).toString()}');
          // print('snapshot.data : ${snapshot.data.toString()}');
          // print("getTranslated(context, 'allnotifications') : ${getTranslated(context, 'allnotifications').toString()}");

        }

      )


    );
  }

}
