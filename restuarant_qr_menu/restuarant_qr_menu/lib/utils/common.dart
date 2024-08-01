import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', subTitle: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'images/flag/ic_us.png'),
    LanguageDataModel(id: 2, name: 'Hindi', subTitle: 'हिंदी', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'images/flag/ic_india.png'),
    LanguageDataModel(id: 3, name: 'Arabic', subTitle: 'عربي', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'images/flag/ic_ar.png'),
  ];
}

InputDecoration inputDecoration(BuildContext context, {String? hint, String? label, TextStyle? textStyle, Widget? prefix,EdgeInsetsGeometry? contentPadding,Widget? prefixIcon}) {
  return InputDecoration(
    contentPadding: contentPadding,
    labelText: label,
    hintText: hint,
    hintStyle: textStyle ?? secondaryTextStyle(),
    labelStyle: textStyle ?? secondaryTextStyle(),
    prefix: prefix,
    prefixIcon: prefixIcon,
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: Colors.red, width: 1.0)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: Colors.red, width: 1.0)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(width: 1.0, color: context.dividerColor)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(width: 1.0, color: context.dividerColor)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor, width: 1.0)),
    alignLabelWithHint: true,
  );
}

Future<File> getImageSource({bool isCamera = true}) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
  return File(pickedImage!.path);
}

Future<void> launchUrl(String url, {bool forceWebView = false}) async {
  await launch(url, forceWebView: forceWebView, enableJavaScript: true, statusBarBrightness: Brightness.light, webOnlyWindowName: "News").catchError((e) {
    toast('Invalid URL: $url');
  });
}

extension UtilListExtension on List {
  groupBy(String key) {
    try {
      List<Map<String, dynamic>> result = [];
      List<String> keys = [];

      this.forEach((f) => keys.add(f[key]));

      [...keys.toSet()].forEach((k) {
        List data = [...this.where((e) => e[key] == k)];
        result.add({k: data});
      });

      return result;
    } catch (e, s) {
      log(e);
      return this;
    }
  }
}

BoxDecoration glassBoxDecoration({int? blurOpacity}) {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: appStore.isDarkMode ? Colors.black.withAlpha(100) : Colors.white.withAlpha(100),
        blurRadius: 10.0,
        spreadRadius: 0.0,
      ),
    ],
    color: appStore.isDarkMode ? Colors.black.withAlpha(200) : Colors.white.withAlpha(200),
    border: Border.all(color: appStore.isDarkMode ? Colors.black.withAlpha(80) : Colors.white10.withAlpha(80)),
  );
}

BoxDecoration blackBoxDecoration() {
  return BoxDecoration(
    borderRadius: radiusOnly(bottomLeft: defaultRadius, bottomRight: defaultRadius),
    gradient: LinearGradient(
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      colors: [
        Colors.transparent,
        Colors.transparent,
        ...List<Color>.generate(16, (index) => Colors.black.withAlpha(index*10))
      ],
    ),
    // color: Colors.black.withAlpha(100),
  );
}
