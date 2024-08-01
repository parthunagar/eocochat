import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/WishListBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/WishListEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/model/wishlist/WishList.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/WishListState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/EmptyWidget.dart';
import 'package:rentors/widget/FeatureWidget.dart';
import 'package:rentors/widget/LikeWidget.dart';
import 'package:rentors/widget/NetworkErrorWidget.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';

class WishListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WishListScreenState();
  }
}

class WishListScreenState extends RentorState<WishListScreen> {
  WishListBloc mBloc;

  WishList data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mBloc = WishListBloc();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });
  }

  void openDetails(BuildContext context, WishItem products) async {
    var map = Map();
    map["id"] = products.id;
    map["name"] = products.details.productName;
    Navigator.of(context).pushNamed("/product_details", arguments: map);
  }

  Widget cardView(WishItem product) {
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
                        child: OptimizedCacheImage(
                            placeholder: (context, url) {
                              return PlaceHolderWidget();
                            },
                            fit: BoxFit.cover,
                            height: 130,
                            imageUrl: product.details.images),
                      ),
                      FeatureWidget(
                        product.isFeatured,
                        radius: 0,
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                product.name,
                                style: TextStyle(fontSize: 20),
                              ),
                              padding: EdgeInsets.only(
                                left: 10, right: 10,),
                            ),

                            Container(
                              child: LikeWidget(
                                  product.id,"1"),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                            )
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
            body: BlocProvider(
                create: (BuildContext context) => WishListBloc(),
                child: BlocBuilder<WishListBloc, BaseState>(
                    bloc: mBloc,
                    builder: (BuildContext context, BaseState state) {
                      if (state is ErrorState) {
                        return NetworkWidget();
                      } else if (state is LoadingState && data == null) {
                        return ProgressIndicatorWidget();
                      } else if (state is WishListState) {
                        data = state.home;
                      }
                      if (data.data.isEmpty) {
                        return EmptyWidget();
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return cardView(data.data[index]);
                        },
                        itemCount: data.data.length,
                      );
                    })),
            appBar: AppBar(
              title: Text(S.of(context).wishlist),
            )));
  }

  @override
  void update() {
    mBloc.add(WishListEvent());
  }
}
