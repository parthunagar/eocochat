import 'package:nb_utils/nb_utils.dart';

const mBaseURL = 'https://restaurant-qr-menu-606f0.web.app/';
const mCodeCanyonURL = 'https://codecanyon.net/user/iqonicdesign/portfolio';

class AppConstant {
  static const appName = "QR Menu";
  static const appDescription = 'QR Menu is a well equipped Flutter app. On the user end, it offers the user a simple way to view the menu of a restaurant without even confronting the waiter. It offers an easy, manageable & on-the-go methodology of menu viewing process. While, on the restaurant owner end, the app offers a conventional and easily manageable method to manage restaurants, food categories and menus';
  //TODO : change default language - 15/03/2022
  // static const defaultLanguage =  'en';//'fr';
  static const defaultLanguage =  'fr';
}

class AppThemeMode {
  static const ThemeModeLight = 1;
  static const ThemeModeDark = 2;
  static const ThemeModeSystem = 0;
}

class SharePreferencesKey {
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const USER_ID = 'USER_ID';
  static const USER_NAME = 'USER_NAME';
  static const USER_NUMBER = 'USER_NUMBER';
  static const USER_EMAIL = 'USER_EMAIL';
  static const USER_IMAGE = 'USER_IMAGE';
  static const IS_EMAIL_LOGIN = 'IS_EMAIL_LOGIN';
  static const PASSWORD = "PASSWORD";
  static const Language = "Language";

  static const IS_NOTIFICATION_ON = "IS_NOTIFICATION_ON";
  static const IS_WALKED_THROUGH = "IS_WALKED_THROUGH";
}

class AppImages {
  static const placeHolderImage = "assets/images/place_holder.jpg";
  static const app_logo = "assets/images/app_icon.jpg";
  static const app_logo_dark = "assets/images/app_icon_dark.jpg";
  static const noDataImage = "assets/images/no_data.png";
  static const empty_image_placeholder = "assets/images/empty_image_placeholder.jpg";
  static const paperLess = "assets/images/paper.png";
  static const language = "assets/images/language.png";
  static const theme = "assets/images/theme.png";
}

class MenuTypeName {
  static const news = "New";
  static const spicy = "Spicy";
  static const jain = "Jain";
  static const special = "Special";
  static const popular = "Popular";
  static const sweet = "Sweet";
}

class MenuTypeImage {
  static const newImage = "images/new1.png";
  static const spicyImage = "images/spicy1.png";
  static const jainImage = "images/jain.png";
  static const specialImage = "images/special1.png";
  static const popularImage = "images/popular1.png";
}

class Urls {
  static const appDescription = "";
  static const copyRight = 'copyright @2021 Qr Menu';
  static const packageName = "com.iqonic.qrmenu";
  // static const termsAndConditionURL = 'https://www.google.com/';
  static const termsAndConditionURL = 'https://eocochat.com/fr.termes_et_conditions.html';
  static const supportURL = 'https://iqonic.desky.support/';
  // static const codeCanyonURL = 'https://codecanyon.net/item/restaurant-qr-menu-flutter-app-with-firebase-backend/34377503?s_rank=1';
  static const codeCanyonURL = 'https://eocochat.com/';
  static const appShareURL = '$playStoreBaseURL$packageName';
  static const mailto = 'hello@iqonic.design';
  static const documentation = 'https://wordpress.iqonic.design/docs/product/qrmenu/';
  static const appPrivacyPolicy = 'https://eocochat.com/fr.app-Politique_de_confidentialit%C3%A9.html';
}

enum FileType { CANCEL, CAMERA, GALLERY }
enum MenuType { IS_NEW, IS_SPICY, IS_JAIN, IS_SPECIAL, IS_POPULAR }
enum RestaurantType { IS_VEG, IS_NON_VEG }

const LoginTypeApple = 'apple';
