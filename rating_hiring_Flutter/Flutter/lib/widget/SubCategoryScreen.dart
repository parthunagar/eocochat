import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/config/app_config.dart' as config;

class SubCategoryWidget extends StatelessWidget {
  final Map item;

  SubCategoryWidget(this.item);

  Widget _acutionList(BuildContext context) {
    return Container(
      width: config.App(context).appWidth(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all( Radius.circular(10.0)),
              child: Image.network(item["icon"],
                fit: BoxFit.fill,
                width:config.App(context).appWidth(28),
                height: 100,)),

          Text(
            item["name"],
            style: TextStyle(
                color: config.Colors().white,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _acutionList(context),
      width: config.App(context).appWidth(35),
    );
  }
}
