import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:qr_menu/utils/colors.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel? categoryData;
  final bool? isSelected;

  CategoryWidget({this.categoryData, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: radius(defaultRadius),
        color: isSelected!
            ? appStore.isDarkMode
                ? Colors.white24
                : primaryColor.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: Column(
        children: [
          Container(
            height: 66,
            width: 66,
            decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: !categoryData!.image.isEmptyOrNull ? cachedImage(categoryData!.image, fit: BoxFit.cover) : Text(categoryData!.name.validate()[0].toUpperCase(), style: boldTextStyle(size: 24)).center(),
            ),
          ),
          Marquee(
            directionMarguee: DirectionMarguee.oneDirection,
            child: Text(
              '${categoryData!.name}',
              style: boldTextStyle(size: 14),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).paddingSymmetric(horizontal: 8, vertical: 8),
          )
        ],
      ),
    );
  }
}
