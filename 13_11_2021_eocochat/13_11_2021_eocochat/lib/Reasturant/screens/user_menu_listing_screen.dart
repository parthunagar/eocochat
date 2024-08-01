import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/components/res_menu_list.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/screens/user_setting_screen.dart';
import 'package:fiberchat/Reasturant/services/category_service.dart';
import 'package:fiberchat/Reasturant/services/menu_service.dart';
import 'package:fiberchat/Reasturant/utils/cached_network_image.dart';

class UserMenuListingScreen extends StatefulWidget {
  final String? id;

  UserMenuListingScreen({this.id});

  @override
  _UserMenuListingScreenState createState() => _UserMenuListingScreenState();
}

class _UserMenuListingScreenState extends State<UserMenuListingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    appStore.setLoading(true);
    menuService = MenuService(restaurantId: widget.id.validate());
    categoryService = CategoryService(restaurantId: widget.id.validate());
    await restaurantOwnerService.getRestaurantFutureData(widget.id.validate()).then((value) {
      selectedRestaurant = value;
    }).catchError(
      (e) {
        log(e.toString());
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('${selectedRestaurant.name.validate()}',
          color: context.scaffoldBackgroundColor,
          actions: [
            IconButton(
              onPressed: () {
                push(UserSettingScreen(), pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
              },
              icon: Icon(Icons.settings, color: context.iconColor),
            ),
          ],
          backWidget: cachedImage(
            '${selectedRestaurant.logoImage.validate()}',
            width: 50,
            height: 50,
          ).paddingAll(8)),
      body: ResMenuList(isAdmin: false),
    );
  }
}

// J4a7yVEPRwFmxWu3zRoX
