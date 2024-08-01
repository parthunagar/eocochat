import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/productdetail/ProductDetailModel.dart';
import 'package:rentors/widget/CircularImageWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:date_format/date_format.dart' as dateformat;

class ReviewListScreen extends StatefulWidget {
  List<Reviewdatum> reviewdata;
  @override
  State<StatefulWidget> createState() {
    return ReviewListScreenState();
  }
  ReviewListScreen(this.reviewdata);
}

class ReviewListScreenState extends RentorState<ReviewListScreen> {

  @override
  void initState() {

  }



  @override
  Widget build(BuildContext context) {
    return InheritedStateContainer(
        state: this,
        child: Scaffold(
            body: widget.reviewdata.length>0? ListView.builder(
              itemBuilder: (context, index) {
                return _userReview(widget.reviewdata[index]);
              },
              itemCount: widget.reviewdata.length,
            ):Container(
              child: Text('No Review Found!'),
            ),
            appBar: AppBar(
              title: Text('Reviews'),
            )));
  }

  @override
  void update() {

  }
  Widget _userReview(Reviewdatum data) {
    return Container(
      width: config.App(context).appWidth(100),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularImageWidget(35, data.profilePic),
                SizedBox(
                  width: 5,
                ),
               Expanded(child:  Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     data.name,
                     style: TextStyle(fontSize: 14),
                   ),
                   Row(
                     children: [
                       SmoothStarRating(
                           allowHalfRating: false,
                           onRated: (v) {},
                           starCount: 5,
                           rating: double.parse(data.ratting),
                           size: 15.0,
                           isReadOnly: true,
                           color: config.Colors().orangeColor,
                           borderColor: config.Colors().orangeColor,
                           spacing: 0.0),
                       Text(
                         "(${S.of(context).five(data.ratting)})",
                         style: TextStyle(fontSize: 12),
                       ),
                     ],
                   ),
                 ],
               ),flex: 1,),
                Text(
                  S.of(context).asOn(dateformat.formatDate(
                      data.createdAt, [
                    dateformat.dd,
                    '-',
                    dateformat.M,
                    '-',
                    dateformat.yyyy
                  ])),
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w200),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                data.review,
                style: TextStyle(fontSize: 14),
              ),
            ),

          ],
        ));
  }
}
