import 'dart:math';

import 'package:flutter/material.dart' as mat;
import 'package:flutter/material.dart';
import 'package:rentors/HexColor.dart';

class App {
  mat.BuildContext _context;
  double _height;
  double _width;
  double _originalWidth;
  double _heightPadding;
  double _widthPadding;
  // double _pixelRatio;

  App(_context) {
    this._context = _context;
    mat.MediaQueryData _queryData = mat.MediaQuery.of(this._context);
    // _pixelRatio = _queryData.devicePixelRatio;
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _originalWidth = _queryData.size.width;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }

  double aspectRatioValue(double v) {
    print("aspectRatioValue");
    print(_originalWidth);
    print(_originalWidth / v);
    return _originalWidth / v;
  }
}

class Colors {
  Color mainColor = mat.Colors.white;
  Color mainDarkColor = Color(0xFFF26D42);
  Color secondColor = Color(0xFF344968);
  Color secondDarkColor = Color(0xFFccccdd);
  Color accentColor = Color(0xFF8C98A8);
  Color accentDarkColor = Color(0xFF9999aa);
  Color scaffoldDarkColor = Color(0xFF2C2C2C);
  Color scaffoldColor = Color(0xFFFAFAFA);
  Color yellow = Color(0xFFF26D42);
  Color greenColor = Color(0xFF00A03E);
  Color white = mat.Colors.white;
  Color orangeColor = Color(0xFFF26D42);
  Color buttonThemeColor = Color(0xFFFF4E6A);
  Color buttonThemeDardColor = Color(0xFFea5c44);
  Color featuredColor = HexColor("#56cebf");
  Color statusGrayColor = HexColor("#969696");
  Color statusRedColor = HexColor("#FF0000");
  Color statusBlueColor = HexColor("#0064FF");
  Color statusGreenColor = HexColor("#56cebf");
  Color colorF26d42 = Color(0xFFF26D42);
  Color colorFff4f29 = Color(0xFFFF4F29);
  Color colorF25c37 = Color(0xFFF25C37);
  Color color545454 = Color(0xFF545454);
  Color colorF3f3f3 = Color(0xFFF3F3F3);
  Color colorF25432 = Color(0xFFF25432);
  Color colorF19058 = Color(0xFFF19058);
  Color color1C1E28 = Color(0xFF1C1E28);
  Color color1ABE5B = Color(0xFF1ABE5B);
  Color colorEBEBEB = Color(0xFFEBEBEB);
  Color colorFE2B2B = Color(0xFFFE2B2B);
  Color colorF25633 = Color(0xFFF25633);
  Color color33D243 = Color(0xFF33D243);
  Color colorFFA200 = Color(0xFFFFA200);
  Color colorF25321 = Color(0xFFF25321);
  Color color00A03E = Color(0xFF00A03E);

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
