import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/bloc/SubscriptionBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/SubscriptionListEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/FeatureSubscriptionList.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/SubscriptionListState.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorGradient.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:rentors/HexColor.dart';
class SubScriptionListScreen extends StatefulWidget {
  Function callback;
  @override
  State<StatefulWidget> createState() {
    return SubScriptionListScreenState();
  }
  SubScriptionListScreen({this.callback});
}

class SubScriptionListScreenState extends RentorState<SubScriptionListScreen> {
  SubscriptionBloc mBloc;
  String selectedPackage = 'Basic';
  Feature selectedPackageF;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mBloc = SubscriptionBloc();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });
  }

  Widget cardView(Feature item) {
    // print('ColorCode===>${item.color}');
    return  InkWell(
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(10)),
              color:config.Colors().secondColor,
              border:
              Border.all(color: config.Colors().mainDarkColor)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    margin:
                    EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              color: config.Colors().white),
                        ),
                        Text(
                          '${item.price} for ${item.period}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              color: config.Colors().white),
                        ),
                      ],
                    )),
                flex: 1,
              ),
              Icon(
                selectedPackageF.id==item.id
                    ? CupertinoIcons.check_mark_circled
                    : CupertinoIcons.circle,
                size: 25,
                color: selectedPackageF.id==item.id
                    ? config.Colors().mainDarkColor
                    : config.Colors().white,
              ),
              SizedBox(
                width: 10,
              )
            ],
          )),
      onTap: () {
        setState(() {
          selectedPackageF=item;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: InheritedStateContainer(
          state: this,
          child: Scaffold(
               body: BlocProvider(
                  create: (BuildContext context) => SubscriptionBloc(),
                  child: BlocBuilder<SubscriptionBloc, BaseState>(
                      bloc: mBloc,
                      builder: (BuildContext context, BaseState state) {
                        if (state is SubscriptionListState) {
                          if(selectedPackageF==null)
                          selectedPackageF=state.subscriptionList.subscriptionData[0];
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Enjoy the benefits of Joining RentorPlus Premium.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25, color: config.Colors().secondColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: config.Colors().orangeColor,
                                  ),
                                  title: Text(
                                    'Unlock Premium Discounts From RentorPlus',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12, color: config.Colors().secondColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.camera_enhance_outlined,
                                    size: 20,
                                    color: config.Colors().orangeColor,
                                  ),
                                  title: Text(
                                    'Free Insurance For Rentals Included*',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12, color: config.Colors().secondColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.account_box_outlined,
                                    size: 20,
                                    color: config.Colors().orangeColor,
                                  ),
                                  title: Text(
                                    'Premium Customer Support (24/7)',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12, color: config.Colors().secondColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.block,
                                    size: 20,
                                    color: config.Colors().orangeColor,
                                  ),
                                  title: Text(
                                    'No Ads While Browsing',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12, color: config.Colors().secondColor),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Compare Plans',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, color: config.Colors().secondColor),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    return cardView(state.subscriptionList.subscriptionData[index]);
                                  },
                                  itemCount: state.subscriptionList.subscriptionData.length,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                                  child: RentorRaisedButton(
                                    child: Text(
                                      'Get Premium Now',
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      var map = Map();
                                      map["feat"] = selectedPackageF;
                                      map["prod"] = null;
                                      Navigator.of(context)
                                          .popAndPushNamed("/payment_method",
                                          arguments: map)
                                          .then((value) {
                                        RentorState.of(context).update();
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                      width: config.App(context).appWidth(100),
                                      alignment: AlignmentDirectional.center,
                                      padding: EdgeInsets.all(5),
                                      margin:
                                      EdgeInsets.only(left: 10, right: 10, bottom: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          border: Border.all(color: config.Colors().secondColor)),
                                      child: Text(
                                        'Continue without Subscription',
                                        style: TextStyle(color: config.Colors().secondColor, fontSize: 18),
                                      )),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    if(widget.callback!=null){
                                      widget.callback.call();
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        } else {
                          return ProgressIndicatorWidget();
                        }
                      })),
              appBar: AppBar(
                elevation: 0,
                title: Text(S.of(context).subscription),
              ))),
    );
  }

  @override
  void update() {
    mBloc.add(SubscriptionListEvent());
  }
}
