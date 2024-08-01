import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/add_new_componentItem.dart';
import 'package:qr_menu/components/category_component.dart';
import 'package:qr_menu/components/menu_list_category_component.dart';
import 'package:qr_menu/components/menu_mobile_component.dart';
import 'package:qr_menu/components/no_data_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/models/menu_model.dart';
import 'package:qr_menu/screens/add_menu_item_screen.dart';

class ResMenuList extends StatefulWidget {
  final bool isAdmin;

  ResMenuList({this.isAdmin = false});

  @override
  _ResMenuListState createState() => _ResMenuListState();
}

class _ResMenuListState extends State<ResMenuList> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void dispose() {
    menuStore.setSelectedCategoryData(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height(),
      width: context.width(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 60, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CategoryComponent(isAdmin: widget.isAdmin),
            16.height,
            Row(
              children: [
                Text(language.lblMenuItems, style: boldTextStyle(size: 20)).expand(),
                if (widget.isAdmin)
                  AddNewComponentItem(
                    onTap: () {
                      push(AddMenuItemScreen());
                    },
                  ),
              ],
            ).paddingSymmetric(horizontal: 16),
            16.height,
            Observer(
              builder: (_) => StreamBuilder<List<MenuModel>>(
                stream: menuService.getAllDataCategoryWise(categoryId: menuStore.selectedCategoryData?.uid),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.connectionState == ConnectionState.waiting) return Loader().center();
                    if (snap.data!.isEmpty) return NoMenuComponent(categoryName: menuStore.selectedCategoryData?.name.validate()).center();
                    return GroupedListView<MenuModel, String>(
                      shrinkWrap: true,
                      floatingHeader: true,
                      groupBy: (element) => element.categoryId.validate(),
                      groupSeparatorBuilder: (value) {
                        return StreamBuilder<CategoryModel>(
                          stream: categoryService.getSingleStreamData(uId: value),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              return MenuListCategoryComponent(categoryData: snap.data!, isAdmin: widget.isAdmin);
                            }
                            return snapWidgetHelper(snap);
                          },
                        );
                      },
                      itemBuilder: (context, element) {
                        return Responsive(
                          mobile: MenuMobileComponent(menuModel: element).onTap(() {
                            if (widget.isAdmin) {
                              push(AddMenuItemScreen(menuData: element), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds);
                            }
                          }),
                          web: MenuMobileComponent(menuModel: element, isWeb: true),
                          tablet: MenuMobileComponent(menuModel: element, isTablet: true),
                        );
                      },
                      order: GroupedListOrder.ASC,
                      elements: snap.data!,
                    );
                  }
                  return snapWidgetHelper(snap);
                },
              ).paddingSymmetric(horizontal: 16),
            ),
          ],
        ),
      ),
    );
  }
}
