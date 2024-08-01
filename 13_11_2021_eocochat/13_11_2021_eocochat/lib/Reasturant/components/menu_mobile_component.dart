import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/components/veg_component.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/models/menu_model.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';
import 'package:readmore/readmore.dart';

class MenuMobileComponent extends StatefulWidget {
  final MenuModel? menuModel;
  bool? isTablet;
  bool? isWeb;

  MenuMobileComponent({this.menuModel, this.isTablet, this.isWeb});

  @override
  _MenuMobileComponentState createState() => _MenuMobileComponentState();
}

class _MenuMobileComponentState extends State<MenuMobileComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (widget.menuModel!.isNew.validate()) {
      if (Timestamp.now().toDate().day - selectedRestaurant.newItemForDays.validate() <= 0) {
        widget.menuModel!.isNew = false;
      } else {
        widget.menuModel!.isNew = true;
      }
    }
  }

  List<String> getMenuType() {
    List<bool> menuTypeBool = [
      widget.menuModel!.isSpicy.validate(),
      widget.menuModel!.isJain.validate(),
      widget.menuModel!.isSpecial.validate(),
      widget.menuModel!.isPopular.validate(),
      widget.menuModel!.isSweet.validate(),
    ];
    List<String> menuTypeText = [
      // language.lblSpicy,
      // language.lblJain,
      // language.lblSpecial,
      // language.lblPopular,
      // language.lblSweet,
      getTranslated(context, 'lblSpicy'),
      getTranslated(context, 'lblJain'),
      getTranslated(context, 'lblSpecial'),
      getTranslated(context, 'lblPopular'),
      getTranslated(context, 'lblSweet'),
    ];
    List<String> toPrint = [];

    menuTypeText.forEach((element) {
      int index = menuTypeText.indexOf(element);
      menuTypeBool[index] ? toPrint.add(element) : null;
    });
    return toPrint;
  }

  Widget checkIndicatorExist() {
    if (widget.menuModel!.isSpicy == false && widget.menuModel!.isJain == false && widget.menuModel!.isPopular == false && widget.menuModel!.isSpecial == false) {
      return Offstage();
    }
    return Divider();
  }

  double getWidth() {
    if (widget.isTablet.validate()) {
      return context.width() / 1;
    } else if (widget.isWeb.validate()) {
      return context.width() / 1;
    }
    return context.width() / 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: radius(defaultRadius),
          // color: context.cardColor,
          color: Colors.amber.withOpacity(0.5),

          border: Border.all(color: context.dividerColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.menuModel!.isVeg.validate() ? VegComponent(size: 18) : NonVegComponent(size: 18),
              12.width,
              Text('${widget.menuModel!.name!.trim()}', style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis).expand(),
              widget.menuModel!.isNew == true
                  ? Container(
                      // child: Text(language.lblNew, style: primaryTextStyle(size: 14, color: Colors.red)),
                     child: Text(getTranslated(context, 'lblNew'), style: primaryTextStyle(size: 14, color: Colors.red)),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(borderRadius: radius(defaultRadius), color: Colors.red.withOpacity(0.1)),
                    )
                  : Offstage(),
            ],
          ),
          12.height,
          Wrap(
            spacing: 4,
            children: List.generate(
              widget.menuModel!.ingredient!.length,
              (index) {
                if (index == widget.menuModel!.ingredient!.length - 1) {
                  return ReadMoreText(
                    '${widget.menuModel!.ingredient?[index].capitalizeFirstLetter()}',
                    style: primaryTextStyle(size: 14),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    // trimCollapsedText: '${language.lblShowMore}',
                    // trimExpandedText: '${language.lblShowLess}',
                    trimCollapsedText: '${getTranslated(context, 'lblShowMore')}',
                    trimExpandedText: '${getTranslated(context, 'lblShowLess')}',
                    moreStyle: secondaryTextStyle(size: 12, color: primaryColor),
                    lessStyle: secondaryTextStyle(size: 12, color: primaryColor),
                  );
                }
                return ReadMoreText(
                  '${widget.menuModel!.ingredient?[index].capitalizeFirstLetter()},',
                  style: primaryTextStyle(size: 14),
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  // trimCollapsedText: '${language.lblShowMore}',
                  // trimExpandedText: '${language.lblShowLess}',
                  trimCollapsedText: '${getTranslated(context, 'lblShowMore')}',
                  trimExpandedText: '${getTranslated(context, 'lblShowLess')}',
                  moreStyle: secondaryTextStyle(size: 12, color: primaryColor),
                  lessStyle: secondaryTextStyle(size: 12, color: primaryColor),
                );
              },
            ),
          ),
          Divider(height: 16),
          Row(
            children: [
              Text('${selectedRestaurant.currency} ${widget.menuModel!.price}', style: boldTextStyle(size: 20)).expand(),
              Wrap(
                children: List.generate(
                  getMenuType().length,
                  (index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text(getMenuType()[index], style: secondaryTextStyle(size: 12)), index == (getMenuType().length - 1) ? Text('', style: secondaryTextStyle(size: 12)) : Text(', ', style: secondaryTextStyle(size: 12))],
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
