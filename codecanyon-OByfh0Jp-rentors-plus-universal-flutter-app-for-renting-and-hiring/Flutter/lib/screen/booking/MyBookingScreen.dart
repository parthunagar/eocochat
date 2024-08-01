import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/BookingBloc.dart';
import 'package:rentors/bloc/ReviewBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/AddReviewEvent.dart';
import 'package:rentors/event/MyBookingEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/booking/MyBooking.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/MyBookingState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MyBookingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyBookingScreenState();
  }
}

class MyBookingScreenState extends State<MyBookingScreen>
    with AutomaticKeepAliveClientMixin<MyBookingScreen> {
  BookingBloc mBloc = new BookingBloc();
  ReviewBloc reviewBloc = new ReviewBloc();
  TextEditingController reviewController = TextEditingController();
  double rating = 0;

  @override
  void initState() {
    super.initState();
    mBloc.add(MyBookingEvent());
    reviewBloc.listen((state) {
      if (state is DoneState) {
        Fluttertoast.showToast(msg: state.home.message);
      }
    });
  }

  Widget bookingWidget(Datum data) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/booking_details", arguments: data);
        },
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
                    child: Stack(children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Hero(
                              tag: data.bookingId,
                              child: OptimizedCacheImage(
                                fit: BoxFit.fill,
                                imageUrl: data.productImage[0].image,
                              )),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.productName,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                S
                                        .of(context)
                                        .dollar(data.productDetails.price) +
                                    "/" +
                                    priceUnitValues
                                        .reverse[data.productDetails.priceUnit],
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                data.productAddress,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                Utils.getDateTIme(data.bookingStartDate,
                                    data.bookingStartTime),
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                Utils.getDateTIme(
                                    data.bookingEndDate, data.bookingEndTime),
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
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
                    child: InkWell(
                      onTap: () {
                        alert(data);
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: config.Colors().colorF25633,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              S.of(context).submitReview,
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
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: color(data.bookingStatus),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            status(context, data.bookingStatus),
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
        ));
  }

  String status(BuildContext context, String val) {
    if (val == "0") {
      return S.of(context).pending;
    } else if (val == "1") {
      return S.of(context).confirmed;
    } else if (val == "2") {
      return S.of(context).rejected;
    } else if (val == "3") {
      return S.of(context).completed;
    }
    return S.of(context).pending;
  }

  Color color(String val) {
    if (val == "1") {
      return config.Colors().color1ABE5B;
    } else {
      return config.Colors().colorFFA200;
    }
  }

  void alert(Datum data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: BlocProvider(
                  create: (BuildContext context) => ReviewBloc(),
                  child: BlocBuilder<ReviewBloc, BaseState>(
                      bloc: reviewBloc,
                      builder: (BuildContext context, BaseState state) {
                        return Container(
                          height: config.App(context).appHeight(50),
                          child: Column(
                            children: [
                              AppBar(
                                automaticallyImplyLeading: false,
                                title: Text(S.of(context).review),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: SmoothStarRating(
                                  size: 50,
                                  onRated: (value) {
                                    rating = value;
                                  },
                                  allowHalfRating: false,
                                  color: config.Colors().orangeColor,
                                  borderColor: config.Colors().orangeColor,
                                ),
                              ),
                              TextField(
                                  controller: reviewController,
                                  maxLengthEnforced: true,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).writeReview,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).hintColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).hintColor)),
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).hintColor,
                                      ))),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RentorRaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        S.of(context).cancel,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      ),
                                    ),
                                    RentorRaisedButton(
                                        onPressed: () {
                                          submit(data);
                                        },
                                        child: Text(S.of(context).submit,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor)))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      })));
        });
  }

  void submit(Datum data) {
    String value = reviewController.text.trim();
    if (value.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseAddReview);
    } else {
      Navigator.of(context).pop();
      reviewBloc.add(AddReviewEvent(data.productId, rating, value));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (BuildContext context) => BookingBloc(),
        child: BlocBuilder<BookingBloc, BaseState>(
            bloc: mBloc,
            builder: (BuildContext context, BaseState state) {
              if (state is MyBookingState) {
                if (state.booking.status == 201) {
                  return Center(
                    child: Text(
                      'No Record Found',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
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
            }));
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
