import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/generated/assets.dart';
import 'package:fiberchat/widgets/ProgressBar/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/components/add_new_componentItem.dart';
import 'package:fiberchat/Reasturant/components/no_data_component.dart';
import 'package:fiberchat/Reasturant/components/resturant_card_component.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/models/restaurant_model.dart';
import 'package:fiberchat/Reasturant/screens/ScanAndRedirect/Scan_redirectToBrowser.dart';
import 'package:fiberchat/Reasturant/screens/add_restaurant_screen.dart';
import 'package:fiberchat/Reasturant/screens/setting_screen.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

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

  var userId,userName;

  getPrefData() async {
    await SharedPreferences.getInstance().then((value) {
      SharedPreferences val = value;
      print('getPrefData USER ID : ${val.getString(Dbkeys.sharedPrefUserId).toString()}');
      // setState(() {
        userId = val.getString(Dbkeys.sharedPrefUserId).toString();
      // });

    }).onError((e, stackTrace) {
      print('SharedPreferences.getInstance() ERROR : $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: eocochatYellow,
      appBar: appBarWidget(
          // "${language.lblHello}, ${appStore.userFullName}"
          '${getTranslated(context, 'lblRestaurant')}',
          // showBack: false,
          // color: context.scaffoldBackgroundColor
          color: eocochatYellow,
          elevation: 0,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     // push(SettingScreen(), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds);
            //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen());
            //     print(' ======> ON CLICK RESTAURANT SCREEN <====== ');
            //     SettingScreen().launch(context);
            //   },
            //   icon: Icon(Icons.settings, color: context.iconColor),
            // ),
          ]),
      // appBar: AppBar(
      //   backgroundColor: eocochatYellow,
      //   title: Text('${getTranslated(context, 'lblRestaurant')}')),
      body: FutureBuilder(
        future: getPrefData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting ){
            return Center(child: CustomProgressBar());
          }
          else{
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    16.height,
                    Row(
                      children: [
                        StreamBuilder(
                          stream: restaurantOwnerService.getLength(userId),
                          builder: (_, snap) {
                            if (snap.hasData) {
                              print('snap.hasData : ${snap.hasData}');
                              // return Text('${language.lblMyItems} (${snap.data.toString()})', style: boldTextStyle(size: 18));
                              return Text('${getTranslated(context, 'lblMyItems')} (${snap.data.toString()})', style: boldTextStyle(size: 18));
                            }
                            return snapWidgetHelper(snap, loadingWidget: Offstage());
                          },
                        ).expand(),
                        AddNewComponentItem(
                          onTap: () {
                            print('userId : $userId');
                            print(' ====> ON CLICK ADD NEW RESTAURANT <=== ');
                            // push(AddRestaurantScreen(userId: getStringAsync(SharePreferencesKey.USER_ID)));
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRestaurantScreen(userId: userId)));
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
                        width: w * 0.85,
                        padding: EdgeInsets.only(top: h * 0.025),
                        decoration: BoxDecoration(
                          color: eocochatWhite,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 7),
                          decoration: BoxDecoration(
                            color: eocochatYellow,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${getTranslated(context, 'lblClickHere')}',style: boldTextStyle(size: 15)),
                              SizedBox(width: 5),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       border: Border.all(color: Colors.white),
                              //       borderRadius: BorderRadius.circular(10)
                              //   ),
                              //     // child: Icon(Icons.qr_code_scanner,size: 70)),
                              //     child:  SvgPicture.asset('assets/images/qr_code_withoutbg.svg',height: h *0.1,),),
                              Container(
                                decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  //   border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                // child: Icon(Icons.qr_code_scanner,size: 70)),
                                child:  Image.asset(Assets.scanCircleImage,height: h *0.1,fit: BoxFit.fill,),),
                              SizedBox(width: 5),
                              Text('${getTranslated(context, 'lblForScanner')}',style: boldTextStyle(size: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    16.height,
                    // Container(
                    //   width: w * 0.65,
                    //   padding: EdgeInsets.symmetric(horizontal: w *0.07,vertical: h *0.01),
                    //   decoration: BoxDecoration(
                    //       color: eocochatWhite,
                    //       // border: Border.all(color: Colors.white),
                    //       borderRadius: BorderRadius.circular(40)
                    //   ),
                    //   child: Text(getTranslated(context, 'lblAddYourBusinessOrServicehere'),style: boldTextStyle(size: 15),textAlign: TextAlign.center,),
                    // ),
                    // 5.height,

                    StreamBuilder<List<RestaurantModel>>(
                      stream: restaurantOwnerService.getRestaurantData(userId),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          print('snap.hasData : ${snap.hasData}');
                          if (snap.data!.length <= 0) {
                            return NoRestaurantComponent(
                              // errorName: "${language.lblNoRestaurant}",
                                errorName:  getTranslated(context, 'lblNoRestaurant')
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
            );
          }
        }
      ),
    );
  }
}
