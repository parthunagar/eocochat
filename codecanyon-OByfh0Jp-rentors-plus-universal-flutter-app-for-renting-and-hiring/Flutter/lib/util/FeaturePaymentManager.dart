import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentors/bloc/FeatureBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/FeatureSubscriptionListEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/FeatureSubscriptionList.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/FeatureSubcriptionListState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/widget/CircularImageWidget.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';

class FeaturePaymentManager {
  FeatureBloc featureBloc;
  BuildContext context;

  ProgressDialog dialog;
  String name;
  String image;
  String productId;

  FeaturePaymentManager(this.context, this.name, this.image, this.productId) {
    featureBloc = FeatureBloc();
    featureBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.show();
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state is FeatureSubscriptionListState) {
          featureListData.clear();
          featureListData.addAll(state.result.data);
          showFeatureListDialog(featureListData);
        } else if (state is ErrorState) {
          Fluttertoast.showToast(msg: state.home);
        }
      }
    });
  }

  void requestBloc() {
    featureBloc.add(FeatureSubscriptionListEvent());
  }

  Feature selectedFeature;
  List<Feature> featureListData = List();

  Widget featureCard(Feature data, setState) {
    return InkWell(
        onTap: () {
          setState(() {
            if (selectedFeature != null) {
              int index = featureListData.indexOf(selectedFeature);
              featureListData[index] = featureListData[index].markUnSelected;
            }
            selectedFeature = data.markSelected;
            int index = featureListData.indexOf(selectedFeature);
            featureListData[index] = featureListData[index].markSelected;
            var temp = List<Feature>();
            temp.addAll(featureListData);
            featureListData.clear();
            featureListData.addAll(temp);
          });
        },
        child: Container(
          width: config.App(context).appWidth(40),
          child: Card(
              elevation: 5,
              shape: data.isSelected
                  ? new RoundedRectangleBorder(
                      side: new BorderSide(
                          color: config.Colors().orangeColor, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0))
                  : new RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0)),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                          fontSize: 15,
                          color: data.isSelected
                              ? config.Colors().orangeColor
                              : Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        S.of(context).forr(data.period),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w200),
                      ),
                    ),
                    Text(
                      data.currencyType + " " + data.price,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),
        ));
  }

  showFeatureListDialog(featureListData) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(S.of(context).addToFeature),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: CircularImageWidget(60, image)),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Text(
                      S
                          .of(context)
                          .showcaseYourProductInTopFeaturedListBySelectingAnyone,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    height: config.App(context).appHeight(15),
                    width: config.App(context).appWidth(90),
                    child: ListView.builder(
                        itemCount: featureListData.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return featureCard(featureListData[index], setState);
                        }),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    child: RentorRaisedButton(
                      onPressed: () {
                        gotoPaymentMethod();
                      },
                      child: Text(
                        S.of(context).continuee,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  void gotoPaymentMethod() {
    if (selectedFeature == null) {
      Fluttertoast.showToast(msg: S.of(context).pleaseSelectAnyFeature);
      return;
    }
    var map = Map();
    map["feat"] = selectedFeature;
    map["prod"] = productId;
    Navigator.of(context)
        .popAndPushNamed("/payment_method", arguments: map)
        .then((value) {
      RentorState.of(context).update();
    });
  }
}
