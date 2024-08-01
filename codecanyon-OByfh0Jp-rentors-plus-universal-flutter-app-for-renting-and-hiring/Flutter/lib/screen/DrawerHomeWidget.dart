import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/main.dart';
import 'package:rentors/screen/home/HomeScreenWidget.dart';
import 'package:rentors/widget/DrawerWidget.dart';
import 'package:rentors/config/app_config.dart' as config;
class DrawerHomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerHomeWidgetState();
  }
}

class DrawerHomeWidgetState extends State<DrawerHomeWidget> {
  ScrollController scrollController;
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  void _requestPermissions() {
    var _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission(provisional: true);
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      // _showNotification(receivedNotification);
    });
  }

  // Future<void> _showNotification(
  //     ReceivedNotification receivedNotification) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(CommonConstant.channedlId,
  //           CommonConstant.channedlId, CommonConstant.channedlId,
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(0, receivedNotification.title,
  //       receivedNotification.body, platformChannelSpecifics,
  //       payload: receivedNotification.payload);
  // }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      //Fluttertoast.showToast(msg: payload);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: config.Colors().white,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        centerTitle: true,
        backgroundColor: config.Colors().mainDarkColor,
        title: Text(
          S.of(context).rentHire,
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
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context)
              .primaryColor, //This will change the drawer background to blue.
          //other styles
        ),
        child: DrawerWidget(),
      ),
      body: SafeArea(child: HomeScreenWidget(),),
    );
  }
}
