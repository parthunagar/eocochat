import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/repo/LoginRepo.dart';
import 'package:rentors/util/Utils.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerWidgetState();
  }
}

class DrawerWidgetState extends State<DrawerWidget> {
  Widget _drawerWidget([UserModel data]) {
    String imageUrl =
        data != null && data.data != null && data.data.profileImage != null
            ? data.data.profileImage
            : "";
    print(imageUrl);
    return SafeArea(
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Stack(
          children: [
            Image.asset(
              "assets/img/menu-bg.png",
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            elevation: 10,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.fill)),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              S.of(context).welcome,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/home.svg"),
                    title: Text(
                      S.of(context).home,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      // ...
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/category.svg"),
                    title: Text(S.of(context).categories,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/category");
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/wishlist.svg"),
                    title: Text(S.of(context).wishlist,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/wishlist");
                    },
                  ),
                  ListTile(
                    leading:
                        SvgPicture.asset("assets/img/drawer/rent_item.svg"),
                    title: Text(S.of(context).myProduct,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/myproduct");
                    },
                  ),
                  ListTile(
                    leading:
                        SvgPicture.asset("assets/img/drawer/post_request.svg"),
                    title: Text(S.of(context).booking,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/booking");
                    },
                  ),
                  // ListTile(
                  //   leading: SvgPicture.asset("assets/img/drawer/history.svg"),
                  //   title: Text(S.of(context).history,
                  //       style: TextStyle(
                  //           color: Colors.white, fontWeight: FontWeight.bold)),
                  //   onTap: () {
                  //     Navigator.of(context).popAndPushNamed("/ads_details");
                  //   },
                  // ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/account.svg"),
                    title: Text(S.of(context).yourAccount,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/profile");
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/noti.svg"),
                    title: Text(S.of(context).notification,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/notification");
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/chat.svg"),
                    title: Text(S.of(context).chat,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/conversation");
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/settings.svg"),
                    title: Text(S.of(context).settings,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/settings");
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/help.svg"),
                    title: Text(S.of(context).subscription,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed("/subscription");
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset("assets/img/drawer/logout.svg"),
                    title: Text(S.of(context).logOut,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      openLogout();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ScrollController scrollController;
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  void openLogout() {
    Widget cancelButton = FlatButton(
      child: Text(
        S.of(context).cancel,
        style: TextStyle(
          color: config.Colors().orangeColor,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(S.of(context).yes,
          style: TextStyle(
            color: config.Colors().orangeColor,
          )),
      onPressed: () {
        sessionExpired.value = true;
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(S.of(context).areYouSureYouWantToLogout),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: Utils.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _drawerWidget(snapshot.data);
        } else {
          return _drawerWidget();
        }
      },
    );
  }
}
