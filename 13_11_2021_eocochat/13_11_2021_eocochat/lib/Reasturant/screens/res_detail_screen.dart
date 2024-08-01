import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/components/res_menu_list.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/models/restaurant_model.dart';
import 'package:fiberchat/Reasturant/screens/add_restaurant_screen.dart';
import 'package:fiberchat/Reasturant/screens/qr_generate_screen.dart';
import 'package:fiberchat/Reasturant/services/category_service.dart';
import 'package:fiberchat/Reasturant/services/menu_service.dart';

class ResDetailScreen extends StatefulWidget {
  final RestaurantModel data;

  ResDetailScreen({required this.data});

  @override
  ResDetailScreenState createState() => ResDetailScreenState();
}

class ResDetailScreenState extends State<ResDetailScreen> {
  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  Future<void> init() async {
    appStore.setLoading(true);
    menuService = MenuService(restaurantId: widget.data.uid.validate());
    categoryService = CategoryService(restaurantId: widget.data.uid.validate());
    selectedRestaurant = widget.data;

    appStore.setLoading(false);

    setState(() {});

    setStatusBarColor(context.scaffoldBackgroundColor);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> deleteData() async {
    appStore.setLoading(true);
    restaurantOwnerService.removeDocument(widget.data.uid!).then((value) async {
      finish(context);
    }).catchError((e) {
      log(e.toString());
    }).whenComplete(() => appStore.setLoading(false));
  }

  @override
  void dispose() {
    menuStore.setSelectedCategoryData(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: eocochatYellow,
        appBar: appBarWidget(
          '${widget.data.name}',
          color: eocochatYellow,// context.scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                print(' ====> ON CLICK SHOW QR CODE <=== ');
                // QrGenerateScreen().launch(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QrGenerateScreen()));
              },
              icon: Icon(Icons.qr_code, color: context.iconColor),
            ),
            PopupMenuButton(
              color: context.cardColor,
              enabled: true,
              onSelected: (v) {
                if (v == 1) {
                  AddRestaurantScreen(data: widget.data).launch(context);
                } else if (v == 2) {
                  showConfirmDialogCustom(context, onAccept: (c) {
                    deleteData();
                  // }, dialogType: DialogType.DELETE, title: '${language.lblDoYouWantToDeleteRestaurant}?');
                  }, dialogType: DialogType.DELETE, title: '${getTranslated(context, 'lblDoYouWantToDeleteRestaurant')}?');
                } else {
                  // toast(language.lblWrongSelection);
                  toast(getTranslated(context, 'lblWrongSelection'));
                }
              },
              shape: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
              icon: Icon(Icons.more_horiz, color: context.iconColor),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 1,
                  child: SettingItemWidget(
                    padding: EdgeInsets.all(0),
                    onTap: null,
                    leading: Icon(Icons.edit, color: context.iconColor, size: 20),
                    // title: '${language.lblEdit}',
                    title: '${getTranslated(context, 'lblEdit')}',
                    titleTextStyle: primaryTextStyle())),
                PopupMenuItem(
                  value: 2,
                  child: SettingItemWidget(
                    onTap: null,
                    leading: Icon(Icons.delete, color: context.iconColor, size: 20),
                    padding: EdgeInsets.all(0),
                    // title: '${language.lblDelete}',
                    title: '${getTranslated(context, 'lblDelete')}',
                    titleTextStyle: primaryTextStyle()))
              ],
            ).paddingRight(8),
          ],

        ),
        body: Container(
          // color: context.scaffoldBackgroundColor,
          color: eocochatYellow,
          width: context.width(),
          height: context.height(),
          child: ResMenuList(isAdmin: true),
        ),
      ),
    );
  }
}
