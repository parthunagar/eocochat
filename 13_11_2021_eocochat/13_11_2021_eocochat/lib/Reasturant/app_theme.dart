import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    //primarySwatch: createMaterialColor(colorPrimary),
    colorScheme: ColorScheme(
      primary: primaryColor,
      primaryVariant: createMaterialColor(primaryColor),
      secondary: secondaryColor,
      secondaryVariant: createMaterialColor(secondaryColor),
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.black,
      onError: Colors.redAccent,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Color(0xFFffd800),//TODO : CHANGE PRIMARY COLOR
    // scaffoldBackgroundColor:  Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white),
    iconTheme: IconThemeData(color: scaffoldSecondaryDark),
    textTheme: TextTheme(headline6: TextStyle()),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: viewLineColor,
    cardColor: Color(0xFFFCFAF9),
    dialogTheme: DialogTheme(shape: dialogShape()),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    // primarySwatch: createMaterialColor(colorPrimary),
    colorScheme: ColorScheme(
      primary: Colors.white,
      primaryVariant: createMaterialColor(Colors.white),
      secondary: Colors.white,
      secondaryVariant: createMaterialColor(Colors.white),
      surface: scaffoldColorDark,
      background: scaffoldColorDark,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.black,
      onError: Colors.redAccent,
      brightness: Brightness.light,
    ),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldColorDark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: scaffoldSecondaryDark),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(headline6: TextStyle(color: textSecondaryColor)),
    dialogBackgroundColor: scaffoldSecondaryDark,
    unselectedWidgetColor: Colors.white60,
    dividerColor: Colors.white12,
    cardColor: scaffoldSecondaryDark,

    dialogTheme: DialogTheme(shape: dialogShape()),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.white),
      checkColor: MaterialStateProperty.all(Colors.black),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.white),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),

    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
