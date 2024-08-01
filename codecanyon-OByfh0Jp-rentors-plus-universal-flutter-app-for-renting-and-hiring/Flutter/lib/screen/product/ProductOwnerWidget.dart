import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/productdetail/ProductDetailModel.dart';
import 'package:rentors/widget/CircularImageWidget.dart';

class ProductOwnerWidget extends StatefulWidget {
  final ProductDetailModel mModel;

  ProductOwnerWidget(this.mModel);

  @override
  State<StatefulWidget> createState() {
    return ProductOwnerWidgetState();
  }
}

class ProductOwnerWidgetState extends State<ProductOwnerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).userDetails,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircularImageWidget(60,
                          "https://png.pngtree.com/png-clipart/20190516/original/pngtree-users-vector-icon-png-image_3725294.jpg"),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          widget.mModel.data.details.name,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
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
                    "**********",
                    style: TextStyle(fontWeight: FontWeight.w500),
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
                    widget.mModel.data.details.address,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Divider()
              ],
            )));
  }
}
