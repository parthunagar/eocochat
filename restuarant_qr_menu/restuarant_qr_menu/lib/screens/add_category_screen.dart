import 'dart:io';

import 'package:cloud_firestore_platform_interface/src/timestamp.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/image_option_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';

class AddCategoryScreen extends StatefulWidget {
  final CategoryModel? categoryData;

  AddCategoryScreen({this.categoryData});

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isUpdate = false;

  File? image;
  String? _image;

  TextEditingController nameCont = TextEditingController();
  TextEditingController descCont = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode descFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    isUpdate = widget.categoryData != null;
    if (isUpdate) {
      nameCont.text = widget.categoryData!.name.validate();
      descCont.text = widget.categoryData!.description.validate();
      _image = widget.categoryData!.image.validate();
    }
    setState(() {});
  }

  CategoryModel get getCategoryData {
    CategoryModel data = CategoryModel();

    data.name = nameCont.text.validate();
    data.description = descCont.text.validate();
    data.image = "";
    data.updatedAt = Timestamp.now();

    if (isUpdate) {
      data.uid = widget.categoryData!.uid;
      data.createdAt = widget.categoryData!.createdAt;
    } else {
      data.createdAt = Timestamp.now();
    }
    return data;
  }

  Future<void> saveData() async {
    appStore.setLoading(true);

    if (isUpdate) {
      await categoryService.updateCategoryInfo(getCategoryData.toJson(), widget.categoryData!.uid.validate(), selectedRestaurant.uid!, profileImage: image != null ? File(image!.path) : null).then((value) {
        finish(context, true);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    } else {
      await categoryService.addCategoryInfo(getCategoryData.toJson(), selectedRestaurant.uid!, profileImage: image != null ? File(image!.path) : null).then((value) {
        finish(context);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => appStore.setLoading(false));
    }
  }

  Future<void> deleteData() async {
    appStore.setLoading(true);

    if (await menuService.checkChildItemExist(widget.categoryData!.uid!, selectedRestaurant.uid!) < 0) {
      categoryService.removeCustomDocument(widget.categoryData!.uid!, selectedRestaurant.uid!).then((value) {
        appStore.setLoading(false);
        finish(context);
      }).catchError((e) async {});
    } else {
      appStore.setLoading(true);
      menuService.checkToDelete(widget.categoryData!.uid!, selectedRestaurant.uid!);
      categoryService.removeCustomDocument(widget.categoryData!.uid!, selectedRestaurant.uid!).then((value) {
        appStore.setLoading(false);
        finish(context);
      }).catchError((e) async {});
      appStore.setLoading(false);
    }
    finish(context);
  }

  void updateData() {
    hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showConfirmDialogCustom(
        context,
        dialogType: isUpdate ? DialogType.UPDATE : DialogType.ADD,
        title: isUpdate ? '${language.lblDoYouWantToUpdate} ${widget.categoryData!.name}?' : '${language.lblDoYouWantToAddThisCategory}',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          isUpdate ? '${language.lblUpdate}' : '${language.lblAddCategory}',
          actions: [
            IconButton(
              onPressed: () {
                showConfirmDialogCustom(
                  context,
                  onAccept: (c) {
                    deleteData();
                  },
                  dialogType: DialogType.DELETE,
                  title: '${language.lblTextForDeletingCategory} ${widget.categoryData!.name}?',
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
        body: Stack(
          children: [
            Observer(
              builder: (_) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
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
                        ).center().withSize(height: 200, width: 200),
                        32.height,
                        AppTextField(
                          textStyle: primaryTextStyle(),
                          focus: nameFocus,
                          nextFocus: descFocus,
                          decoration: inputDecoration(context, label: language.lblName).copyWith(
                            prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.drive_file_rename_outline, color: secondaryIconColor)),
                          ),
                          controller: nameCont,
                          textFieldType: TextFieldType.NAME,
                        ),
                        16.height,
                        AppTextField(
                          textStyle: primaryTextStyle(),
                          textInputAction: TextInputAction.done,
                          decoration: inputDecoration(context, label: language.lblDescription).copyWith(
                            prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.description_outlined, color: secondaryIconColor)),
                          ),
                          controller: descCont,
                          buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                          maxLines: 8,
                          minLines: 3,
                          maxLength: 26,
                          textFieldType: TextFieldType.OTHER,
                          focus: descFocus,
                        ),
                      ],
                    ),
                  ),
                ),
              ).visible(
                !appStore.isLoading,
                defaultWidget: Loader(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
