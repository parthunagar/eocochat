import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/screens/add_category_screen.dart';
import 'package:qr_menu/utils/cached_network_image.dart';

class MenuListCategoryComponent extends StatelessWidget {
  final CategoryModel categoryData;
  final bool isAdmin;

  MenuListCategoryComponent({required this.categoryData, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18, bottom: 4),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(borderRadius: radius(50), color: context.cardColor),
            child: categoryData.image.isEmptyOrNull ? Text(categoryData.name![0], style: boldTextStyle(size: 20)).center() : cachedImage(categoryData.image, fit: BoxFit.cover),
          ).cornerRadiusWithClipRRect(defaultRadius),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categoryData.name.validate(), style: boldTextStyle()),
              4.height,
              categoryData.description.isEmptyOrNull ? Offstage() : Text(categoryData.description.validate().capitalizeFirstLetter(), style: secondaryTextStyle()),
            ],
          ).expand(),
          if (isAdmin)
            PopupMenuButton(
              color: context.cardColor,
              enabled: true,
              onSelected: (v) async {
                if (v == 1) {
                  AddCategoryScreen(categoryData: categoryData).launch(context);
                } else if (v == 2) {
                  if (await menuService.checkChildItemExist(categoryData.uid!, selectedRestaurant.uid!) < 0) {
                    categoryService.removeCustomDocument(categoryData.uid!, selectedRestaurant.uid!).then(
                      (value) {
                        appStore.setLoading(false);
                        finish(context);
                      },
                    ).catchError((e) async {});
                  } else {
                    showConfirmDialogCustom(
                      context,
                      dialogType: DialogType.DELETE,
                      title: '${language.lblTextForDeletingCategory}?',
                      onAccept: (c) {
                        appStore.setLoading(true);
                        menuService.checkToDelete(categoryData.uid!, selectedRestaurant.uid!);
                        categoryService.removeCustomDocument(categoryData.uid!, selectedRestaurant.uid!).then(
                          (value) {
                            appStore.setLoading(false);
                            finish(context);
                          },
                        ).catchError((e) async {});
                        appStore.setLoading(false);
                      },
                    );
                  }
                } else {
                  toast('${language.lblWrongSelection}');
                }
              },
              shape: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 1,
                  child: SettingItemWidget(
                    padding: EdgeInsets.all(0),
                    onTap: null,
                    leading: Icon(Icons.edit, color: context.iconColor, size: 20),
                    title: '${language.lblEdit}',
                    titleTextStyle: primaryTextStyle(),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: SettingItemWidget(
                    onTap: null,
                    leading: Icon(Icons.delete, color: context.iconColor, size: 20),
                    padding: EdgeInsets.all(0),
                    title: '${language.lblDelete}',
                    titleTextStyle: primaryTextStyle(),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
