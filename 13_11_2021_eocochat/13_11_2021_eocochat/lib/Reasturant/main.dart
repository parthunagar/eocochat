import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/app_theme.dart';
import 'package:fiberchat/Reasturant/language/AppLocalizations.dart';
import 'package:fiberchat/Reasturant/language/Languages.dart';
import 'package:fiberchat/Reasturant/models/restaurant_model.dart';
import 'package:fiberchat/Reasturant/screens/splash_screen.dart';
import 'package:fiberchat/Reasturant/screens/user_splash_screen.dart';
import 'package:fiberchat/Reasturant/screens/web_screen.dart';
import 'package:fiberchat/Reasturant/services/auth_service.dart';
import 'package:fiberchat/Reasturant/services/category_service.dart';
import 'package:fiberchat/Reasturant/services/menu_service.dart';
import 'package:fiberchat/Reasturant/services/restaurant_owner_service.dart';
import 'package:fiberchat/Reasturant/services/user_service.dart';
import 'package:fiberchat/Reasturant/store/app_store.dart';
import 'package:fiberchat/Reasturant/store/menu_store.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';
import 'package:fiberchat/Reasturant/utils/common.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';
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
        },
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [AppLocalizations(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguage.validate(value: AppConstant.defaultLanguage)),
      ),
    );
  }
}
