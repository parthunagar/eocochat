import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/image_option_component.dart';
import 'package:qr_menu/models/user_model.dart';
import 'package:qr_menu/services/base_service.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';

import '../main.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  UserModel currentUser = UserModel();

  TextEditingController nameCont = TextEditingController();
  TextEditingController numCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  FocusNode contactFocus = FocusNode();

  File? image;
  String? _image;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  Future<void> init() async {
    appStore.setLoading(true);
    await userService.userByEmail(getStringAsync(SharePreferencesKey.USER_EMAIL)).then((value) {
      currentUser = value;
      emailCont.text = value.email.validate();
      nameCont.text = value.name.validate();
      numCont.text = value.num.validate();
      _image = value.image.validate();
    });
    appStore.setLoading(false);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> updateProfile() async {
    appStore.setLoading(true);

    UserModel data = UserModel();

    data.email = emailCont.text;
    data.name = nameCont.text;
    data.num = numCont.text;
    if (image != null) {
      data.image = await BaseService.getUploadedImageURL(image!, currentUser.uid.validate());
    } else {
      data.image = currentUser.image;
    }
    data.isEmailLogin = currentUser.isEmailLogin;
    data.uid = getStringAsync(SharePreferencesKey.USER_ID);
    data.updatedAt = Timestamp.now();
    data.createdAt = currentUser.createdAt;
    data.uid = currentUser.uid;

    //appStore.setLoading(true);
    userService.ref!.doc(getStringAsync(SharePreferencesKey.USER_ID)).set(data).then((value) {
      setValue(SharePreferencesKey.USER_NAME, data.name.validate());
      setValue(SharePreferencesKey.USER_NUMBER, data.num.validate());
      setValue(SharePreferencesKey.USER_EMAIL, data.email.validate());
      setValue(SharePreferencesKey.USER_IMAGE, data.image.validate());

      appStore.setFullName(data.name.validate());
      appStore.setUserEmail(data.email.validate());
      appStore.setUserProfile(data.image.validate());
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() => appStore.setLoading(false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showConfirmDialogCustom(
            context,
            dialogType: DialogType.UPDATE,
            title: '${language.lbDoYouWantToUpdateProfile}?',
            onAccept: (context) {
              hideKeyboard(context);
              updateProfile().then(
                (value) {
                  finish(context);
                },
              );
            },
          );
        },
        icon: Icon(Icons.save, color: appStore.isDarkMode ? Colors.black : Colors.white),
        label: Text(language.lblSave, style: boldTextStyle(color: appStore.isDarkMode ? Colors.black : Colors.white)),
      ),
      appBar: appBarWidget('${language.lblEditProfile}', color: context.scaffoldBackgroundColor),
      body: Stack(
        children: [
          Observer(
            builder: (_) => SingleChildScrollView(
              child: Container(
                height: context.height(),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    currentUser.isEmailLogin == true
                        ? ImageOptionComponent(
                            defaultImage: _image,
                            name: language.lblAddImage,
                            onImageSelected: (File? value) {
                              image = value;
                              _image = "";

                              setState(() {});
                            },
                          ).center().withSize(width: 180, height: 180)
                        : cachedImage(_image, width: 180, height: 180, fit: BoxFit.cover).cornerRadiusWithClipRRect(100),
                    32.height,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextField(
                            textInputAction: TextInputAction.next,
                            controller: nameCont,
                            nextFocus: contactFocus,
                            textFieldType: TextFieldType.NAME,
                            decoration: inputDecoration(context, label: '${language.lblName}').copyWith(prefixIcon: Icon(Icons.person_outline, color: secondaryIconColor)),
                          ),
                          16.height,
                          AppTextField(
                            textInputAction: TextInputAction.done,
                            controller: numCont,
                            focus: contactFocus,
                            maxLength: 12,
                            textFieldType: TextFieldType.PHONE,
                            buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                            decoration: inputDecoration(context, label: '${language.lblNumber}').copyWith(prefixIcon: Icon(LineIcons.phone, color: secondaryIconColor)),
                          ),
                          16.height,
                          AppTextField(
                            textInputAction: TextInputAction.done,
                            controller: emailCont,
                            readOnly: true,
                            textFieldType: TextFieldType.EMAIL,
                            enabled: currentUser.isEmailLogin,
                            decoration: inputDecoration(context, label: '${language.lblEmail}').copyWith(prefixIcon: Icon(Icons.email_outlined, color: secondaryIconColor)),
                          ),
                          32.height,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).visible(!appStore.isLoading, defaultWidget: Loader()),
          ),
        ],
      ),
    );
  }
}
