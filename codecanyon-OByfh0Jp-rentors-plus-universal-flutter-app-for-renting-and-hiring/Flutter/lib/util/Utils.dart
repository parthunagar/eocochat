import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:date_format/date_format.dart' as dateformat;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/model/home/HomeModel.dart';

class Utils {
  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  static Future<Uint8List> getBytesFromAsset(
      String path, int width, int heigth) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: heigth);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  static Future<UserModel> getUser() async {
    final _storage = FlutterSecureStorage();
    String response = await _storage.read(key: "user");
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response));
    } else {
      return null;
    }
  }

  static void storeBrightness(String s) async {
    final _storage = FlutterSecureStorage();
    await _storage.write(key: "bright", value: s);
  }

  static Future<bool> getBrightness() async {
    final _storage = FlutterSecureStorage();
    String res = await _storage.read(key: "bright");
    if (res != null) {
      return res == "true";
    }
    return false;
  }

  static Future clearall() async {
    final _storage = FlutterSecureStorage();
    await _storage.deleteAll();
  }

  static Future save(String user) async {
    print(user);
    final _storage = FlutterSecureStorage();
    await _storage.write(key: "user", value: user);
  }

  static Future languange(String languange) async {
    final _storage = FlutterSecureStorage();
    await _storage.write(key: "lang", value: languange);
  }

  static Future<Locale> getLanguange() async {
    final _storage = FlutterSecureStorage();

    String tag = await _storage.read(key: "lang");
    if (tag == null) {
      tag = "en";
    }
    return new Locale.fromSubtags(languageCode: tag);
  }

  static String generateString(Filed field) {
    return "\u2022 " + field.key + "-" + field.value + " ";
  }

  static String generateStringV2(List<Filed> field) {
    StringBuffer buffer = StringBuffer();
    if (field != null && field.isNotEmpty) {
      for (var item in field) {
        buffer.write("\u2022 " + item.value + " ");
      }
    } else {
      buffer.write(" ");
    }
    return buffer.toString();
  }

  static List<TextSpan> generateStringV3(List<Filed> field) {
    List<TextSpan> text = List();
    if (field != null && field.isNotEmpty) {
      for (var item in field) {
        text.add(TextSpan(
            text: " \u2022 ",
            style: TextStyle(
                fontSize: 16,
                color: config.Colors().statusGrayColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontFamily: 'open')));
        text.add(TextSpan(
            text: item.value,
            style: TextStyle(
                fontSize: 12,
                color: config.Colors().statusGrayColor,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
                fontFamily: 'open')));
      }
    }
    return text;
  }

  static String getImageUrl(String images) {
    String tempUrl = images.replaceAll("[", "");
    String url = tempUrl.replaceAll("]", "");
    if (url.contains(",")) {
      List<String> splitUrl = url.split(",");
      if (splitUrl.isNotEmpty) {
        url = splitUrl.first;
      }
    }
    return url;
  }

  static List<String> getAllImages(String images) {
    String tempUrl = images.replaceAll("[", "");
    String url = tempUrl.replaceAll("]", "");
    List<String> urls = List();
    if (url.contains(",")) {
      urls.addAll(url.split(","));
    } else {
      urls.add(url);
    }
    return urls;
  }

  static String generateOTP() {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var randomizer = new Random();
    var rNum = min + randomizer.nextInt(max - min);
    return rNum.toString();
  }

  static Color statusColor(String val) {
    if (val == "0") {
      return config.Colors().statusGrayColor;
    } else if (val == "1") {
      return config.Colors().statusBlueColor;
    } else if (val == "2") {
      return config.Colors().statusRedColor;
    } else if (val == "3") {
      return config.Colors().statusGreenColor;
    }
    return config.Colors().statusGrayColor;
  }

  static String status(BuildContext context, String val) {
    if (val == "0") {
      return S.of(context).pending;
    } else if (val == "1") {
      return S.of(context).confirmed;
    } else if (val == "2") {
      return S.of(context).rejected;
    } else if (val == "3") {
      return S.of(context).completed;
    }
    return S.of(context).pending;
  }

  static String _formattedDate(DateTime dateTime) {
    return dateformat.formatDate(
        dateTime, [dateformat.dd, '-', dateformat.M, '-', dateformat.yyyy]);
  }

  static String getDateTIme(DateTime dateTime, String time) {
    String dtime = _formattedDate(dateTime);
    if (time != null && time.trim().isNotEmpty) {
      dtime = dtime + ", " + time;
    }
    return dtime;
  }

  static openDetails(
      BuildContext context, FeaturedProductElement products) async {
    var map = Map();
    map["id"] = products.id;
    map["name"] = products.name;
    Navigator.of(context).pushNamed("/product_details", arguments: map);
  }
}
