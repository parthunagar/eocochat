import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/app_theme.dart';
import 'package:qr_menu/language/AppLocalizations.dart';
import 'package:qr_menu/language/Languages.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/screens/splash_screen.dart';
import 'package:qr_menu/screens/user_splash_screen.dart';
import 'package:qr_menu/screens/web_screen.dart';
import 'package:qr_menu/services/auth_service.dart';
import 'package:qr_menu/services/category_service.dart';
import 'package:qr_menu/services/menu_service.dart';
import 'package:qr_menu/services/restaurant_owner_service.dart';
import 'package:qr_menu/services/user_service.dart';
import 'package:qr_menu/store/app_store.dart';
import 'package:qr_menu/store/menu_store.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:url_strategy/url_strategy.dart';

//region Global Variables
FirebaseFirestore fireStore = FirebaseFirestore.instance;

AppStore appStore = AppStore();
MenuStore menuStore = MenuStore();

FirebaseStorage storage = FirebaseStorage.instance;
UserService userService = UserService();
RestaurantOwnerService restaurantOwnerService = RestaurantOwnerService();
MenuService menuService = MenuService();
AuthService authService = AuthService();
RestaurantModel selectedRestaurant = RestaurantModel();
CategoryService categoryService = CategoryService();

late BaseLanguage language;
//endregion

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  await Firebase.initializeApp();

  defaultRadius = 30.0;
  defaultAppButtonRadius = 30.0;
  defaultLoaderAccentColorGlobal = primaryColor;

  await initialize(aLocaleLanguageList: languageList());

  appStore.setLoggedIn(getBoolAsync(SharePreferencesKey.IS_LOGGED_IN));
  if (appStore.isLoggedIn) {
    appStore.setUserId(getStringAsync(SharePreferencesKey.USER_ID));
    appStore.setFullName(getStringAsync(SharePreferencesKey.USER_NAME));
    appStore.setUserEmail(getStringAsync(SharePreferencesKey.USER_EMAIL));
    appStore.setUserProfile(getStringAsync(SharePreferencesKey.USER_IMAGE));
  }

  appButtonBackgroundColorGlobal = primaryColor;

  if (!isWeb) {
    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == AppThemeMode.ThemeModeLight) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == AppThemeMode.ThemeModeDark) {
      appStore.setDarkMode(true);
    }
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        scrollBehavior: SBehavior(),
        navigatorKey: navigatorKey,
        title: AppConstant.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: isWeb ? WebScreen() : SplashScreen(),
        onGenerateRoute: (settings) {
          List<String> pathComponents = settings.name!.split('/');
          if (pathComponents[1].isNotEmpty) {
            return MaterialPageRoute(
              builder: (context) => UserSplashScreen(result: pathComponents[1]),
              settings: RouteSettings(
                name: '/${pathComponents[1]}',
              ),
            );
          }

          /*log(settings.name);
          if (settings.name!.contains(mBaseURL)) {
            List<String> pathComponents = settings.name!.split('/');

            if (pathComponents[1].isNotEmpty) {
              return MaterialPageRoute(
                builder: (context) => UserSplashScreen(result: pathComponents[1]),
                settings: RouteSettings(
                  name: '/${pathComponents[1]}',
                ),
              );
            }
          } else {
            toast(language.lblWrongURL);
          }*/
        },
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [AppLocalizations(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguage.validate(value: AppConstant.defaultLanguage)),
      ),
    );
  }
}
