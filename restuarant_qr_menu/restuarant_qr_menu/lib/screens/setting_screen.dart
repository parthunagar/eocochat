import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/screens/about_screen.dart';
import 'package:qr_menu/screens/change_password_screen.dart';
import 'package:qr_menu/screens/edit_profile_screen.dart';
import 'package:qr_menu/screens/language_screen.dart';
import 'package:qr_menu/screens/theme_screen.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      setStatusBarColor(context.scaffoldBackgroundColor);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget trailingIcon({bool? isVersion}) {
    if (isVersion.validate()) {
      return Row(
        children: [
          SnapHelperWidget(
            future: PackageInfo.fromPlatform(),
            onSuccess: (PackageInfo snap) {
              return Text(snap.version, style: secondaryTextStyle());
            },
          ),
          8.width,
          Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
        ],
      );
    } else {
      return Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('', color: context.scaffoldBackgroundColor, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language.lblSettings, style: boldTextStyle(size: 34)).paddingSymmetric(horizontal: 16),
            16.height,
            SettingItemWidget(
              title: '${language.lblEditProfile}',
              leading: Icon(LineIcons.edit, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                push(EditProfileScreen());
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: Icon(Icons.password_sharp, size: 20),
              title: '${language.lblChangePassword}',
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                if (getBoolAsync(SharePreferencesKey.IS_EMAIL_LOGIN)) {
                  push(ChangePasswordScreen());
                } else {
                  toast(language.lblUserLoginWithSocialAccountCannotChangeThePassword);
                }
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: Icon(FontAwesome.language, color: context.iconColor),
              title: "${language.lblLanguage}",
              titleTextStyle: boldTextStyle(size: 16),
              trailing: Row(
                children: [
                  TextIcon(
                    text: selectedLanguageDataModel!.name.validate(),
                    prefix: Image.asset(selectedLanguageDataModel!.flag.validate(), width: 24, height: 24),
                  ),
                  8.width,
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                ],
              ),
              onTap: () {
                push(LanguageScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
              },
            ),
            Observer(
              builder: (_) => SettingItemWidget(
                title: language.lblDarkMode,
                leading: Icon(!appStore.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, size: 20),
                titleTextStyle: boldTextStyle(size: 16),
                onTap: () {
                  push(ThemeScreen(), pageRouteAnimation: PageRouteAnimation.Slide);

                },
                trailing: trailingIcon(),
              ),
            ),
            SettingItemWidget(
              title: language.lblPrivacyPolicy,
              leading: Icon(Icons.privacy_tip_outlined, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              trailing: trailingIcon(),
              onTap: () {
                launch(Urls.appShareURL);
              },
            ),
            SnapHelperWidget<PackageInfo>(
              onSuccess:(d)=> SettingItemWidget(
                leading: Icon(Icons.rate_review_outlined, size: 20),
                titleTextStyle: boldTextStyle(size: 16),
                title: language.lblRateUs,
                onTap: () {
                  launch('$playStoreBaseURL${d.packageName}');
                },
                trailing: trailingIcon(),
              ), future: PackageInfo.fromPlatform(),
            ),
            SettingItemWidget(
              leading: Icon(LineIcons.file, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              title: language.lblTerms,
              onTap: () {
                launchUrl(Urls.termsAndConditionURL);
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: Icon(Icons.share_outlined, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              title: language.lblShare,
              onTap: () {
                Share.share(
                  'Share ${AppConstant.appName} app\n\n${AppConstant.appDescription}\n\n$playStoreBaseURL${Urls.packageName}',
                );
              },
            ),
            SettingItemWidget(
              title: language.lblAbout,
              leading: Icon(Icons.perm_device_info, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                AboutScreen().launch(context);
              },
              trailing: trailingIcon(isVersion: true),
            ),
            SettingItemWidget(
              leading: Icon(Icons.login_outlined, size: 20),
              title: language.lblLogout,
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                showConfirmDialogCustom(
                  context,
                  primaryColor: appStore.isDarkMode ? Colors.white : primaryColor,
                  dialogType: DialogType.CONFIRMATION,
                  title: '${language.lblAreYouSureYouWantToLogout}?',
                  onAccept: (context) {
                    hideKeyboard(context);
                    toast(language.lblVisitAgain);
                    authService.logout(context);
                  },
                );
              },
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
