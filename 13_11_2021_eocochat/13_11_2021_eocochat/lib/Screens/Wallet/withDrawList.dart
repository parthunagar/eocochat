import 'package:fiberchat/Configs/Enum.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/withdraw_list.dart';
import 'package:fiberchat/Screens/calling_screen/pickup_layout.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:fiberchat/widgets/ProgressBar/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//ignore: must_be_immutable
class WithDrawListScreen extends StatefulWidget {
  String? userId;
  WithDrawListScreen({this.userId});

  @override
  _WithDrawListScreenState createState() => _WithDrawListScreenState();
}

class _WithDrawListScreenState extends State<WithDrawListScreen> {
  @override
  Widget build(BuildContext context) {
    print('WithDrawListScreen => userId : ${widget.userId}');
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // leading: ,
        backgroundColor: eocochatYellow,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack,
              ),
            ),
            new Text(
              getTranslated(context, 'withdraw'),
              // 'Withdraw',
              style: TextStyle(fontSize: 20.0, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack, fontWeight: FontWeight.w600,),
            ),
          ],
        ),
        // leading: ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: FutureBuilder<List<WithDrawListDatum>?>(
          future: APIServices.getWithDrawList('${widget.userId}'),
          // future: APIServices.getWithDrawList('1'),
          builder: (context, withDrawListSnapshot) {
            if(withDrawListSnapshot.connectionState == ConnectionState.waiting ){
              // return Container(
              //   // padding: EdgeInsets.only(top: h * 0.02),
              //     height: h * 0.87,
              //     child: Center(child: CustomProgressBar(valueColor: eocochatYellow)));
              return Center(child: CustomProgressBar(valueColor: eocochatYellow));
            }
            else if(withDrawListSnapshot.data == null) {
              print('getWithDrawList snapshot.data IS NULL : ${withDrawListSnapshot.data.toString()}');
              // return Container(
              //     height: h * 0.87,
              //     child: Center(child: Text('${getTranslated(context, 'withdrawRecordNotFound')}',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))));
              return Center(child: Text('${getTranslated(context, 'withdrawRecordNotFound')}',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)));
            }
            else {
              print('getWithDrawList snapshot.data IS NOT NULL : ${withDrawListSnapshot.data.toString()}');
              return Padding(

                // color: Colors.red[100],
                // padding: EdgeInsets.only(left: w*0.08,right: w*0.08,top: h*0.02 ),
                padding: EdgeInsets.only(left: w * 0.04,right: w * 0.04,top: h * 0.02 ),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: withDrawListSnapshot.data!.length,// 20,
                    itemBuilder: (context,index) {
                      var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(withDrawListSnapshot.data![index].createdAt.toString(), true);
                      print('dateTime : $dateTime');
                      var dateLocal = dateTime.toLocal();
                      final DateFormat formatter = DateFormat('d MMM, hh:mm a');
                      final String formattedDate = formatter.format(dateLocal);
                      print('formattedDate : $formattedDate');
                      return Card(
                          child: Container(
                            // padding: EdgeInsets.symmetric(vertical: h * 0.01),
                            padding: EdgeInsets.symmetric(horizontal: w *0.02, vertical: h * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${withDrawListSnapshot.data![index].details}',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                    Text(
                                      // '$eocoChatCurrency 10.00',
                                        '$eocoChatCurrency ${double.parse(withDrawListSnapshot.data![index].amount.toString()).toStringAsFixed(2)}',
                                        style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(height: h * 0.006),
                                // '10 Oct,9:00 PM'
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(DateFormat('d MMM, hh:mm a').format(DateTime.parse(withDrawListSnapshot.data![index].createdAt.toString()))),
                                    Text(formattedDate.toString()),
                                    // Container(
                                    //   width: w *0.5,
                                    //   padding: EdgeInsets.symmetric(vertical: h * 0.01,horizontal: w * 0.02),
                                    //   decoration: BoxDecoration(color: eocochatYellow,borderRadius: BorderRadius.circular(20)),
                                    //   child: Text('Transaction ID : ${withDrawListSnapshot.data![index].trx}',
                                    //     maxLines: 1,overflow: TextOverflow.visible),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: h * 0.006),
                                Container(
                                  // width: w ,//*0.5,
                                  padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.04),
                                  decoration: BoxDecoration(color: eocochatYellow, borderRadius: BorderRadius.circular(20)),
                                  child: Text('${getTranslated(context, 'transactionID')} ${withDrawListSnapshot.data![index].trx}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],),
                          ));
                      // return Card(
                      //   child: Container(
                      //     // padding: EdgeInsets.symmetric(vertical: h * 0.01),
                      //     padding: EdgeInsets.symmetric(horizontal: w *0.02, vertical: h * 0.01),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text('Spotify',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                      //             SizedBox(height: h*0.006),
                      //             Text('10 Oct,9:00 PM'),
                      //           ],),
                      //         Text('$eocoChatCurrency 10.00',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    }),
              );
            }
          }
      ),
    );
    // return SafeArea(
    //   child: PickupLayout(
    //     scaffold: Fiberchat.getNTPWrappedWidget(
    //       Scaffold(
    //         body: Column(
    //           children: [
    //             Card(
    //               margin: EdgeInsets.zero,
    //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
    //               elevation: 5,
    //               child: Container(
    //                 height: 60,
    //                 decoration: BoxDecoration(color: eocochatYellow, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
    //                 child: Row(
    //                   children: [
    //                     IconButton(
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                       icon: Icon(
    //                         Icons.arrow_back_ios,
    //                         size: 24,
    //                         color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack,
    //                       ),
    //                     ),
    //                     new Text(
    //                       getTranslated(context, 'withdraw'),
    //                       // 'Withdraw',
    //                       style: TextStyle(fontSize: 20.0, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack, fontWeight: FontWeight.w600,),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             FutureBuilder<List<WithDrawListDatum>?>(
    //               future: APIServices.getWithDrawList('${widget.userId}'),
    //                 // future: APIServices.getWithDrawList('1'),
    //               builder: (context, withDrawListSnapshot) {
    //                 if(withDrawListSnapshot.connectionState == ConnectionState.waiting ){
    //                   return Container(
    //                     // padding: EdgeInsets.only(top: h * 0.02),
    //                     height: h * 0.87,
    //                     child: Center(child: CustomProgressBar(valueColor: eocochatYellow)));
    //                 }
    //                 else if(withDrawListSnapshot.data == null) {
    //                   print('getWithDrawList snapshot.data IS NULL : ${withDrawListSnapshot.data.toString()}');
    //                   return Container(
    //                     height: h * 0.87,
    //                     child: Center(child: Text('${getTranslated(context, 'withdrawRecordNotFound')}',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))));
    //                 }
    //                 else {
    //                   print('getWithDrawList snapshot.data IS NOT NULL : ${withDrawListSnapshot.data.toString()}');
    //                   return Container(
    //                     height: h * 0.87,
    //                     // color: Colors.red[100],
    //                     // padding: EdgeInsets.only(left: w*0.08,right: w*0.08,top: h*0.02 ),
    //                     padding: EdgeInsets.only(left: w * 0.04,right: w * 0.04,top: h * 0.02 ),
    //                     child: ListView.builder(
    //                       shrinkWrap: true,
    //                       physics: AlwaysScrollableScrollPhysics(),
    //                       // physics: NeverScrollableScrollPhysics(),
    //                       itemCount: withDrawListSnapshot.data!.length,// 20,
    //                       itemBuilder: (context,index) {
    //                         return Card(
    //                           child: Container(
    //                             // padding: EdgeInsets.symmetric(vertical: h * 0.01),
    //                             padding: EdgeInsets.symmetric(horizontal: w *0.02, vertical: h * 0.01),
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     Text('${withDrawListSnapshot.data![index].details}',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
    //                                     Text(
    //                                       // '$eocoChatCurrency 10.00',
    //                                       '$eocoChatCurrency ${double.parse(withDrawListSnapshot.data![index].amount.toString()).toStringAsFixed(2)}',
    //                                       style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
    //                                   ],
    //                                 ),
    //                                 SizedBox(height: h * 0.006),
    //                                 // '10 Oct,9:00 PM'
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     Text(DateFormat('d MMM, hh:mm a').format(DateTime.parse(withDrawListSnapshot.data![index].createdAt.toString()))),
    //                                     // Container(
    //                                     //   width: w *0.5,
    //                                     //   padding: EdgeInsets.symmetric(vertical: h * 0.01,horizontal: w * 0.02),
    //                                     //   decoration: BoxDecoration(color: eocochatYellow,borderRadius: BorderRadius.circular(20)),
    //                                     //   child: Text('Transaction ID : ${withDrawListSnapshot.data![index].trx}',
    //                                     //     maxLines: 1,overflow: TextOverflow.visible),
    //                                     // ),
    //                                   ],
    //                                 ),
    //                                 SizedBox(height: h * 0.006),
    //                                 Container(
    //                                   // width: w ,//*0.5,
    //                                   padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.04),
    //                                   decoration: BoxDecoration(color: eocochatYellow, borderRadius: BorderRadius.circular(20)),
    //                                   child: Text('${getTranslated(context, 'transactionID')} ${withDrawListSnapshot.data![index].trx}',
    //                                     maxLines: 1,
    //                                     overflow: TextOverflow.ellipsis,
    //                                     style: TextStyle(fontWeight: FontWeight.bold)),
    //                                 ),
    //                               ],),
    //                           ));
    //                         // return Card(
    //                         //   child: Container(
    //                         //     // padding: EdgeInsets.symmetric(vertical: h * 0.01),
    //                         //     padding: EdgeInsets.symmetric(horizontal: w *0.02, vertical: h * 0.01),
    //                         //     child: Row(
    //                         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         //       children: [
    //                         //         Column(
    //                         //           crossAxisAlignment: CrossAxisAlignment.start,
    //                         //           children: [
    //                         //             Text('Spotify',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
    //                         //             SizedBox(height: h*0.006),
    //                         //             Text('10 Oct,9:00 PM'),
    //                         //           ],),
    //                         //         Text('$eocoChatCurrency 10.00',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
    //                         //       ],
    //                         //     ),
    //                         //   ),
    //                         // );
    //                       }),
    //                   );
    //                 }
    //               }
    //             ),
    //           ],
    //         )))),
    // );
  }
}
