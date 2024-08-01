import 'dart:io';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/add_ingredient_dialog_component.dart';
import 'package:qr_menu/components/category_dropdown_component.dart';
import 'package:qr_menu/components/image_option_component.dart';
import 'package:qr_menu/components/menu_item_detail_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/models/menu_model.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';

class AddMenuItemScreen extends StatefulWidget {
  final MenuModel? menuData;

  AddMenuItemScreen({this.menuData});

  @override
  AddMenuItemScreenState createState() => AddMenuItemScreenState();
}

class AddMenuItemScreenState extends State<AddMenuItemScreen> {
  AsyncMemoizer<List<CategoryModel>> categoryMemoizer = AsyncMemoizer();
  var _formKey = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  TextEditingController categoryCont = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode descFocus = FocusNode();
  FocusNode categoryFocus = FocusNode();

  final picker = ImagePicker();

  CategoryModel? selectedCategory;

  File? image;

  String? _image;
  String? _category;

  bool isUpdate = false;
  bool ingredientUpdate = false;

  bool isNew = true;
  bool isVeg = false;
  bool isSpicy = false;
  bool isJain = false;
  bool isSpecial = false;
  bool isSweet = false;
  bool isPopular = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    ingredient = [];
    appStore.setLoading(true);

    isUpdate = widget.menuData != null;

    if (selectedRestaurant.isVeg == true) {
      isVeg = true;
    }
    if (selectedRestaurant.isNonVeg == true) {
      isVeg = false;
    }

    if (isUpdate) {
      nameCont.text = widget.menuData!.name!;
      priceCont.text = widget.menuData!.price.toString();
      descCont.text = widget.menuData!.description!;
      _image = widget.menuData!.image.validate();

      _category = widget.menuData!.category;

      ingredient = widget.menuData!.ingredient.validate();

      isVeg = widget.menuData!.isVeg.validate();
      isNew = widget.menuData!.isNew.validate();
      isSpicy = widget.menuData!.isSpicy.validate();
      isJain = widget.menuData!.isJain.validate();
      isSpecial = widget.menuData!.isSpecial.validate();
      isSweet = widget.menuData!.isSweet.validate();
      isPopular = widget.menuData!.isPopular.validate();
    }
    appStore.setLoading(false);

    setState(() {});
  }

  Future<MenuModel> get getData async {
    MenuModel data = MenuModel();
    data.name = nameCont.text.validate();
    data.description = descCont.text.validate();
    data.price = priceCont.text.validate().toInt();
    data.category = _category;
    data.categoryId = selectedCategory?.uid;

    data.image = _image;
    data.ingredient = ingredient;
    data.isNew = isNew;
    data.isJain = isJain;
    data.isSpicy = isSpicy;
    data.isPopular = isPopular;
    data.isSweet = isSweet;
    data.isSpecial = isSpecial;
    data.isVeg = isVeg;

    data.updatedAt = Timestamp.now();

    if (isUpdate) {
      data.uid = widget.menuData!.uid.validate();
      data.createdAt = widget.menuData!.createdAt;
    } else {
      data.createdAt = Timestamp.now();
    }
    return data;
  }

  Future<void> saveData() async {
    appStore.setLoading(true);
    if (isUpdate) {
      await menuService.updateMenuInfo(await getData.then((value) => value.toJson()), widget.menuData!.uid.validate(), selectedRestaurant.uid.validate(), profileImage: image != null ? File(image!.path) : null).then((value) {
        finish(context);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    } else {
      await menuService.addMenuInfo(await getData.then((value) => value.toJson()), selectedRestaurant.uid!, profileImage: image != null ? File(image!.path) : null).then((value) {
        finish(context);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    }
  }

  Future<void> deleteData() async {
    appStore.setLoading(true);

    menuService.removeCustomDocument(widget.menuData!.uid!, selectedRestaurant.uid.validate()).then((value) {
      appStore.setLoading(false);
      finish(context);
    }).catchError((e) {
      appStore.setLoading(false);
      log(e.toString());
    });
  }

  Future<void> updateData() async {
    hideKeyboard(context);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      hideKeyboard(context);

      showConfirmDialogCustom(
        context,
        dialogType: isUpdate ? DialogType.UPDATE : DialogType.ADD,
        title: isUpdate ? '${language.lblDoYouWantToUpdate} ${widget.menuData!.name}?' : '${language.lblDoYouWantToAddThisMenuItem}?',
        onAccept: (context) {
          hideKeyboard(context);
          saveData();
        },
      );
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  BoxDecoration commonDecoration() {
    return BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius), border: Border.all(width: 1, color: context.dividerColor));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBarWidget(
          isUpdate ? '${language.lblUpdate}' : '${language.lblAddMenuItem}',
          actions: [
            IconButton(
              onPressed: () {
                showConfirmDialogCustom(
                  context,
                  onAccept: (c) {
                    deleteData();
                  },
                  dialogType: DialogType.DELETE,
                  title: '${language.lblDoYouWantToDelete} ${widget.menuData!.name}?',
                );
              },
              icon: Icon(Icons.delete, color: context.iconColor),
            ).visible(isUpdate),
          ],
          color: context.scaffoldBackgroundColor,
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(isUpdate ? "${language.lblUpdate}" : "${language.lblAdd}", style: boldTextStyle(color: appStore.isDarkMode ? Colors.black : Colors.white)),
          icon: Icon(isUpdate ? Icons.update : Icons.add, color: appStore.isDarkMode ? Colors.black : Colors.white),
          onPressed: () {
            updateData();
          },
        ),
        body: Observer(
          builder: (_) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 80, left: 16, right: 16, top: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ImageOptionComponent(
                      defaultImage: _image,
                      name: language.lblAddImage,
                      onImageSelected: (File? value) {
                        image = value;
                        _image = "";

                        setState(() {});
                      },
                    ).withSize(height: 180, width: 180),
                    16.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          textStyle: primaryTextStyle(),
                          focus: nameFocus,
                          nextFocus: categoryFocus,
                          textInputAction: TextInputAction.next,
                          decoration: inputDecoration(context, label: "${language.lblName}").copyWith(
                            prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.drive_file_rename_outline, color: secondaryIconColor)),
                          ),
                          controller: nameCont,
                          textFieldType: TextFieldType.NAME,
                        ),
                        16.height,
                        CategoryDropdownComponent(
                          isValidate: true,
                          defaultValue: isUpdate ? widget.menuData!.categoryId : null,
                          onValueChanged: (value) async {
                            selectedCategory = value;
                            await 1.seconds.delay;
                            setState(() {});
                          },
                        ),
                        16.height,
                        AppTextField(
                          textStyle: primaryTextStyle(),
                          focus: priceFocus,
                          nextFocus: descFocus,
                          textInputAction: TextInputAction.next,
                          decoration: inputDecoration(
                            context,
                            label: "${language.lblPrice}",
                          ).copyWith(
                            prefixIcon: IconButton(
                              icon: Text('${selectedRestaurant.currency} ', style: secondaryTextStyle(size: 24, color: secondaryIconColor)),
                              onPressed: () {},
                            ),
                          ),
                          controller: priceCont,
                          textFieldType: TextFieldType.PHONE,
                        ),
                        16.height,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          width: context.width(),
                          decoration: commonDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.info_outline, color: secondaryIconColor, size: 20),
                                      8.width,
                                      Text(language.lblIngredients, style: secondaryTextStyle()),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: secondaryIconColor),
                                    onPressed: () {
                                      showInDialog(
                                        context,
                                        contentPadding: EdgeInsets.all(0),
                                        builder: (c) {
                                          return AddIngredientDialogComponent();
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 16,
                                runSpacing: 16,
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                  ingredient.length,
                                  (index) => Chip(
                                    labelStyle: primaryTextStyle(size: 16),
                                    label: Text(ingredient[index].capitalizeFirstLetter()),
                                    deleteIcon: Icon(Icons.clear, color: Colors.red, size: 20),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    backgroundColor: context.cardColor,
                                    onDeleted: () {
                                      ingredient.removeAt(index);
                                      setState(() {});
                                    },
                                  ).onTap(() {
                                    setState(() {
                                      ingredientUpdate = true;
                                    });
                                    showInDialog(
                                      context,
                                      contentPadding: EdgeInsets.all(0),
                                      builder: (c) {
                                        return AddIngredientDialogComponent(value: ingredient[index]);
                                      },
                                    );
                                    hideKeyboard(context);
                                  }, borderRadius: radius(80)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        16.height,
                        AppTextField(
                          textStyle: primaryTextStyle(),
                          focus: descFocus,
                          textInputAction: TextInputAction.done,
                          decoration: inputDecoration(context, label: language.lblDescription).copyWith(
                            prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.description_outlined, color: secondaryIconColor)),
                          ),
                          controller: descCont,
                          minLines: 3,
                          maxLines: 3,
                          textFieldType: TextFieldType.ADDRESS,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                        ),
                      ],
                    ),
                    16.height,
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        MenuItemDetailComponent(
                          title: language.lblNew,
                          subtitle: language.lblNewDescription,
                          isSelected: isNew,
                          onChanged: (val) {
                            isNew = val;
                            setState(() {});
                          },
                        ),
                        MenuItemDetailComponent(
                          title: language.lblVeg,
                          subtitle: language.lblVegDescription,
                          isTappedEnabled: selectedRestaurant.isVeg.validate() == true && selectedRestaurant.isNonVeg.validate() == false,
                          isSelected: isVeg,
                          onChanged: (bool val) {
                            if (selectedRestaurant.isVeg.validate() == true && selectedRestaurant.isNonVeg.validate() == true) {
                              isVeg = val;
                            } else if (selectedRestaurant.isVeg.validate() == true && selectedRestaurant.isNonVeg.validate() == false) {
                              isVeg = true;
                              toast('You can\'t This is veg restaurant');
                            } else {
                              isVeg = false;
                            }
                          },
                        ),
                        MenuItemDetailComponent(
                          title: language.lblSpicy,
                          subtitle: language.lblSpicyDescription,
                          isSelected: isSpicy,
                          onChanged: (val) {
                            isSpicy = val;
                            setState(() {});
                          },
                        ),
                        MenuItemDetailComponent(
                          title: language.lblJain,
                          subtitle: language.lblJainDescription,
                          isSelected: isJain,
                          onChanged: (val) {
                            isJain = val;
                            setState(() {});
                          },
                        ),
                        MenuItemDetailComponent(
                          title: language.lblSpecial,
                          subtitle: language.lblSpecialDescription,
                          isSelected: isSpecial,
                          onChanged: (val) {
                            isSpecial = val;
                            setState(() {});
                          },
                        ),
                        MenuItemDetailComponent(
                          title: language.lblSweet,
                          subtitle: language.lblSweetDescription,
                          isSelected: isSweet,
                          onChanged: (val) {
                            isSweet = val;
                            setState(() {});
                          },
                        ),
                        MenuItemDetailComponent(
                          title: language.lblPopular,
                          subtitle: language.lblPopularDescription,
                          isSelected: isPopular,
                          onChanged: (val) {
                            isPopular = val;
                            setState(() {});
                          },
                        ),
                      ],
                    ).center(),
                  ],
                ),
              ),
            ),
          ).visible(!appStore.isLoading, defaultWidget: Loader()),
        ),
      ),
    );
  }
}
