import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/CategoryListBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/CategoryDetailEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/category/CategoryDetailModel.dart' as category;
import 'package:rentors/model/category/ConsolidateCategoryDetail.dart';
import 'package:rentors/model/home/Separator.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CategoryDetailState.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';
import 'package:rentors/widget/ProductViewWidget.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/SeparatorWidget.dart';
import 'package:rentors/widget/StartRentingItemWidget.dart';
import 'package:rentors/widget/SubCategoryScreen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String id;

  CategoryDetailsScreen(this.id);

  @override
  State<StatefulWidget> createState() {
    return CategoryDetailsScreenState();
  }
}

class CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  CategoryListBloc mBloc = new CategoryListBloc();

  var _current = 0;
var slider;
  @override
  void initState() {
    super.initState();
    _current = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mBloc.add(CategoryDetailEvent(widget.id));
    });
  }

  Widget productList(ConsolidateCategoryDetail detail) {
    return ListView.builder(
      itemCount: detail.products.length + 1,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return subCategory(detail.subCategory);
        } else {
          int index = i - 1;
          var item = detail.products[index];
          if (item is Separator) {
            return SeparatorWidget(
              item.category,
              color: config.Colors().white,
            );
          } else {
            return productView(item);
          }
        }
      },
    );
  }

  Widget productView(category.Product subCategory) {
    return Container(
      color: config.Colors().white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: config.Colors().white,
            height: config.App(context).appHeight(25),
            child: ListView.builder(
                itemCount: subCategory.subcategoryProducts.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctxt, int index) {
                  return ProductViewWidget(
                      subCategory.subcategoryProducts[index]);
                }),
          )
        ],
      ),
    );
  }

  Widget subCategory(List<category.SubCategory> detail) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: config.App(context).appHeight(20),
        color: config.Colors().mainDarkColor,
        child: ListView.builder(
            itemCount: detail.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext ctxt, int index) {
              var map = Map<String, dynamic>();
              map["icon"] = detail[index].subcategoryIcon;
              map["name"] = detail[index].name;
              map["id"] = detail[index].id;
              return InkWell(
                  onTap: () {
                    detail[index].sliderImage=slider;
                    Navigator.of(context).pushNamed("/subcategory_detail",
                        arguments: detail[index]);
                  },
                  child: SubCategoryWidget(map));
            }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          centerTitle: true,
          backgroundColor: config.Colors().mainDarkColor,
          title: Text(
            'Category Details',
            style: TextStyle(color: config.Colors().white,fontWeight: FontWeight.w800),
          ),
          actions: [
            Container(
              width: 38,
              child: IconButton(onPressed: (){
                Navigator.of(context).pushNamed("/filter");
              }, icon: Image.asset('assets/img/filter.png',color: config.Colors().white,)),
            ),
            Container(
              width: 30,
              margin: EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){
                Navigator.of(context).pushNamed("/notification");
              }, icon: Icon(Icons.notifications_active_outlined,color: config.Colors().white,)),
            ),
          ],
          iconTheme: IconThemeData(color: config.Colors().white),
        ),
        body: BlocProvider(
            create: (BuildContext context) => CategoryListBloc(),
            child: BlocBuilder<CategoryListBloc, BaseState>(
                bloc: mBloc,
                builder: (BuildContext context, BaseState state) {
                  if (state is CategoryDetailState) {
                    var detail = state.categoryList;
                    slider=detail.sliderImage;
                    return SafeArea(child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                              itemCount: detail.sliderImage.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: config.App(context).appWidth(100),
                                  child: OptimizedCacheImage(
                                    placeholder: (context, url) {
                                      return PlaceHolderWidget();
                                    },
                                    fit: BoxFit.fill,
                                    imageUrl: detail.sliderImage[index].image,
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 4 / 2,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  })),

                          productList(detail),
                          StartRentingItemWidget()
                        ],
                      ),
                    ));
                  } else {
                    return ProgressIndicatorWidget();
                  }
                })));
  }
}
