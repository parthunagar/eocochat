import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/credit_data.dart';
import 'package:fiberchat/Models/API_models/debit_data.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/widgets/ProgressBar/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


//ignore: must_be_immutable
class WalletBottomSheetWidget extends StatefulWidget {
  String? userId;
  WalletBottomSheetWidget({this.userId});

  @override
  _WalletBottomSheetWidgetState createState() => _WalletBottomSheetWidgetState();
}

class _WalletBottomSheetWidgetState extends State<WalletBottomSheetWidget> {

  bool? latestCredits = false;
  bool? latestDebits = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: h * 0.5,
        decoration: BoxDecoration(
          color: eocochatWhite,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(h*0.05),topRight: Radius.circular(h*0.05))),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Container(
              // height: h * 0.6,
              margin: EdgeInsets.only(top: h * 0.05),
              width: w,
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    //LATEST CREDITS
                    Text(getTranslated(context, 'latest_credits'),style: TextStyle(color: eocochatYellow,fontSize: h*0.025)),

                    // Column(
                    //   children: [
                    //     ListView.builder(
                    //         shrinkWrap: true,
                    //         physics: NeverScrollableScrollPhysics(),
                    //         itemCount: latestCredits == false ? 3 : 10,
                    //         // itemCount: snapshot.data!.length < 3 || latestDebits == true ? snapshot.data!.length : 3,
                    //         itemBuilder: (context,index){
                    //           return Container(
                    //             padding: EdgeInsets.symmetric(vertical: h * 0.01),
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text('Spotify',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                    //                     SizedBox(height: h*0.006),
                    //                     Text('10 Oct,8:25 PM'),
                    //                   ],),
                    //                 Text('$eocoChatCurrency ${20.00}',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                    //               ],
                    //             ),
                    //           );
                    //         }),
                    //      Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         SizedBox(),
                    //         ElevatedButton(
                    //           style: ButtonStyle(
                    //               elevation: MaterialStateProperty.all(5),
                    //               shadowColor: MaterialStateProperty.all(eocochatBlack),
                    //               backgroundColor: MaterialStateProperty.all(eocochatWhite)
                    //           ),
                    //           onPressed: (){
                    //             setState(() {
                    //               latestCredits = latestCredits == true ? false : true;
                    //             });
                    //           },
                    //           child:  Row(
                    //             children: [
                    //               Text(latestCredits == false ? 'See All' : 'Hide',style: TextStyle(color:eocochatBlack)),
                    //               Icon(latestCredits == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,color: eocochatBlack)
                    //             ],
                    //         ) ) ,
                    //       ],
                    //     ),
                    //   ],
                    // ),

                    //TODO: COMMENT
                    FutureBuilder<List<CreditDatum>>(
                      future: APIServices.getLatestCreditListData(
                          // '24'
                        widget.userId!
                      ),
                      builder: (context,AsyncSnapshot<List<CreditDatum>> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          print('snapshot.connectionState : ${snapshot.connectionState.toString()}');
                          return CustomProgressBar(valueColor: eocochatYellow);
                        }
                        else if(snapshot.data == null || snapshot.data!.length == 0 ) {
                          print('getLatestCreditListData snapshot.data : ${snapshot.data.toString()}');
                          return Padding(
                            padding: EdgeInsets.only(top: h * 0.02),
                            child: Center(child: Text('No Credit Record Found.',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))),
                          );
                        }
                        else{
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // itemCount: latestCredits == false ? 3 : 10,
                                itemCount: snapshot.data!.length < 3 || latestCredits == true ? snapshot.data!.length : 3,
                                itemBuilder: (context,index) {
                                  var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(snapshot.data![index].createdAt.toString(), true);
                                  print('dateTime : $dateTime');
                                  var dateLocal = dateTime.toLocal();
                                  final DateFormat formatter = DateFormat('d MMM, hh:mm a');
                                  final String formattedDate = formatter.format(dateLocal);
                                  print('formattedDate : $formattedDate');

                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: h * 0.01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].details.toString(),style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                            SizedBox(height: h*0.006),
                                            // Text('10 Oct,8:25 PM'),
                                            // Text(DateFormat('d MMM, hh:mm a').format(DateTime.parse(snapshot.data![index].createdAt.toString())))
                                            Text('${formattedDate.toString()}')
                                          ],),
                                        Text('$eocoChatCurrency ${double.parse(snapshot.data![index].amount!).toStringAsFixed(2)}',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  );
                                }),
                              snapshot.data!.length < 3 ? SizedBox() : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(5),
                                      shadowColor: MaterialStateProperty.all(eocochatBlack),
                                      backgroundColor: MaterialStateProperty.all(eocochatWhite)),
                                    onPressed: (){
                                      setState(() {
                                        // latestCredits = latestCredits == true ? false : true;
                                        latestCredits = !latestCredits!;
                                      });
                                    },
                                  child:  Row(
                                     children: [
                                        Text(latestCredits == false ? getTranslated(context, 'see_all') : getTranslated(context, 'hide'),style: TextStyle(color:eocochatBlack)),
                                        Icon(latestCredits == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,color: eocochatBlack)
                                      ],
                                  )),
                                ],
                              ),
                            ],
                          );
                        }
                      }
                    ),


                    SizedBox(height: h * 0.03),

                    //LATEST DEBITS
                    Text(getTranslated(context, 'latest_debits'),style: TextStyle(color: eocochatYellow,fontSize: h*0.025)),
                    // Column(
                    //   children: [
                    //     ListView.builder(
                    //         shrinkWrap: true,
                    //         physics: NeverScrollableScrollPhysics(),
                    //         itemCount: latestDebits == false  ? 3 : 10,
                    //         itemBuilder: (context,index){
                    //           return Container(
                    //             padding: EdgeInsets.symmetric(vertical: h * 0.01),
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text('Spotify',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                    //                     SizedBox(height: h*0.006),
                    //                     Text('10 Oct,9:00 PM'),
                    //                   ],),
                    //                 Text('$eocoChatCurrency 10.00',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                    //               ],
                    //             ),
                    //           );
                    //         }),
                    //
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         SizedBox(),
                    //         ElevatedButton(
                    //             style: ButtonStyle(
                    //                 elevation: MaterialStateProperty.all(5),
                    //                 shadowColor: MaterialStateProperty.all(eocochatBlack),
                    //                 backgroundColor: MaterialStateProperty.all(eocochatWhite)
                    //             ),
                    //             onPressed: (){
                    //               setState(() {
                    //                 latestDebits = latestDebits == true ? false : true;
                    //               });
                    //             }, child: Row(
                    //           children: [
                    //             Text(latestDebits == false ? getTranslated(context, 'see_all') : getTranslated(context, 'hide'),style: TextStyle(color: eocochatBlack)),
                    //             Icon(latestDebits == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,color: eocochatBlack)
                    //           ],
                    //         )),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //TODO: COMMENT
                    FutureBuilder<List<DebitDatum>?>(
                      future: APIServices.getLatestDebitListData(
                          // '24'
                          widget.userId!
                      ),
                      builder: (context,AsyncSnapshot<List<DebitDatum>?> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          print('snapshot.connectionState : ${snapshot.connectionState.toString()}');
                          return CustomProgressBar(valueColor: eocochatYellow);
                        }
                        else if(snapshot.data == null || snapshot.data!.length == 0 ) {
                          print('getLatestCreditListData snapshot.data : ${snapshot.data.toString()}');
                          return Padding(
                            padding: EdgeInsets.only(top: h * 0.02),
                            child: Center(child: Text('No Debit Record Found.',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))),
                          );
                        }
                        else{
                          print('getLatestCreditListData snapshot.data : ${snapshot.data!.length.toString()}');

                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length < 3 || latestDebits == true ? snapshot.data!.length : 3,
                                // latestDebits == false || snapshot.data!.length < 3 ? 3 : 10,
                                itemBuilder: (context,index){
                                  var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").parse(snapshot.data![index].createdAt.toString(), true);
                                  print('dateTime : $dateTime');
                                  var dateLocal = dateTime.toLocal();
                                  final DateFormat formatter = DateFormat('d MMM, hh:mm a');
                                  final String formattedDate = formatter.format(dateLocal);
                                  print('formattedDate : $formattedDate');
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: h * 0.01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Text('Spotify',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                            // SizedBox(height: h*0.006),
                                            // Text('10 Oct,9:00 PM'),
                                            Text(snapshot.data![index].details.toString(),style: TextStyle(fontSize: h * 0.025,fontWeight: FontWeight.bold)),
                                            SizedBox(height: h * 0.006),
                                            // Text('10 Oct,8:25 PM'),
                                            // Text(DateFormat('d MMM, hh:mm a').format(DateTime.parse(snapshot.data![index].createdAt.toString())))
                                            Text(formattedDate.toString())
                                          ],),
                                        // Text('$eocoChatCurrency 10.00',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                        Text('$eocoChatCurrency ${double.parse(snapshot.data![index].amount!).toStringAsFixed(2)}',style: TextStyle(fontSize: h * 0.025,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  );
                                }),

                              snapshot.data!.length < 3 ? SizedBox() : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(5),
                                      shadowColor: MaterialStateProperty.all(eocochatBlack),
                                      backgroundColor: MaterialStateProperty.all(eocochatWhite)
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        // latestDebits = latestDebits == true ? false : true;
                                        latestDebits = !latestDebits!;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(latestDebits == false ? getTranslated(context, 'see_all') : getTranslated(context, 'hide'),style: TextStyle(color: eocochatBlack)),
                                        Icon(latestDebits == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,color: eocochatBlack)
                                      ],
                                  )),
                                ],
                              ),
                            ],
                          );
                        }
                      }
                    ),
                    SizedBox(height: h * 0.03),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
