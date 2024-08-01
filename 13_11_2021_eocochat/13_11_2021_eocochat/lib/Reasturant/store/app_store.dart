import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/language/AppLocalizations.dart';
import 'package:fiberchat/Reasturant/language/Languages.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/utils/colors.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  String selectedLanguage = "";

  @observable
  bool isNotificationOn = true;

  @observable
  bool isDarkMode = false;

  @observable
  bool isLoading = false;

  @observable
  String userProfileImage = '';

  @observable
  String userFullName = '';

  @observable
  String userEmail = '';

  @observable
  String userId = '';

  @action
  void setUserProfile(String image) {
    userProfileImage = image;
  }

  @action
  void setUserId(String val) {
    userId = val;
  }

  @action
  void setUserEmail(String email) {
    userEmail = email;
  }

  @action
  void setFullName(String name) {
    userFullName = name;
  }

  @action
  Future<void> setLoggedIn(bool val) async {
    isLoggedIn = val;
    await setValue(SharePreferencesKey.IS_LOGGED_IN, val);
  }

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  void setNotification(bool val) {
    isNotificationOn = val;

    setValue(SharePreferencesKey.IS_NOTIFICATION_ON, val);
  }

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = viewLineColor;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.white12;

      setStatusBarColor(scaffoldSecondaryDark);
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = primaryColor;
      shadowColorGlobal = Colors.black12;

      setStatusBarColor(Colors.white);
    }
  }

  @action
  Future<void> setLanguage(String aCode, {BuildContext? context}) async {
    selectedLanguageDataModel = getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage);
    selectedLanguage = getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage)!.languageCode!;
    log("Selected language ${selectedLanguage}");
    if (context != null) language = BaseLanguage.of(context)!;
    language = await   AppLocalizations().load(Locale(selectedLanguage));
  }
}
