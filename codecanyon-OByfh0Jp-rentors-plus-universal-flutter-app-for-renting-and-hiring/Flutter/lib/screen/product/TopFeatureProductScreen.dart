import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/FeatureWidget.dart';
import 'package:rentors/widget/LikeWidget.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';

class TopFeatureProductScreen extends StatefulWidget {
  final List<FeaturedProductElement> featuredProducts;

  TopFeatureProductScreen(this.featuredProducts);

  @override
  State<StatefulWidget> createState() {
    return TopFeatureProductScreenState();
  }
}

class TopFeatureProductScreenState
    extends RentorState<TopFeatureProductScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });
  }

  void openDetails(
      BuildContext context, FeaturedProductElement products) async {
    var map = Map();
    map["id"] = products.id;
    map["name"] = products.name;
    Navigator.of(context).pushNamed("/product_details", arguments: map);
  }

  Widget cardView(FeaturedProductElement product) {
    return InkWell(
        onTap: () {
          openDetails(context, product);
        },
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: config.Colors().mainDarkColor)
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    color: config.Colors().white,
                    child:Stack(children: [
                      Center(
                        child: Image.network(
                          product.details.images,
                          fit: BoxFit.fitWidth,
                          height: 130,),
                      ),
                      FeatureWidget(
                        product.isFeatured,
                        radius: 0,
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: config.Colors().secondColor,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            product.details.description,
                            style: TextStyle(
                                fontSize: 16,
                                color: config.Colors().secondColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              S.of(context).rate(
                                  product.details.price +
                                      "/" +
                                      priceUnitValues.reverse[product
                                          .details
                                          .priceUnit]),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: config.Colors().secondColor,
                                  fontWeight: FontWeight.w400),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              S.of(context).minimumBookingAmount(
                                  product.details
                                      .minBookingAmount),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: config.Colors().secondColor,
                                  fontWeight: FontWeight.w400),
                            )),
                        Container(
                          alignment: AlignmentDirectional.topEnd,
                          margin: EdgeInsets.only(left: 5),
                          child: IconButton(
                            onPressed: () {
                              openDetails(context,product);
                            },
                            icon: Icon(Icons.arrow_forward_ios_outlined,color: config.Colors().mainDarkColor,),
                          ),
                        ),
                      ],
                    ),)
                ],
              ),

            ],
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return InheritedStateContainer(
        state: this,
        child: Scaffold(
          body: ListView.builder(
            itemBuilder: (context, index) {
              return cardView(widget.featuredProducts[index]);
            },
            itemCount: widget.featuredProducts.length,
          ),
          appBar: AppBar(
            title: Text(S.of(context).topFeatured),
          ),
        ));
  }

  @override
  void update() {

  }
}
