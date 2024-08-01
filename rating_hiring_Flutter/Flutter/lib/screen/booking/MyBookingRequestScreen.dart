import 'package:date_format/date_format.dart' as dateformat;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/BookingBloc.dart';
import 'package:rentors/bloc/ReviewBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/MyBookingRequestEvent.dart';
import 'package:rentors/event/RequestReviewEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/booking/MyBooking.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/MyBookingState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';

class MyBookingRequestScreen extends StatefulWidget {
  final String productId;

  MyBookingRequestScreen(this.productId);

  @override
  State<StatefulWidget> createState() {
    return MyBookingRequestScreenState();
  }
}

class MyBookingRequestScreenState extends State<MyBookingRequestScreen> {
  BookingBloc mBloc = new BookingBloc();
  ReviewBloc reviewBloc = new ReviewBloc();
  TextEditingController reviewController = TextEditingController();
  double rating = 0;
  ProgressDialog dialog;

  @override
  void initState() {
    super.initState();
    mBloc.add(MyBookingRequestEvent(widget.productId));
    reviewBloc.listen((state) {
      if (dialog != null && dialog.isShowing()) {
        dialog.hide();
      }
      if (state is DoneState) {
        Fluttertoast.showToast(msg: state.home.message);
      } else if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.style(message: S.of(context).loading);
        dialog.show();
      }
    });
  }

  String generateDateTime(Datum data) {
    String date = dateformat.formatDate(data.bookingStartDate,
        [dateformat.dd, '-', dateformat.M, '-', dateformat.yyyy]);
    date = date + " " + data.bookingStartTime;
    return date;
  }

  // Widget bookingWidget(Datum data) {
  //   return InkWell(
  //       onTap: () {
  //         Navigator.of(context)
  //             .pushNamed("/buyer_detail", arguments: data)
  //             .then((value) {
  //           MyBookingRequestEvent(widget.productId);
  //         });
  //       },
  //       child: Card(
  //         elevation: 5,
  //         child: Container(
  //           margin: EdgeInsets.all(5),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
  //                     child: SizedBox(
  //                         width: 100,
  //                         height: 100,
  //                         child: Hero(
  //                             tag: DateTime.now().toString(),
  //                             child: OptimizedCacheImage(
  //                               fit: BoxFit.fill,
  //                               imageUrl: data.userProfileImage,
  //                             ))),
  //                   ),
  //                   Container(
  //                       margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             data.bookingUserName,
  //                             style: TextStyle(
  //                                 fontSize: 14, fontWeight: FontWeight.bold),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(top: 5),
  //                             child: Text(
  //                               S.of(context).payableAmount(data.payableAmount),
  //                               style: TextStyle(
  //                                   fontSize: 14, fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(top: 5),
  //                             child: Text(
  //                               data.bookingAddress,
  //                               style: TextStyle(fontSize: 13),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(top: 5),
  //                             child: Text(
  //                               generateDateTime(data),
  //                               style: TextStyle(fontSize: 13),
  //                             ),
  //                           )
  //                         ],
  //                       ))
  //                 ],
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Row(
  //                       children: [
  //                         InkWell(
  //                           onTap: () {
  //                             reviewBloc.add(RequestReviewEvent(
  //                                 data.userId, data.productId));
  //                           },
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                                 color: config.Colors().color_F25633,
  //                                 borderRadius: BorderRadius.circular(5)),
  //                             child: Text(
  //                               S.of(context).requestReview,
  //                               style: TextStyle(
  //                                   fontSize: 14,
  //                                   fontWeight: FontWeight.w800,
  //                                   color: Colors.white),
  //                             ),
  //                             margin: EdgeInsets.all(10),
  //                             padding: EdgeInsets.only(
  //                                 left: 15, right: 15, top: 10, bottom: 10),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         Container(
  //                           decoration: BoxDecoration(
  //                               color: config.Colors().color_F25633,
  //                               borderRadius: BorderRadius.circular(5)),
  //                           child: Text(
  //                             S.of(context).viewDetails,
  //                             style: TextStyle(
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w800,
  //                                 color: Colors.white),
  //                           ),
  //                           margin: EdgeInsets.all(10),
  //                           padding: EdgeInsets.only(
  //                               left: 15, right: 15, top: 10, bottom: 10),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ));
  // }
  Widget bookingWidget(Datum data) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed("/buyer_detail", arguments: data)
              .then((value) {
            MyBookingRequestEvent(widget.productId);
          });
        },
        child: Card(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Hero(
                              tag: data.bookingId,
                              child: OptimizedCacheImage(
                                fit: BoxFit.fill,
                                imageUrl: data.userProfileImage,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.userName,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  S
                                      .of(context)
                                      .payableAmount(data.payableAmount),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  data.bookingAddress,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  Utils.getDateTIme(data.bookingStartDate,
                                      data.bookingStartTime),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  Utils.getDateTIme(
                                      data.bookingEndDate, data.bookingEndTime),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              reviewBloc.add(RequestReviewEvent(
                                  data.userId, data.productId));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: config.Colors().colorF25633,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                S.of(context).requestReview,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: config.Colors().colorF25633,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              S.of(context).viewDetails,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
          create: (BuildContext context) => BookingBloc(),
          child: BlocBuilder<BookingBloc, BaseState>(
              bloc: mBloc,
              builder: (BuildContext context, BaseState state) {
                if (state is MyBookingState) {
                  var data = state.booking.data;
                  return ListView.separated(
                      separatorBuilder: (ctx, index) {
                        return Divider();
                      },
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return bookingWidget(data[index]);
                      });
                } else {
                  return ProgressIndicatorWidget();
                }
              })),
    );
  }
}
