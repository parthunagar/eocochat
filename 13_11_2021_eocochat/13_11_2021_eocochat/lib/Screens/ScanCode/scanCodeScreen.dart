import 'dart:convert';

import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
import 'package:fiberchat/Screens/PayWithWalletNumber/payWithWalletNumber.dart';
import 'package:fiberchat/Screens/ScanCode/myCode.dart';
import 'package:fiberchat/Screens/ScanCode/scanCode.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/widgets/ProgressBar/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:fiberchat/Configs/Enum.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanCodeScreen extends StatefulWidget {
  // const ScanCodeScreen({Key? key}) : super(key: key);

  @override
  _ScanCodeScreenState createState() => _ScanCodeScreenState();
}

class _ScanCodeScreenState extends State<ScanCodeScreen>  with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool? seeQrCodeMsgBox = false;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2)..addListener(() {
      setState(() {
        print('_tabController.index : ${_tabController!.index.toString()}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: eocochatYellow,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: h * 0.13,
                // color: Colors.red[100],
                child: Stack(
                  children: [
                    // SizedBox(height: h*0.02),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: h * 0.03,),
                      margin: EdgeInsets.only(top: h *0.02),
                      width: w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: w * 0.06),
                                  width: w * 0.1,
                                  height: h * 0.05,
                                  decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: w * 0.02),
                                    child: Icon(Icons.arrow_back_ios, size: 20, color: eocochatBlack ),
                                  ),
                                ),
                              ),
                            ],),
                          Text(
                            getTranslated(context, 'scan_code'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0, color: DESIGN_TYPE ==
                                Themetype.whatsapp
                                ? eocochatWhite
                                : eocochatBlack, fontWeight: FontWeight.w600,),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () async  {
                          //
                          //       },
                          //       child: Container(
                          //         alignment: Alignment.center,
                          //         margin: EdgeInsets.only(right: w * 0.06),
                          //         width: w * 0.1,
                          //         height: h * 0.05,
                          //         decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(10)),
                          //         child: Container(
                          //           // padding: EdgeInsets.only(left: w * 0.02),
                          //           child: Icon(Icons.payments_outlined, size: 20, color: eocochatBlack ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: h * 0.72,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        FutureBuilder(
                          future: SharedPreferences.getInstance(),
                          builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                            return CustomProgressBar();
                          }
                          else{
                            print('snapshot.data!.getString(Dbkeys.phone) : ${snapshot.data!.getString(Dbkeys.id).toString()}');
                            return MyQRViewScreen(userId: '${snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString()}');
                          }
                        }
                      ),
                      FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                            return CustomProgressBar();
                          }
                          else {
                            return ScanScreen(userId: '${snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString()}',);
                          }
                        }
                      )
                        // ScanCodeScreenWidget(userId: '${snapshot.data!.getString(Dbkeys.sharedPrefUserId).toString()}',)
                      ],
                    ),
                  ),
                  _tabController!.index == 0 || seeQrCodeMsgBox == true
                    ? SizedBox()
                    : Positioned.fill(

                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
                          decoration: BoxDecoration(color: eocochatWhite, borderRadius: BorderRadius.circular(15)),
                          // alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  getTranslated(context, 'scan_this_QR_code_to_get_transaction'),
                                  // 'Scan this QR code to get Transaction',
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: h * 0.022)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('ON TAP CLOSE');
                                  setState(() {
                                    seeQrCodeMsgBox = true;
                                  });
                                },
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.12,
                                  decoration: BoxDecoration(color: eocochatYellow, shape: BoxShape.circle),
                                  child: Icon(Icons.close),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ),
                ],
              ),
              // SizedBox(height: h *0.03),
            ],
          ),
        ),
        bottomNavigationBar: menu(h, w),
      ),
    );
  }
    // return SafeArea(
    //   child: PickupLayout(
    //       scaffold: Eocochat.getNTPWrappedWidget(
    //           Scaffold(
    //               body: Column(
    //                 children: [
    //                   Card(
    //                     margin: EdgeInsets.zero,
    //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
    //                     elevation: 5,
    //                     child: Container(
    //                       height: 60,
    //                       decoration: BoxDecoration(color: eocochatYellow, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
    //                       child: Row(
    //                         children: [
    //                           GestureDetector(
    //                             onTap: () {
    //                               Navigator.of(context).pop();
    //                             },
    //                             child: Container(
    //                               alignment: Alignment.center,
    //                               margin: EdgeInsets.only(left: w * 0.06),
    //                               width: w *0.1,
    //                               height: h * 0.05,
    //                               decoration: BoxDecoration(
    //                                   color: Colors.white,
    //                                   borderRadius: BorderRadius.circular(10)),
    //                               child: Container(
    //                                 padding:  EdgeInsets.only(left: w * 0.02),
    //                                 // margin: EdgeInsets.only(top: h*0.02,bottom: h*0.02),
    //                                 child: Icon(
    //                                   Icons.arrow_back_ios,
    //                                   size: 20,
    //                                   color: eocochatBlack,///DESIGN_TYPE == Themetype.whatsapp ? eocochatBlack : eocochatBlack,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           Container(
    //                             color: Colors.red,
    //                             width: w * 0.8,
    //                             child: Text(
    //                               // getTranslated(context, 'allnotifications'),
    //                               'Scan Code',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(fontSize: 20.0, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack, fontWeight: FontWeight.w600,),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   // Container(
    //                   //   height: h * 0.87,
    //                   //   padding: EdgeInsets.only(left: w*0.08,right: w*0.08,top: h*0.02 ),
    //                   //   child: ListView.builder(
    //                   //       shrinkWrap: true,
    //                   //       physics: AlwaysScrollableScrollPhysics(),
    //                   //       // physics: NeverScrollableScrollPhysics(),
    //                   //       itemCount:  20,
    //                   //       itemBuilder: (context,indx){
    //                   //         return Container(
    //                   //           padding: EdgeInsets.symmetric(vertical: h * 0.01),
    //                   //           child: Row(
    //                   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   //             children: [
    //                   //               Column(
    //                   //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                   //                 children: [
    //                   //                   Text('Spotify',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
    //                   //                   SizedBox(height: h*0.006),
    //                   //                   Text('10 Oct,9:00 PM'),
    //                   //                 ],),
    //                   //               Text('\$ 10.00',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
    //                   //             ],
    //                   //           ),
    //                   //         );
    //                   //       }),
    //                   // ),
    //                 ],
    //               ),
    //
    //           ),
    //       )
    //   ),
    // );


  Widget menu(var h,var w) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.06,vertical: h *0.02),
      decoration: BoxDecoration(
        color: eocochatWhite,
        borderRadius: BorderRadius.circular(10),

      ),
      child: TabBar(
        controller: _tabController,
        labelColor: eocochatBlack,
        unselectedLabelColor: eocochatBlackOpacity,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: eocochatTransparent,
        onTap: (val){
          print('TabBar val : ${val.toString()}');
        },
        tabs: [
          Tab(
            text: getTranslated(context, 'scan_qr_code'),// "Scan QR code",
            // icon: SvgPicture.asset('assets/images/qr code.svg', height: h*0.03),
            icon: Icon(Icons.qr_code_scanner_outlined),
          ),
          Tab(
            text: getTranslated(context, 'qr_Barcode'),// "QR/Barcode",
            // icon: SvgPicture.asset('assets/images/scan qr.svg', height: h*0.03),
            icon: Icon(Icons.qr_code),
          ),
        ],
      ),
    );
  }
}
