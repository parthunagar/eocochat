import 'dart:ui';

import 'package:date_format/date_format.dart' as dateformat;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/BookingBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/BookingStatusEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/booking/MyBooking.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/CircularImageWidget.dart';
import 'package:rentors/widget/ProgressDialog.dart';

class BuyerDetailScreen extends StatefulWidget {
  final Datum data;
  BuyerDetailScreen(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuyerDetailScreenState();
  }
}

class BuyerDetailScreenState extends State<BuyerDetailScreen> {
  BookingBloc mBloc;

  ProgressDialog dialog;

  Widget footerButton() {
    return Container(
      width: config.App(context).appWidth(100),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                changeStatus("1");
              },
              child: Container(
                  padding: EdgeInsets.all(15),
                  color: config.Colors().color1ABE5B,
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).confirmOrder,
                    style: TextStyle(
                        color: config.Colors().white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            flex: 1,
          ),
          Expanded(
              child: InkWell(
                onTap: () {
                  changeStatus("0");
                },
                child: Container(
                    padding: EdgeInsets.all(15),
                    color: config.Colors().colorFE2B2B,
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).rejectOrder,
                      style: TextStyle(
                          color: config.Colors().white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              flex: 1)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mBloc = BookingBloc();
    mBloc.listen((state) {
      if (dialog != null && dialog.isShowing()) {
        dialog.hide();
      }
      if (state is DoneState) {
        Fluttertoast.showToast(msg: state.home.message);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.style(message: S.of(context).loading);
        dialog.show();
      }
    });
  }

  void changeStatus(String status) {
    mBloc.add(
        BookingStatusEvent(widget.data.productId, widget.data.userId, status));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).buyerDetails)),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          child: Card(
                            child: bookingWidget(widget.data),
                          ),
                        ),
                        Container(
                          child: Card(
                            child: ownerDetails(widget.data),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                Navigator.of(context).pushNamed("/chat",
                                    arguments: widget.data.userId);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 5),
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: config.Colors().orangeColor)),
                                alignment: Alignment.center,
                                width: config.App(context).appWidth(100),
                                child: Text(
                                  S.of(context).chatWithTheBuyer,
                                  style: TextStyle(
                                      color: config.Colors().orangeColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10), child: footerButton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookingWidget(Datum data) {
    return InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Theme.of(context).hintColor),
                                left: BorderSide(
                                    color: Theme.of(context).hintColor),
                                right: BorderSide(
                                    color: Theme.of(context).hintColor))),
                        padding: EdgeInsets.only(
                            top: 5, right: 5, bottom: 5, left: 5),
                        margin: EdgeInsets.only(top: 5, right: 5, left: 5),
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Hero(
                                tag: data.bookingPincode,
                                child: OptimizedCacheImage(
                                  fit: BoxFit.fill,
                                  imageUrl: data.productImage[0].image,
                                ))),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Theme.of(context).hintColor),
                                  bottom: BorderSide(
                                      color: Theme.of(context).hintColor),
                                  left: BorderSide(
                                      color: Theme.of(context).hintColor),
                                  right: BorderSide(
                                      color: Theme.of(context).hintColor))),
                          padding: EdgeInsets.only(
                              top: 5, right: 5, bottom: 5, left: 5),
                          child: SizedBox(
                              width: 100,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                    S
                                            .of(context)
                                            .rate(data.productDetails.price) +
                                        "/" +
                                        priceUnitValues.reverse[
                                            data.productDetails.priceUnit],
                                    style: TextStyle(fontSize: 12)),
                              )))
                    ],
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(top: 5, right: 5, bottom: 5, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.productName,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                S.of(context).payableAmount(data.payableAmount),
                                style: TextStyle(fontSize: 15),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: SizedBox(
                              width: config.App(context).appWidth(50),
                              child: Wrap(
                                children: <Widget>[
                                  for (var item in data.productDetails.fileds)
                                    Text(
                                      Utils.generateString(item),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    )
                                ],
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ],
          ),
        ));
  }

  Widget ownerDetails(Datum data) {
    return InkWell(
        onTap: () {},
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).buyerDetails,
                      style: TextStyle(fontSize: 14),
                    ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.circle,
                    //         color: Utils.statusColor(data.bookingStatus)),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       Utils.status(context, data.bookingStatus),
                    //       style: TextStyle(
                    //           fontSize: 14,
                    //           color: Utils.statusColor(data.bookingStatus)),
                    //     )
                    //   ],
                    // )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      CircularImageWidget(70, data.userProfileImage),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          data.userName,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).email,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    data.userEmail,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).address,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    data.bookingAddress,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).phone,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    data.userMobile,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).bookingDate,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    generateDateTime(
                        data.bookingStartDate, data.bookingStartTime),
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).bookingTime,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    generateDateTime(data.bookingEndDate, data.bookingEndTime),
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Divider(),
              ],
            )));
  }

  String generateDateTime(DateTime startDate, String time) {
    String date = dateformat.formatDate(
        startDate, [dateformat.dd, '-', dateformat.M, '-', dateformat.yyyy]);
    date = date + " " + time;
    return date;
  }
}
