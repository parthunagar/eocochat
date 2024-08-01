import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/components/veg_component.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/models/restaurant_model.dart';
import 'package:fiberchat/Reasturant/screens/res_detail_screen.dart';
import 'package:fiberchat/Reasturant/services/category_service.dart';
import 'package:fiberchat/Reasturant/services/menu_service.dart';
import 'package:fiberchat/Reasturant/utils/cached_network_image.dart';
import 'package:fiberchat/Reasturant/utils/common.dart';

class RestaurantCardComponent extends StatelessWidget {
  final RestaurantModel data;

  RestaurantCardComponent({required this.data});

  Widget checkRestaurantType({required bool isVeg, required bool isNonVeg}) {
    double size = 20;
    if (isNonVeg && isVeg) {
      return Row(
        children: [VegComponent(size: size), 8.width, NonVegComponent(size: size)],
      );
    } else if (isVeg) {
      return VegComponent(size: size);
    } else if (isNonVeg) {
      return NonVegComponent(size: size);
    } else {
      return Offstage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          data.image!.isNotEmpty
              ? cachedImage(
                  data.image.validate(value: "https://image.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg"),
                  height: 250,
                  width: context.width(),
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(defaultRadius)
              : cachedImage(
                  '',
                  height: 250,
                  width: context.width(),
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(defaultRadius),
          Container(
            decoration: blackBoxDecoration(),
            padding: EdgeInsets.all(16),
            width: context.width(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    cachedImage(data.logoImage.validate(), height: 45, width: 45, fit: BoxFit.cover).cornerRadiusWithClipRRect(80),
                    16.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.name}', style: boldTextStyle(size: 20, color: Colors.white)),
                        4.height,
                        if (data.description.isEmptyOrNull) Text('${data.description}', style: secondaryTextStyle(color: Colors.white70, size: 14)),
                      ],
                    ).expand(),
                  ],
                ),
                16.height,
                Row(
                  children: [
                    StreamBuilder(
                      stream: CategoryService.getTotalCategories(restaurantId: data.uid),
                      builder: (_, snap) {
                        if (snap.hasData) {
                          return Column(
                            children: [
                              Text('${snap.data.toString()}', style: boldTextStyle(color: Colors.white, size: 20)),
                              // Text(language.lblCategories, style: primaryTextStyle(size: 16, color: Colors.white)),
                              Text(getTranslated(context, 'lblCategories'), style: primaryTextStyle(size: 16, color: Colors.white)),
                            ],
                          );
                        }
                        return snapWidgetHelper(snap, loadingWidget: Offstage());
                      },
                    ).expand(),
                    StreamBuilder(
                      stream: MenuService.getTotalMenus(restaurantId: data.uid),
                      builder: (_, snap) {
                        if (snap.hasData) {
                          return Column(
                            children: [
                              Text('${snap.data.toString()}', style: boldTextStyle(color: Colors.white, size: 20)),
                              // Text(language.lblFoodItems, style: primaryTextStyle(size: 16, color: Colors.white)),
                              Text(getTranslated(context, 'lblFoodItems'), style: primaryTextStyle(size: 16, color: Colors.white)),
                            ],
                          );
                        }
                        return snapWidgetHelper(snap, loadingWidget: Offstage());
                      },
                    ).expand(),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: radius(8), color: context.cardColor),
              child: checkRestaurantType(isVeg: data.isVeg.validate(), isNonVeg: data.isNonVeg.validate()),
            )),
        ],
      ),
    ).onTap(() {
      print(' ====> ON CLICK RESTAURANT DETAILS <=== ');
      // push(ResDetailScreen(data: data), pageRouteAnimation: PageRouteAnimation.Slide);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResDetailScreen(data: data)));
    }, borderRadius: radius(defaultRadius));
  }
}
