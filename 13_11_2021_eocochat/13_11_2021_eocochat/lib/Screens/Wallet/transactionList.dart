import 'package:fiberchat/Configs/Enum.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/trancation_list.dart';
import 'package:fiberchat/Screens/calling_screen/pickup_layout.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:fiberchat/widgets/ProgressBar/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//406
//ignore: must_be_immutable
class TransactionListScreen extends StatefulWidget {
  String? userId;
  TransactionListScreen({this.userId});

  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {

  aleartDialogWidget(String details,String amount,String trxType,String createdAt,String trx,var h, var w) {
    // '${transactionListSnapshot.data![index].details}',
    // '$eocoChatCurrency ${double.parse(transactionListSnapshot.data![index].amount.toString()).toStringAsFixed(2)}',
    // '${transactionListSnapshot.data![index].trxType}',
    // '${transactionListSnapshot.data![index].createdAt}',
    // '${transactionListSnapshot.data![index].trx}'
    print('details : $details');
    print('amount : $amount');
    print('trxType : $trxType');
    print('createdAt : $createdAt');
    print('trx : $trx');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {  Navigator.pop(context);  },
                  child: Container(
                    decoration: BoxDecoration(color: eocochatYellow,borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.close,color: eocochatWhite))),
              ),
              // Text("Details"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('$amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22))),
              SizedBox(height: h * 0.03),
              Center(child: Text('$createdAt',style: TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(height: h * 0.03),
              Text('${getTranslated(context, 'transactionDetails')}',style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$details'),
              SizedBox(height: h * 0.03),
              Text('Transaction ID',style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$trx'),
              SizedBox(height: h * 0.03),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Transaction Type : ',style: TextStyle(fontWeight: FontWeight.bold,color: eocochatBlack)),
                    TextSpan(text: '$trxType', style: TextStyle(color: trxType == 'Cr' ? eocochatLightGreen : eocochatRed,fontWeight: FontWeight.bold)),
                  ],
                )),
              // Text('Transaction Type : ',style: TextStyle(fontWeight: FontWeight.bold)),
              // Text('$trxType',style: TextStyle(color: trxType == 'Cr' ? eocochatLightGreen : eocochatRed,fontWeight: FontWeight.bold)),
              SizedBox(height: h * 0.03)
              // RichText(
              //   textAlign: TextAlign.start,
              //   text: TextSpan(
              //     children: [
              //       TextSpan(text: 'Transaction Details',style: TextStyle(fontWeight: FontWeight.bold,color: eocochatBlack)),
              //       TextSpan(text: '$details', style: TextStyle(color: eocochatBlack)),
              //     ],
              //   )),
              // RichText(
              //     textAlign: TextAlign.start,
              //     text: TextSpan(
              //       children: [
              //         TextSpan(text: 'Transaction ID',style: TextStyle(fontWeight: FontWeight.bold,color: eocochatBlack, fontSize: 18)),
              //         TextSpan(text: '$trx', style: TextStyle(color: eocochatBlack, fontSize: 18)),
              //       ],
              //     )),

            ],
          ),
          // actions: [  TextButton(child: Text("Remind me later"),  onPressed:  () {},   ),  ],
        );
      },

    );
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () { Navigator.of(context).pop();  },
              icon: Icon(Icons.arrow_back_ios, size: 24, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack),
            ),
            new Text(
              getTranslated(context, 'transactions'),
              // 'Transactions',
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
      body: FutureBuilder<List<TransactionListDatum>?>(
          future: APIServices.getTransactionList('${widget.userId}'),
          //future: APIServices.getTransactionList('24'),
          builder: (context, transactionListSnapshot) {
            if(transactionListSnapshot.connectionState == ConnectionState.waiting ) {
              // return Container(
              //   // padding: EdgeInsets.only(top: h * 0.02),
              //     height: h * 0.87,
              //     child: Center(child: CustomProgressBar(valueColor: eocochatYellow)));
              return Center(child: CustomProgressBar(valueColor: eocochatYellow));
            }
            else if(transactionListSnapshot.data == null) {
              print('getWithDrawList snapshot.data IS NULL : ${transactionListSnapshot.data.toString()}');
              // return Container(
              //     height: h * 0.87,
              //     child: Center(child: Text('${getTranslated(context, 'transactionRecordNotFound')}',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))));
              return Center(child: Text('${getTranslated(context, 'transactionRecordNotFound')}',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)));
            }
            else{
              return Padding(
                padding: EdgeInsets.only(left: w * 0.04,right: w * 0.04,top: h * 0.02 ),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount:  transactionListSnapshot.data!.length,
                    itemBuilder: (context,index) {
                      var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(transactionListSnapshot.data![index].createdAt.toString(), true);
                      print('dateTime : $dateTime');
                      var dateLocal = dateTime.toLocal();
                      final DateFormat formatter = DateFormat('d MMM, hh:m:ss a');
                      final String formattedDate = formatter.format(dateLocal);
                      print('formattedDate : $formattedDate');
                      return GestureDetector(
                        onTap: () {
                          //TODO: CREATE DIALOG ON TAP TRANSACTION
                          // aleartDialogWidget(
                          //   '${transactionListSnapshot.data![index].details}',
                          //   '$eocoChatCurrency ${double.parse(transactionListSnapshot.data![index].amount.toString()).toStringAsFixed(2)}',
                          //   '${transactionListSnapshot.data![index].trxType == '+' ? 'Cr' : 'Dr'}',
                          //   '${DateFormat('d MMM, hh:m:ss a').format(DateTime.parse(transactionListSnapshot.data![index].createdAt.toString()))}',
                          //   '${transactionListSnapshot.data![index].trx}',
                          //   h,w
                          // );
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: w *0.02, vertical: h * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: w * 0.45,
                                      child: Text('${transactionListSnapshot.data![index].details}',
                                        overflow: TextOverflow.fade,// maxLines: 1,softWrap: false,
                                        style: TextStyle(fontSize: h * 0.025,fontWeight: FontWeight.bold))),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // '$eocoChatCurrency 1234523.00',
                                          '$eocoChatCurrency ${double.parse(transactionListSnapshot.data![index].amount.toString()).toStringAsFixed(2)}',
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                        SizedBox(width: w * 0.02),
                                        Text(
                                          '${transactionListSnapshot.data![index].trxType == '+' ? 'Cr' : 'Dr'}',
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          style: TextStyle(fontWeight: FontWeight.bold,color: transactionListSnapshot.data![index].trxType == '+' ? eocochatLightGreen : eocochatRed ))
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: h * 0.006),
                                //Text('10 Oct,9:00 PM'),
                                // Text('${DateFormat('d MMM, hh:m:ss a').format(DateTime.parse(transactionListSnapshot.data![index].createdAt.toString()))}'),
                                Text(formattedDate.toString()),
                                SizedBox(height: h * 0.006),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: w * 0.85,//* 0.5,
                                      padding: EdgeInsets.symmetric(vertical: h * 0.01,horizontal: w * 0.04),
                                      decoration: BoxDecoration(color: eocochatYellow, borderRadius: BorderRadius.circular(20)),
                                      child: Text(
                                        '${getTranslated(context, 'transactionID')} ${transactionListSnapshot.data![index].trx}',
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ],),
                          ),
                        ),
                      );
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
    //                       onPressed: () { Navigator.of(context).pop();  },
    //                       icon: Icon(Icons.arrow_back_ios, size: 24, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack),
    //                     ),
    //                     new Text(
    //                       getTranslated(context, 'transactions'),
    //                       // 'Transactions',
    //                       style: TextStyle(fontSize: 20.0, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack, fontWeight: FontWeight.w600,),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //             FutureBuilder<List<TransactionListDatum>?>(
    //               future: APIServices.getTransactionList('${widget.userId}'),
    //               //future: APIServices.getTransactionList('24'),
    //               builder: (context, transactionListSnapshot) {
    //                 if(transactionListSnapshot.connectionState == ConnectionState.waiting ) {
    //                   return Container(
    //                     // padding: EdgeInsets.only(top: h * 0.02),
    //                     height: h * 0.87,
    //                     child: Center(child: CustomProgressBar(valueColor: eocochatYellow)));
    //                 }
    //                 else if(transactionListSnapshot.data == null) {
    //                   print('getWithDrawList snapshot.data IS NULL : ${transactionListSnapshot.data.toString()}');
    //                   return Container(
    //                     height: h * 0.87,
    //                     child: Center(child: Text('${getTranslated(context, 'transactionRecordNotFound')}',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))));
    //                 }
    //                 else{
    //                   return Container(
    //                     height: h * 0.87,
    //                     padding: EdgeInsets.only(left: w * 0.04,right: w * 0.04,top: h * 0.02 ),
    //                     child: ListView.builder(
    //                       shrinkWrap: true,
    //                       physics: AlwaysScrollableScrollPhysics(),
    //                       itemCount:  transactionListSnapshot.data!.length,
    //                       itemBuilder: (context,index){
    //                         return GestureDetector(
    //                           onTap: () {
    //                             //TODO: CREATE DIALOG ON TAP TRANSACTION
    //                             // aleartDialogWidget(
    //                             //   '${transactionListSnapshot.data![index].details}',
    //                             //   '$eocoChatCurrency ${double.parse(transactionListSnapshot.data![index].amount.toString()).toStringAsFixed(2)}',
    //                             //   '${transactionListSnapshot.data![index].trxType == '+' ? 'Cr' : 'Dr'}',
    //                             //   '${DateFormat('d MMM, hh:m:ss a').format(DateTime.parse(transactionListSnapshot.data![index].createdAt.toString()))}',
    //                             //   '${transactionListSnapshot.data![index].trx}',
    //                             //   h,w
    //                             // );
    //                           },
    //                           child: Card(
    //                             child: Container(
    //                               padding: EdgeInsets.symmetric(horizontal: w *0.02, vertical: h * 0.01),
    //                               child: Column(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 children: [
    //                                   Row(
    //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Container(
    //                                         width: w * 0.45,
    //                                         child: Text('${transactionListSnapshot.data![index].details}',
    //                                           overflow: TextOverflow.fade,// maxLines: 1,softWrap: false,
    //                                           style: TextStyle(fontSize: h * 0.025,fontWeight: FontWeight.bold))),
    //                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                         children: [
    //                                           Text(
    //                                             // '$eocoChatCurrency 1234523.00',
    //                                             '$eocoChatCurrency ${double.parse(transactionListSnapshot.data![index].amount.toString()).toStringAsFixed(2)}',
    //                                             maxLines: 1,
    //                                             overflow: TextOverflow.fade,
    //                                             softWrap: false,
    //                                             style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
    //                                           SizedBox(width: w * 0.02),
    //                                           Text(
    //                                             '${transactionListSnapshot.data![index].trxType == '+' ? 'Cr' : 'Dr'}',
    //                                             maxLines: 1,
    //                                             overflow: TextOverflow.fade,
    //                                             softWrap: false,
    //                                             style: TextStyle(fontWeight: FontWeight.bold,color: transactionListSnapshot.data![index].trxType == '+' ? eocochatLightGreen : eocochatRed ))
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   SizedBox(height: h * 0.006),
    //                                   //Text('10 Oct,9:00 PM'),
    //                                   Text('${DateFormat('d MMM, hh:m:ss a').format(DateTime.parse(transactionListSnapshot.data![index].createdAt.toString()))}'),
    //                                   SizedBox(height: h * 0.006),
    //                                   Row(
    //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Container(
    //                                         width: w * 0.85,//* 0.5,
    //                                         padding: EdgeInsets.symmetric(vertical: h * 0.01,horizontal: w * 0.04),
    //                                         decoration: BoxDecoration(color: eocochatYellow, borderRadius: BorderRadius.circular(20)),
    //                                         child: Text(
    //                                           '${getTranslated(context, 'transactionID')} ${transactionListSnapshot.data![index].trx}',
    //                                           maxLines: 1,
    //                                           overflow: TextOverflow.fade,
    //                                           softWrap: false,
    //                                           style: TextStyle(fontWeight: FontWeight.bold))),
    //                                     ],
    //                                   ),
    //                                 ],),
    //                             ),
    //                           ),
    //                         );
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
    //
    //               }
    //             ),
    //           ],
    //         )))),
    // );
  }
}
