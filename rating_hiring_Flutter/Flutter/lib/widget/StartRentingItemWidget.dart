import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/widget/RentorRaisedButton.dart';

class StartRentingItemWidget extends StatelessWidget {
  StartRentingItemWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 15,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).startRentingYourItem,
                        style: TextStyle(
                            color: config.Colors().color545454, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          S
                              .of(context)
                              .instantOnlineQuoteFreeDoorstepInspectionSameDayPayment,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w200),
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 5),
                          child: RentorRaisedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed("/create_product");
                            },
                            child: Text(
                              S.of(context).getStarted,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    "assets/img/intro1.svg",
                    width: 150,
                    height: 150,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
