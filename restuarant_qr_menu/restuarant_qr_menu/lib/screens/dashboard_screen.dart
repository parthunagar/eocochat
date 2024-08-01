import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/add_new_componentItem.dart';
import 'package:qr_menu/components/no_data_component.dart';
import 'package:qr_menu/components/resturant_card_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/screens/ScanAndRedirect/Scan_redirectToBrowser.dart';
import 'package:qr_menu/screens/add_restaurant_screen.dart';
import 'package:qr_menu/screens/setting_screen.dart';
import 'package:qr_menu/utils/constants.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      setStatusBarColor(context.scaffoldBackgroundColor);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: appBarWidget("${language.lblHello}, ${appStore.userFullName}",
            showBack: false,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  push(SettingScreen(), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds);
                },
                icon: Icon(Icons.settings, color: context.iconColor),
              ),
            ],
            color: context.scaffoldBackgroundColor),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                16.height,
                Row(
                  children: [
                    StreamBuilder(
                      stream: restaurantOwnerService.getLength(),
                      builder: (_, snap) {
                        if (snap.hasData) {
                          return Text('${language.lblMyItems} (${snap.data.toString()})', style: boldTextStyle(size: 18));
                        }
                        return snapWidgetHelper(snap, loadingWidget: Offstage());
                      },
                    ).expand(),
                    AddNewComponentItem(
                      onTap: () {
                        push(AddRestaurantScreen(userId: getStringAsync(SharePreferencesKey.USER_ID)));
                      },
                    )
                  ],
                ),
                16.height,
                //TODO: Scan Code Screen make design of screen.
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanAndOpenBrowserScreen()));
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Click here',style: boldTextStyle(size: 15)),
                        SizedBox(width: 5),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.qr_code_scanner,size: 70)),
                        SizedBox(width: 5),
                        Text('for scanner',style: boldTextStyle(size: 15)),
                      ],
                    ),
                  ),
                ),
                16.height,

                StreamBuilder<List<RestaurantModel>>(
                  stream: restaurantOwnerService.getRestaurantData(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      if (snap.data!.length <= 0) {
                        return NoRestaurantComponent(
                          errorName: "${language.lblNoRestaurant}",
                        );
                      }
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 40),
                        itemCount: snap.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return RestaurantCardComponent(data: snap.data![index]).paddingSymmetric(vertical: 8);
                        },
                      );
                    } else {
                      return snapWidgetHelper(snap);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
