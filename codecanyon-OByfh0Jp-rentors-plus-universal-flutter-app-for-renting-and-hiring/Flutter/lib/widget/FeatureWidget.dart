import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class FeatureWidget extends StatelessWidget {
  final String feature;

  final double fontSize;

  final double radius;

  FeatureWidget(this.feature, {this.fontSize = 16, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: feature == "1",
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Shimmer(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    config.Colors().colorFFA200,
                    config.Colors().colorFFA200,
                    Colors.white70,
                    config.Colors().colorFFA200,
                    config.Colors().colorFFA200
                  ],
                  stops: const <double>[
                    0.0,
                    0.35,
                    0.5,
                    0.65,
                    1.0
                  ]),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: config.Colors().colorFFA200,
                      offset: Offset(0, 0),
                    ),
                  ],
                  color: config.Colors().colorFFA200,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: radius != 0 ? Radius.circular(radius) : Radius.zero,
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Text(
                  S.of(context).featured,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: radius != 0 ? Radius.circular(radius) : Radius.zero,
                ),
              ),
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(
                S.of(context).featured,
                style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
