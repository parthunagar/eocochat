import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/HomeBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/HomeEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/home/Home.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/model/home/Separator.dart';
import 'package:rentors/model/home/TwoCategory.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/HomeState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/util/CommonConstant.dart';
import 'package:rentors/widget/CenterHorizontal.dart';
import 'package:rentors/widget/NetworkErrorWidget.dart';
import 'package:rentors/widget/ProductViewWidget.dart';
import 'package:rentors/widget/SeparatorWidget.dart';
import 'package:rentors/widget/StartRentingItemWidget.dart';

class HomeScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenWidgetState();
  }
}

class HomeScreenWidgetState extends RentorState<HomeScreenWidget> {
  HomeBloc mBloc = new HomeBloc();

  Home data;

  List<HomeSliderImage> homeSlider = List();

  @override
  void dispose() {
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });
    mBloc.listen((state) {
      if (state is HomeState) {

      }
    });
  }



  String subCategoryName(List<CategorySubCategory> subCategory) {
    StringBuffer buffer = StringBuffer();
    if (subCategory != null && subCategory.isNotEmpty) {
      for (int i = 0; i < subCategory.length; i++) {
        buffer.write(subCategory[i].name);
        if (i < subCategory.length - 1) {
          buffer.write(", ");
        }
        if (i == 1) {
          break;
        }
      }
    } else {
      buffer.write(" ");
    }

    if (buffer.length > 2) {
      return buffer.toString().substring(0, buffer.length - 2);
    } else {
      return buffer.toString();
    }
  }

  Widget singleCategory(Category mCategory) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed("/category_detail", arguments: mCategory.id);
      },
      child: Container(
        width: config.App(context).appWidth(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all( Radius.circular(10.0)),
                child: Image.network(mCategory.categoryIcon,
                  fit: BoxFit.fill,
                  width:config.App(context).appWidth(28),
                  height: 100,)),

            Text(
              mCategory.name,
              style: TextStyle(
                  color: config.Colors().white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget twoCategory(Category mCategory, Category two) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          singleCategory(mCategory),
          singleCategory(two),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InheritedStateContainer(
        state: this,
        child: BlocProvider(
            create: (BuildContext context) => HomeBloc(),
            child: BlocBuilder<HomeBloc, BaseState>(
                bloc: mBloc,
                builder: (BuildContext context, BaseState state) {
                  if (state is ErrorState) {
                    return NetworkWidget();
                  } else if (state is LoadingState && data == null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CenterHorizontal(CircularProgressIndicator())],
                    );
                  } else {
                    if (state is HomeState) {
                      data = (state).home;
                      homeSlider.clear();
                      if (data.homeSliderImage != null) {
                        homeSlider.addAll(data.homeSliderImage);
                      }
                    }
                    return RefreshIndicator(
                      displacement: 100.0,
                      color: config.Colors().orangeColor,
                      onRefresh: () async {
                        update();
                        await Future.delayed(Duration(seconds: 3));
                      },
                      child: CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Visibility(
                                visible: homeSlider.isNotEmpty,
                                child: CarouselSlider.builder(
                                    itemCount: homeSlider.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: config.App(context)
                                            .appWidth(90),
                                        child: ClipRRect(
                                          borderRadius:BorderRadius.all(Radius.circular(10)),
                                          child: OptimizedCacheImage(
                                            fit: BoxFit.fill,
                                            imageUrl:
                                            homeSlider[index].image,
                                          ),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                        enableInfiniteScroll: false,
                                        autoPlay: true,
                                        aspectRatio: 4 / 2,
                                        viewportFraction: 1.0,
                                        enlargeCenterPage: false,
                                        onPageChanged: (index, reason) {})),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed("/map_page");
                                },
                                child: Hero(
                                  tag: "home_screen_search_key",
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/img/search.svg",color: config.Colors().mainDarkColor),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                'Search by location',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: SvgPicture.asset(
                                                  "assets/img/location.svg",color: config.Colors().mainDarkColor,),
                                              alignment:
                                              AlignmentDirectional
                                                  .centerEnd,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: data.featuredProducts.isNotEmpty,
                                child: _topFeatured(data.featuredProducts),),
                              Visibility(
                                visible: data.near_by_search.isNotEmpty,
                                child:  _nearBuy(data.near_by_search),),
                              _categoryWidget(data.category),
                            ],
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                          var item = data.products[index];
                          if (item is Separator) {
                            return SeparatorWidget(
                              item.category,
                              color: config.Colors().scaffoldColor,
                            );
                          } else {
                            return productView(item);
                          }
                        }, childCount: data.products.length)),
                        SliverToBoxAdapter(
                          child: StartRentingItemWidget(),
                        )
                      ]),
                    );
                  }
                })));
  }

  Widget _topFeatured(List<FeaturedProductElement> featuredProducts) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  S.of(context).topFeatured,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: config.Colors().color545454),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed("/top_featured", arguments: featuredProducts);
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    S.of(context).viewAll,
                    style: TextStyle(
                        color: config.Colors().yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: config.App(context).appHeight(30),
            child: ListView.builder(
                itemCount: featuredProducts.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctxt, int index) {
                  return featureList(featuredProducts[index]);
                }),
          )
        ],
      ),
    );
  }
  Widget _nearBuy(List<FeaturedProductElement> featuredProducts) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  'Near By',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: config.Colors().color545454),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed("/top_featured", arguments: featuredProducts);
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    S.of(context).viewAll,
                    style: TextStyle(
                        color: config.Colors().yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: config.App(context).appHeight(30),
            child: ListView.builder(
                itemCount: featuredProducts.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctxt, int index) {
                  return featureList(featuredProducts[index]);
                }),
          )
        ],
      ),
    );
  }

  Widget featureList(FeaturedProductElement featuredProduct) {
    return InkWell(
        onTap: () {
          openDetails(context, featuredProduct);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            width: config.App(context).appWidth(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    child: Image.network(featuredProduct.details.images,height: 150, width: config.App(context).appWidth(40),)),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          width: config.App(context).appWidth(40),
                          child: Text(
                            featuredProduct.details.productName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              S.of(context).availableForStartingFrom,
                              maxLines: 1,
                              style: TextStyle(fontSize: 11),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(children: <Widget>[
                          Text(
                            S.of(context).dollar(featuredProduct.details.price +
                                "/" +
                                priceUnitValues.reverse[
                                    featuredProduct.details.priceUnit]),
                            style: TextStyle(
                                fontSize: 14,
                                color: config.Colors().color00A03E,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void openDetails(
      BuildContext context, FeaturedProductElement products) async {
    var map = Map();
    map["id"] = products.id;
    map["name"] = products.details.productName;
    Navigator.of(context).pushNamed("/product_details", arguments: map);
  }

  Widget _categoryWidget(List<dynamic> category) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  S.of(context).categories,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: config.Colors().color545454),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/category");
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    S.of(context).viewAll,
                    style: TextStyle(
                        color: config.Colors().yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: config.App(context).appHeight(20),
            color: config.Colors().mainDarkColor,
            child: ListView.builder(
                itemCount: category.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctxt, int index) {
                  if (category[index] is TwoCategoryCategory) {
                    TwoCategoryCategory two =
                        category[index] as TwoCategoryCategory;
                    return twoCategory(two.category, two.category2);
                  } else {
                    return singleCategory(category[index].category);
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget productView(SubCategory subCategory) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Text(
                  subCategory.subCategoryName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: config.Colors().color545454),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed("/allproduct", arguments: subCategory);
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    S.of(context).viewAll,
                    style: TextStyle(
                        color: config.Colors().yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: config.App(context).appHeight(30),
            child: ListView.builder(
                itemCount: subCategory.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctxt, int index) {
                  return ProductViewWidget(subCategory.products[index]);
                }),
          )
        ],
      ),
    );
  }

  @override
  void update() {
    mBloc.add(HomeEvent());
  }
}
