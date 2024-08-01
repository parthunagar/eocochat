import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/add_new_componentItem.dart';
import 'package:qr_menu/components/category_widget.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/screens/add_category_screen.dart';
import 'package:qr_menu/utils/colors.dart';

class CategoryComponent extends StatefulWidget {
  final bool isAdmin;

  CategoryComponent({this.isAdmin = false});

  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  int isSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: categoryService.getCategoryStreamData(),
      builder: (context, snap) {
        if (snap.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${language.lblCategories} (${snap.data!.length.validate()})', style: boldTextStyle(size: 20)).expand(),
                  if (widget.isAdmin)
                    AddNewComponentItem(
                      onTap: () {
                        push(AddCategoryScreen());
                      },
                    ),
                ],
              ).paddingSymmetric(horizontal: 16),
              4.height,
              if (widget.isAdmin) Text(language.lblLongPressOnCategoryForMoreOptions, style: secondaryTextStyle(size: 10)).paddingSymmetric(horizontal: 16),
              16.height,
              Container(
                width: context.width(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isSelectedIndex = -1;
                          menuStore.setSelectedCategoryData(null);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: radius(defaultRadius),
                            color: isSelectedIndex == -1
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
                                child: Text("${language.lblA}", style: boldTextStyle(size: 24)).center(),
                              ),
                              Text(language.lblAll, style: boldTextStyle(size: 14), textAlign: TextAlign.center).paddingSymmetric(horizontal: 8, vertical: 8)
                            ],
                          ),
                        ),
                      ).paddingSymmetric(vertical: 8),
                      HorizontalList(
                        physics: NeverScrollableScrollPhysics(),
                        spacing: 4,
                        itemCount: snap.data!.length,
                        itemBuilder: (context, index) {
                          CategoryModel categoryData = snap.data![index];
                          bool isSelected = isSelectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              isSelectedIndex = index;

                              menuStore.setSelectedCategoryData(snap.data![index]);

                              setState(() {});
                            },
                            onLongPress: () {
                              if (widget.isAdmin == true) {
                                AddCategoryScreen(categoryData: categoryData).launch(context);
                              }
                            },
                            child: CategoryWidget(categoryData: categoryData, isSelected: isSelected),
                          );
                        },
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                ),
              ),
            ],
          );
        }
        return snapWidgetHelper(snap);
      },
    );
  }
}
