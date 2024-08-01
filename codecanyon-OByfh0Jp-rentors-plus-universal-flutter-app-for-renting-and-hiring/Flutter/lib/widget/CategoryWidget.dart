import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/model/home/HomeModel.dart';

class CategoryWidget extends StatelessWidget {
  final Category mCategory;

  CategoryWidget(this.mCategory);

  Widget _acutionList(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            color: config.Colors().orangeColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OptimizedCacheImage(
                  imageUrl: mCategory.categoryIcon,
                  width: 40,
                  height: 40,
                ),
                Text(
                  mCategory.name,
                  style: TextStyle(color: config.Colors().scaffoldColor),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _acutionList(context),
      width: config.App(context).appWidth(40),
    );
  }
}
