import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/CategoryListBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/CategoryListEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/FeatureSubscriptionList.dart';
import 'package:rentors/model/UserDetail.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/model/productdetail/ProductDetailModel.dart';
import 'package:rentors/state/CategoryListState.dart';
import 'package:rentors/util/FeaturePaymentManager.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/CircularImageWidget.dart';
import 'package:rentors/widget/FeatureWidget.dart';
import 'package:rentors/widget/LikeWidget.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../SubscriptionListScreen.dart';

class ProductOverViewWidget extends StatefulWidget {
  final ProductDetailModel mModel;

  ProductOverViewWidget(this.mModel);

  @override
  State<StatefulWidget> createState() {
    return ProductOverViewWidgetState();
  }
}

class ProductOverViewWidgetState extends State<ProductOverViewWidget> {
  UserDetail model;
  bool isSubscribed = false;
  ProgressDialog dialog;
  List<Feature> featureListData = List();
  Feature selectedFeature;
  FeaturePaymentManager _featurePaymentManager;
  CategoryListBloc mCategoryBloc = CategoryListBloc();
  @override
  void initState() {
    super.initState();
    mCategoryBloc.add(CategoryListEvent());
    _featurePaymentManager = FeaturePaymentManager(
        context,
        widget.mModel.data.name,
        widget.mModel.data.details.images,
        widget.mModel.data.id);
    mCategoryBloc.listen((state) {
      if (state is CategoryListState) {
        if (state.checkuser != null) {
          isSubscribed = state.checkuser.isSubscribed;
        }
        if (state.userDetail != null) {
          model = state.userDetail as UserDetail;
        }
      }
    });
  }

  void gotoPaymentMethod() {
    if (selectedFeature == null) {
      Fluttertoast.showToast(msg: S.of(context).pleaseSelectAnyFeature);
      return;
    }
    var map = Map();
    map["feat"] = selectedFeature;
    map["prod"] = widget.mModel;
    Navigator.of(context)
        .popAndPushNamed("/payment_method", arguments: map)
        .then((value) {
      RentorState.of(context).update();
    });
  }

  Widget chatWithOwnerWidget() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Hero(
                tag: "chat_with_owner",
                child: OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/chat",
                        arguments: widget.mModel.data.userId);
                  },
                  child: Text(
                    S.of(context).chatWithOwner,
                    style: TextStyle(color: config.Colors().orangeColor),
                  ),
                  borderSide: BorderSide(color: config.Colors().orangeColor),
                  shape: StadiumBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: RentorRaisedButton(
                onPressed: () {
                  if (model.data.is_verified!="1") {
                    showConfirmDialog();
                  } else if (!isSubscribed) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SubScriptionListScreen(
                              callback: () {
                                Navigator.of(context).pushNamed("/book_product",
                                    arguments: widget.mModel);
                              },
                            )));
                  } else {
                    Navigator.of(context)
                        .pushNamed("/book_product", arguments: widget.mModel);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    S.of(context).bookNow,
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showConfirmDialog() {
    bool isVerify = model.data.email.length > 3 &&
        model.data.mobile.length > 3;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                insetPadding: EdgeInsets.all(10),
                backgroundColor: config.Colors().mainDarkColor,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: config.Colors().white),
                  margin: EdgeInsets.all(2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(left: 5, top: 5),
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.clear,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                          Center(
                              child: Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 5),
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Confirmation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: config.Colors().accentDarkColor),
                            ),
                          ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        alignment: Alignment.topCenter,
                        child: Text(
                          isVerify?'Please wait till your profile is approved':'Please complete your profile to add/book products on Rentors Plus.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: config.Colors().accentDarkColor),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        child: RentorRaisedButton(
                          onPressed: () {
                            if(isVerify){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }else{
                              Navigator.of(context).pushNamed("/profile");
                            }

                          },
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          });
        });
  }

  bool isActive(ProductDetailModel product) {
    return product.data.isApproved == "1" && product.data.status == "1";
  }

  Widget addToFeature(ProductDetailModel product) {
    Color containerColor = isActive(product)
        ? config.Colors().colorF25633
        : config.Colors().colorEBEBEB;
    Color textColor = isActive(product)
        ? config.Colors().white
        : config.Colors().statusGrayColor;
    return InkWell(
      onTap: () {
        if (isActive(product)) {
          _featurePaymentManager.requestBloc();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 16,
                  color: textColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  S.of(context).addToFeature,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isMyProduct(UserModel data) {
    return data.data.id == widget.mModel.data.userId;
  }

  void updateFeatureData(Feature data) {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: Utils.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: PageTransitionSwitcher(
                      duration: const Duration(milliseconds: 3000),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          child: child,
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                        );
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Hero(
                                    tag: widget.mModel.data.id,
                                    child: AspectRatio(
                                      aspectRatio: 1.7,
                                      child: OptimizedCacheImage(
                                          placeholder: (context, url) {
                                            return PlaceHolderWidget();
                                          },
                                          fit: BoxFit.fill,
                                          imageUrl: Utils.getImageUrl(widget
                                              .mModel.data.details.images)),
                                    ),
                                  ),
                                  Hero(
                                    tag: widget.mModel.data.id + "_feature",
                                    child: FeatureWidget(
                                      widget.mModel.data.isFeatured,
                                      fontSize: 16,
                                      radius: 0,
                                    ),
                                  )
                                ],
                              ),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            widget.mModel.data.details.productName,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                        ),
                                        Container(
                                          child: LikeWidget(
                                              widget.mModel.data.id,
                                              widget.mModel.data.isLike),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 110,
                                          alignment: AlignmentDirectional.center,
                                          margin: EdgeInsets.only(top: 10,left: 5,bottom: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              border: Border.all(color: config.Colors().mainDarkColor)
                                          ),
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Icon(Icons.location_on_rounded,color: config.Colors().mainDarkColor,size: 15,),
                                                SizedBox(width: 5,),
                                                Text('View On Map',style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10
                                                ),)
                                              ],
                                            ),
                                            onTap: ()=>_launchMapsUrl(widget.mModel.data.lat, widget.mModel.data.lng),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(' ${double.parse(widget.mModel.data.distance).round()} Miles Away',style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10
                                        ),),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            SmoothStarRating(
                                                allowHalfRating: false,
                                                onRated: (v) {},
                                                starCount: 5,
                                                rating: double.parse(widget
                                                    .mModel.data.avgRatting),
                                                size: 20.0,
                                                isReadOnly: true,
                                                color:
                                                    config.Colors().orangeColor,
                                                borderColor:
                                                    config.Colors().orangeColor,
                                                spacing: 0.0),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(S.of(context).basedOn),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              S.of(context).reviews(widget
                                                  .mModel
                                                  .data
                                                  .reviewdata
                                                  .length),
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(widget
                                            .mModel.data.details.description)),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          S.of(context).rate(
                                              widget.mModel.data.details.price +
                                                  "/" +
                                                  priceUnitValues.reverse[widget
                                                      .mModel
                                                      .data
                                                      .details
                                                      .priceUnit]),
                                          style: TextStyle(fontSize: 16),
                                        )),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          S.of(context).minimumBookingAmount(
                                              widget.mModel.data.details
                                                  .minBookingAmount),
                                          style: TextStyle(fontSize: 14),
                                        )),
                                    isMyProduct(snapshot.data)
                                        ? addToFeature(widget.mModel)
                                        : chatWithOwnerWidget(),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            S.of(context).specifications,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey))),
                                      child: ListView.builder(
                                          primary: false,
                                          itemCount: widget.mModel.data.details
                                              .fileds.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return specificationList(widget
                                                .mModel
                                                .data
                                                .details
                                                .fileds[index]);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Customer Reviews',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                        ),
                                      ],
                                    ),

                                    ListTile(
                                      title: Row(
                                        children: [
                                          SmoothStarRating(
                                              allowHalfRating: false,
                                              onRated: (v) {},
                                              starCount: 5,
                                              rating: double.parse(widget
                                                  .mModel.data.avgRatting),
                                              size: 15.0,
                                              isReadOnly: true,
                                              color: config.Colors().orangeColor,
                                              borderColor: config.Colors().orangeColor,
                                              spacing: 0.0),
                                          SizedBox(width: 10,),
                                          Text(
                                            '${widget.mModel.data.avgRatting} out of 5',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800),
                                          )
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Total Reviews - ${widget.mModel.data.reviewdata.length}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      onTap: (){
                                        Navigator.pushNamed(context, "/review_list",arguments: widget.mModel.data.reviewdata);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )));
          } else {
            return ProgressIndicatorWidget();
          }
        });
  }
  void _launchMapsUrl(String lat, String lng) async {
    MapsLauncher.launchCoordinates(double.parse(lat),double.parse(lng));
  }
  Widget specificationList(Filed filed) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.grey, width: 1),
              right: BorderSide(color: Colors.grey, width: 1),
              bottom: BorderSide(color: Colors.grey, width: 1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey, width: 1),
                ),
                color: Colors.grey.shade200,
              ),
              child: Text(
                " ${filed.key}",
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Text(
              "  ${filed.value}",
              style: TextStyle(fontWeight: FontWeight.w800,fontSize: 15),
            ),
            flex: 2,
          )
        ],
      ),
    );
  }


}
