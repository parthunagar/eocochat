import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/BookingProductBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/AddBookingEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/model/productdetail/ProductDetailModel.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';

class ProductPreviewScreen extends StatefulWidget {
  final Map<String, dynamic> body;

  ProductPreviewScreen(this.body);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductPreviewScreenState();
  }
}

class ProductPreviewScreenState extends State<ProductPreviewScreen> {
  ProgressDialog dialog;

  void bookProduct() {
    mBloc.add(AddBookingEvent(widget.body));
  }

  BookingProductBloc mBloc = new BookingProductBloc();

  @override
  void initState() {
    super.initState();
    mBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.style(message: S.of(context).uploading);
        dialog.show();
      } else if (state is DoneState) {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state.home.status == 200) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(msg: state.home.message);
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    ProductDetailModel details = widget.body['details'];
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).bookProduct),
      ),
      persistentFooterButtons: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: config.App(context).appWidth(95),
              child: RentorRaisedButton(
                onPressed: () {
                  bookProduct();
                },
                child: Text(
                  S.of(context).bookingConfirm,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ),
          ],
        )
      ],
      body: BlocProvider(
          create: (BuildContext context) => BookingProductBloc(),
          child: BlocBuilder<BookingProductBloc, BaseState>(
              bloc: mBloc,
              builder: (BuildContext context, BaseState state) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: OptimizedCacheImage(
                              placeholder: (context, url) {
                                return PlaceHolderWidget();
                              },
                              fit: BoxFit.fill,
                              imageUrl: Utils.getImageUrl(
                                  details.data.details.images)),
                        ),
                        Text(
                          details.data.name,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          S.of(context).rate(details.data.details.price +
                              "/" +
                              priceUnitValues
                                  .reverse[details.data.details.priceUnit]),
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Wrap(
                            children: <Widget>[
                              for (var item in details.data.details.fileds)
                                Text(
                                  Utils.generateString(item),
                                  style: TextStyle(fontSize: 12),
                                )
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).pickupDropOffLocation,
                                ),
                                Text(widget.body["address"].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      S.of(context).payableamount,
                                    )),
                                Text(
                                    S
                                        .of(context)
                                        .dollar(widget.body["payable_amount"]),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              S.of(context).startTime,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            Text(
                                              widget.body['date_from']
                                                  .toString(),
                                            ),
                                            Text(
                                              widget.body['time_from']
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(S.of(context).endTime,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w200)),
                                            Text(
                                              widget.body['date_to'].toString(),
                                            ),
                                            Text(
                                              widget.body['time_to'].toString(),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(S.of(context).payWith,
                                        style: TextStyle(fontSize: 16))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (value) {},
                                      value: 1,
                                      groupValue: 1,
                                    ),
                                    Text(S.of(context).cashOnDelivery,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
