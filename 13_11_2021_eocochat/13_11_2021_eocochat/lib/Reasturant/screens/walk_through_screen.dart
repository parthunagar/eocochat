import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/components/walk_through_container1.dart';
import 'package:fiberchat/Reasturant/components/walk_through_container2.dart';
import 'package:fiberchat/Reasturant/components/walk_through_container3.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/screens/sign_in_screen.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;

  List<Widget> data = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    data.add(WalkThroughContainer1());
    data.add(WalkThroughContainer2());
    data.add(WalkThroughContainer3());
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height(),
        width: context.width(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                currentPageIndex = index;
                setState(() {});
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return WalkThroughContainer1();
                } else if (index == 1) {
                  return WalkThroughContainer2();
                } else {
                  return WalkThroughContainer3();
                }
              },
            ),
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DotIndicator(
                      pages: data,
                      pageController: pageController,
                      indicatorColor: context.iconColor,
                      unselectedIndicatorColor: context.iconColor.withOpacity(0.5),
                    ),
                  ),
                  AnimatedCrossFade(
                    sizeCurve: Curves.bounceOut,
                    crossFadeState: currentPageIndex == 2 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 550),
                    firstChild: Container(
                      height: 50,
                      width: 50,
                      decoration: boxDecorationDefault(color: primaryColor, boxShadow: defaultBoxShadow(blurRadius: 0, spreadRadius: 0)),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ).onTap(() async {
                      pageController.nextPage(duration: Duration(milliseconds: 550), curve: Curves.decelerate);
                    }, borderRadius: radius()),
                    secondChild: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: boxDecorationDefault(color: primaryColor, boxShadow: defaultBoxShadow(blurRadius: 0, spreadRadius: 0)),
                      child: Text(language.lblGetStarted, style: boldTextStyle(color: Colors.white)).center(),
                    ).onTap(() {
                      setValue(SharePreferencesKey.IS_WALKED_THROUGH, true);
                      SignInScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds);
                    }, borderRadius: radius()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
