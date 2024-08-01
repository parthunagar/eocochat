import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/image_option_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/currency_model.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/screens/currency_screen.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';

class AddRestaurantScreen extends StatefulWidget {
  final RestaurantModel? data;
  final String? userId;

  AddRestaurantScreen({
    this.userId,
    this.data,
  });

  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController mailCont = TextEditingController();
  TextEditingController contactCont = TextEditingController();
  TextEditingController currencyCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  TextEditingController dateCont = TextEditingController();
  Timestamp newItemValidForDays = Timestamp.now();

  List<TextInputAction> act = [TextInputAction.done, TextInputAction.newline];

  FocusNode nameNode = FocusNode();
  FocusNode mailNode = FocusNode();
  FocusNode contactNode = FocusNode();
  FocusNode currencyNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode descNode = FocusNode();
  FocusNode dateNode = FocusNode();
  CurrencyModel? sel;

  bool isVeg = false;
  bool isNonVeg = false;
  bool isUpdate = false;
  bool isCheck = false;

  File? image;
  File? logoImage;
  String? _image;
  String? _logoImage;

  @override
  void initState() {
    super.initState();
    init();
    afterBuildCreated(() {
      setStatusBarColor(context.scaffoldBackgroundColor);
    });
  }

  Future<void> init() async {
    isUpdate = widget.data != null;

    if (isUpdate) {
      isVeg = widget.data!.isVeg.validate();
      isNonVeg = widget.data!.isNonVeg.validate();
      nameCont.text = widget.data!.name.validate();
      mailCont.text = widget.data!.email.validate();
      contactCont.text = widget.data!.contact.validate();
      addressCont.text = widget.data!.address.validate();
      descCont.text = widget.data!.description.validate();
      dateCont.text = widget.data!.newItemForDays.validate().toString();
      sel = CurrencyModel.getCurrencyList().where((element) => element.symbol == widget.data!.currency).first;
      currencyCont.text = "${sel!.symbol.validate()} ${sel!.name.validate()}";

      _image = widget.data!.image.validate();
      _logoImage = widget.data!.logoImage.validate();
      newItemValidForDays = widget.data!.newItemValidForDays!;
    }
  }

  RestaurantModel get getResturantData {
    RestaurantModel data = RestaurantModel();
    data.name = nameCont.text.validate();
    data.email = mailCont.text.validate();
    data.contact = contactCont.text.validate();
    data.currency = sel!.symbol.validate();
    data.address = addressCont.text.validate();
    data.description = descCont.text;
    data.newItemValidForDays = newItemValidForDays;
    data.image = _image.validate();
    data.isVeg = isVeg;
    data.newItemForDays = dateCont.text.toInt();
    data.isNonVeg = isNonVeg;
    data.logoImage = _logoImage.validate();
    data.userId = getStringAsync(SharePreferencesKey.USER_ID);
    data.updatedAt = Timestamp.now();

    if (isUpdate) {
      data.uid = widget.data!.uid;
      data.createdAt = widget.data!.createdAt;
    } else {
      data.createdAt = Timestamp.now();
    }
    return data;
  }

  Future<void> saveData() async {
    appStore.setLoading(true);
    if (isUpdate) {
      await restaurantOwnerService.updateResturantInfo(getResturantData.toJson(), widget.data!.uid.validate(), profileImage: image != null ? File(image!.path) : null, logoImage: logoImage != null ? File(logoImage!.path) : null).then((value) {
        finish(context);
        finish(context, true);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    } else {
      await restaurantOwnerService
          .addResturantInfo(
        getResturantData.toJson(),
        profileImage: image != null ? File(image!.path) : null,
        logoImage: logoImage != null ? File(logoImage!.path) : null,
      )
          .then((value) {
        finish(context);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() {
        appStore.setLoading(false);
      });
    }
  }

  void updateData() {
    hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isVeg == false && isNonVeg == false) {
        isCheck = true;
      } else {
        showConfirmDialogCustom(
          context,
          dialogType: isUpdate ? DialogType.UPDATE : DialogType.ADD,
          title: isUpdate ? '${language.lblDoYouWantToUpdateRestaurant}?' : '${language.lblDoYouWantToAddRestaurant}?',
          onAccept: (context) {
            hideKeyboard(context);
            saveData();
          },
        );
      }
    } else {
      if (isVeg == false && isNonVeg == false) {
        isCheck = true;
      }
    }
    setState(() {});
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
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          isUpdate ? '${language.lblUpdateRestaurant}' : '${language.lblAddRestaurant}',
          color: context.scaffoldBackgroundColor,
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(isUpdate ? "${language.lblUpdate}" : "${language.lblAdd}", style: boldTextStyle(color: appStore.isDarkMode ? primaryColor : Colors.white)),
          icon: Icon(isUpdate ? Icons.update : Icons.add, color: appStore.isDarkMode ? Colors.black : Colors.white),
          onPressed: () {
            updateData();
          },
        ),
        body: Observer(
          builder: (_) => SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 60),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageOptionComponent(
                            defaultImage: _logoImage,
                            name: language.lblAddLogoImage,
                            onImageSelected: (File? image) {
                              logoImage = image;
                              _logoImage = "";
                              setState(() {});
                            },
                          ).withSize(height: 170, width: context.width() / 2 - 32),
                          isUpdate ? Text(_image!.isEmpty ? language.lblAddLogoImage : language.lblChangeLogoImage, style: primaryTextStyle(size: 12)) : Text(language.lblAddLogoImage, style: primaryTextStyle(size: 12))
                        ],
                      ),
                      16.width,
                      Column(
                        children: [
                          ImageOptionComponent(
                            defaultImage: _image,
                            name: language.lblAddRestaurantImage,
                            onImageSelected: (File? value) {
                              image = value;
                              _image = "";
                              setState(() {});
                            },
                          ).withSize(height: 170, width: context.width() / 2 - 32),
                          isUpdate
                              ? Text(
                                  _image!.isEmpty ? language.lblAddRestaurantImage : language.lblChangeRestaurantImage,
                                  style: primaryTextStyle(size: 12),
                                )
                              : Text(
                                  language.lblAddRestaurantImage,
                                  style: primaryTextStyle(size: 12),
                                )
                        ],
                      ),
                    ],
                  ),
                  30.height,
                  AppTextField(
                    decoration: inputDecoration(context, label: "${language.lblName}").copyWith(prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.drive_file_rename_outline, color: secondaryIconColor))),
                    controller: nameCont,
                    textFieldType: TextFieldType.NAME,
                    focus: nameNode,
                    nextFocus: mailNode,
                  ),
                  16.height,
                  AppTextField(
                    decoration: inputDecoration(context, label: "${language.lblEmail}").copyWith(prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.email_outlined, color: secondaryIconColor))),
                    controller: mailCont,
                    textFieldType: TextFieldType.EMAIL,
                    focus: mailNode,
                    nextFocus: contactNode,
                  ),
                  16.height,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: isCheck ? Colors.red : context.dividerColor),
                      borderRadius: radius(defaultRadius),
                    ),
                    padding: EdgeInsets.all(4),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -12,
                          left: 0,
                          child: Container(
                            color: context.scaffoldBackgroundColor,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(language.lblType, style: secondaryTextStyle(size: 12)),
                          ),
                        ),
                        Row(
                          children: [
                            CheckboxListTile(
                              value: isVeg,
                              dense: true,
                              selected: isVeg,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheck = false;
                                  isVeg = value!;
                                });
                              },
                              title: Text(language.lblVeg, style: secondaryTextStyle()),
                            ).expand(),
                            CheckboxListTile(
                              value: isNonVeg,
                              selected: isNonVeg,
                              dense: true,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheck = false;
                                  isNonVeg = value!;
                                });
                              },
                              title: Text(language.lblNonVeg, style: secondaryTextStyle()),
                            ).expand(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  AppTextField(
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration(context, label: "${language.lblContact}").copyWith(prefixIcon: IconButton(onPressed: null, icon: Icon(LineIcons.phone, color: secondaryIconColor))),
                    controller: contactCont,
                    focus: contactNode,
                    nextFocus: currencyNode,
                    textFieldType: TextFieldType.PHONE,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                  ),
                  16.height,
                  AppTextField(
                    decoration: inputDecoration(context, label: "${language.lblCurrency}").copyWith(
                      prefixIcon: IconButton(onPressed: null, icon: Icon(LineIcons.money_bill, color: secondaryIconColor)),
                    ),
                    controller: currencyCont,
                    onTap: () async {
                      sel = await push(CurrencyScreen(selectedCurrency: sel));
                      if (sel != null) {
                        currencyCont.text = "${sel!.symbol.validate()} ${sel!.name.validate()}";
                        setState(() {});
                      }
                    },
                    readOnly: true,
                    textFieldType: TextFieldType.NAME,
                    focus: currencyNode,
                    nextFocus: dateNode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                  ),
                  16.height,
                  AppTextField(
                    controller: dateCont,
                    isValidationRequired: true,
                    decoration: inputDecoration(context, label: "${language.lblNewItemValidity}").copyWith(
                      prefixIcon: IconButton(onPressed: null, icon: Icon(LineIcons.calendar, color: secondaryIconColor)),
                    ),
                    textFieldType: TextFieldType.PHONE,
                    focus: dateNode,
                    nextFocus: addressNode,
                    minLines: 1,
                  ),
                  16.height,
                  AppTextField(
                    decoration: inputDecoration(context, label: "${language.lblAddress}").copyWith(prefixIcon: Icon(LineIcons.building, color: secondaryIconColor)),
                    controller: addressCont,
                    textInputAction: TextInputAction.next,
                    minLines: 3,
                    focus: addressNode,
                    nextFocus: descNode,
                    textFieldType: TextFieldType.ADDRESS,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                  16.height,
                  AppTextField(
                    decoration: inputDecoration(
                      context,
                      label: "${language.lblDescription}",
                    ).copyWith(
                      prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.description_outlined, color: secondaryIconColor)),
                    ),
                    textInputAction: TextInputAction.done,
                    controller: descCont,
                    textFieldType: TextFieldType.ADDRESS,
                    focus: descNode,
                    minLines: 2,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                  ),
                ],
              ),
            ).paddingAll(16),
          ).visible(!appStore.isLoading, defaultWidget: Loader()),
        ),
      ),
    );
  }
}
