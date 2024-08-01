//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'dart:ui';
import 'package:fiberchat/Configs/Enum.dart';
import 'package:flutter/material.dart';

// -----App Currency -----------/
final eocoChatCurrency = 'XFA';// '\€';

//*--App Colors : Replace with your own colours---
final eocochatBlack = new Color(0xFF1E1E1E);
final eocochatBlue = new Color(0xFF25D366);
final eocochatDeepGreen = new Color(0xFF075E54);
final eocochatLightGreen = new Color(0xFF23c86e);
final eocochatYellow = new Color(0xFFffd800);
final eocochatBubblechatYellow = new Color(0xFFEEF41F);
final eocochatgreen = new Color(0xFF128C7E);
final eocochatteagreen = new Color(0xFFDCF8C6);
final eocochatWhite = Colors.white;
final eocochatGrey = Colors.grey;
final eocochatChatbackground = new Color(0xffdde6ea);
final eocochatRed = Colors.red;
// final eocochatAmber = Colors.amber;
final eocochatBlackOpacity = Colors.black12;
final eocochatTransparent = Colors.transparent;

//-*********---------- MESSENGER Color Theme: ---------------// Remove below comments for Messenger theme //------------
final fiberchatBlack = new Color(0xFF353f58);
final fiberchatBlue = new Color(0xFFebc600);
final fiberchatDeepGreen = new Color(0xFF353f58);
final fiberchatLightGreen = new Color(0xFF353f58);
final fiberchatgreen = new Color(0xFFebc600);
final fiberchatteagreen = new Color(0xFFeefcf8);
final fiberchatWhite = Colors.white;
final fiberchatGrey = Colors.grey;
final fiberchatChatbackground = new Color(0xffdde6ea);
const DESIGN_TYPE = Themetype.messenger;
const IsSplashOnlySolidColor = false;
const SplashBackgroundSolidColor = Color(0xFFFFD800); //applies this colors if "IsSplashOnlySolidColor" is set to true. Color Code: 0xFF005f56 for Whatsapp theme & 0xFFFFFFFF for messenger theme.

//*--Admob Configurations- (By default Test Ad Units pasted)----------
const IsBannerAdShow = false; // Set this to 'true' if you want to show Banner ads throughout the app
const Admob_BannerAdUnitID_Android = ''; // Test Id: 'ca-app-pub-3940256099942544/6300978111'
const Admob_BannerAdUnitID_Ios = ''; // Test Id: 'ca-app-pub-3940256099942544/2934735716'
const IsInterstitialAdShow = false; // Set this to 'true' if you want to show Interstitial ads throughout the app
const Admob_InterstitialAdUnitID_Android = ''; // Test Id:  'ca-app-pub-3940256099942544/1033173712'
const Admob_InterstitialAdUnitID_Ios = ''; // Test Id: 'ca-app-pub-3940256099942544/4411468910'
const IsVideoAdShow = false; // Set this to 'true' if you want to show Video ads throughout the app
const Admob_RewardedAdUnitID_Android = ''; // Test Id: 'ca-app-pub-3940256099942544/5224354917'
const Admob_RewardedAdUnitID_Ios = ''; // Test Id: 'ca-app-pub-3940256099942544/1712485313'
//Also don't forget to Change the Admob App Id in "fiberchat/android/app/src/main/AndroidManifest.xml" & "fiberchat/ios/Runner/Info.plist"

//*--Agora Configurations---
const Agora_APP_IDD = '9a5855e0bcc74b5ba66f4c3f4e35122b'; //eocochat  // Grab it from: https://www.agora.io/en/
const dynamic Agora_TOKEN = null; // not required until you have planned to setup high level of authentication of users in Agora.

//*--Giphy Configurations---
const GiphyAPIKey = 'Dh9Su6kwNkkBlNaeSzMSb1XSGXH5zD5y'; //eocochat // Grab it from: https://developers.giphy.com/

//*--App Configurations---
const Appname = 'Eocochat'; //app name shown evrywhere with the app where required
//TODO: change default county code : 15/03/2022
const DEFAULT_COUNTTRYCODE_ISO = 'FR'; //default country ISO 2 letter for login screen
const DEFAULT_COUNTTRYCODE_NUMBER = '+33'; //default country code number for login screen
// const DEFAULT_COUNTTRYCODE_ISO = 'CM'; //default country ISO 2 letter for login screen
// const DEFAULT_COUNTTRYCODE_NUMBER = '+237'; //default country code number for login screen
const FONTFAMILY_NAME = null; // make sure you have registered the font in pubspec.yaml

//--WARNING----- PLEASE DONT EDIT THE BELOW LINES UNLESS YOU ARE A DEVELOPER -------
const SplashPath = 'assets/images/splash.jpeg';
const AppLogoPath = 'assets/images/applogo.png';

//------ RazorPay ------------//
const razorPayKey = 'rzp_test_bZs7BBsQi57mhe';


//-----Stripe Pay-----//
String? stripePublishKey = '';
String? stripeSecretKey = '';