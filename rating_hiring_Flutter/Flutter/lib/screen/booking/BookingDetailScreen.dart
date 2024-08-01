import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/booking/MyBooking.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/CircularImageWidget.dart';

class BookingDetailScreen extends StatelessWidget {
  final Datum data;

  BookingDetailScreen(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).details)),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Card(
                  child: bookingWidget(data, context),
                ),
              ),
              Container(
                child: Card(
                  child: ownerDetails(data, context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bookingWidget(Datum data, BuildContext context) {
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
                                tag: data.bookingId,
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

  Widget ownerDetails(Datum data, BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).ownerDetails,
                  style: TextStyle(fontSize: 14),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      CircularImageWidget(70, data.productDetails.images),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          data.productDetails.name,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
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
                    data.productDetails.mobileNo,
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
                    data.bookingStartTime.toString(),
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
                    data.bookingEndTime.toString(),
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Divider(),
              ],
            )));
  }
}
