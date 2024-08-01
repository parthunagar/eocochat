import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage? of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage);

  String get lblLanguage;

  String get lblUpdateIngredient;

  String get lblAddIngredient;

  String get lblName;

  String get lblCancel;

  String get lblUpdate;

  String get lblAdd;

  String get lblPleaseAddIngredient;

  String get lblNew;

  String get lblCategories;

  String get lblLongPressOnCategoryForMoreOptions;

  String get lblA;

  String get lblAll;

  String get lblChooseCurrencySymbol;

  String get lblSelect;

  String get lblCamera;

  String get lblGallery;

  String get lblForgetPassword;

  String get lblEnterYouEmail;

  String get lblEmail;

  String get lblEnterValidEmail;

  String get lblResetPassword;

  String get lblResetPasswordLinkHasSentYourMail;

  String get lblEnable;

  String get lblDisable;

  String get lblTextForDeletingCategory;

  String get lblWrongSelection;

  String get lblEdit;

  String get lblDelete;

  String get lblSpicy;

  String get lblJain;

  String get lblSpecial;

  String get lblPopular;

  String get lblShowMore;

  String get lblShowLess;

  String get lblFoodItems;

  String get lblMenuItems;

  String get lblNoMenuFor;

  String get lblCategory;

  String get lblNoData;

  String get lblLight;

  String get lblDark;

  String get lblSystemDefault;

  String get lblSelectYourTheme;

  String get lblAbout;

  String get lblRestaurantQRMenu;

  String get lblVersion;

  String get lblAboutScreenText;

  String get lblPurchase;

  String get lblAddImage;

  String get lblChooseAnAction;

  String get lblAddCategory;

  String get lblDoYouWantToUpdate;

  String get lblDoYouWantToAddThisCategory;

  String get lblDescription;

  String get lblAddMenuItem;

  String get lblDoYouWantToDelete;

  String get lblDoYouWantToAddThisMenuItem;

  String get lblPleaseChooseCategory;

  String get lblChooseCategory;

  String get lblPrice;

  String get lblIngredients;

  String get lblNewDescription;

  String get lblVeg;

  String get lblVegDescription;

  String get lblSpicyDescription;

  String get lblJainDescription;

  String get lblSpecialDescription;

  String get lblSweet;

  String get lblSweetDescription;

  String get lblPopularDescription;

  String get lblAddLogoImage;

  String get lblAddRestaurantImage;

  String get lblUpdateRestaurant;

  String get lblAddRestaurant;

  String get lblDoYouWantToUpdateRestaurant;

  String get lblDoYouWantToAddRestaurant;

  String get lblType;

  String get lblNonVeg;

  String get lblContact;

  String get lblCurrency;

  String get lblNewItemValidity;

  String get lblAddress;

  String get lblPasswordSuccessfullyChanged;

  String get lblOldPassword;

  String get lblOldPasswordIsNotCorrect;

  String get lblNewPassword;

  String get lblConfirmPassword;

  String get lblPasswordLengthShouldBeMoreThanSix;

  String get lblBothPasswordShouldBeMatched;

  String get lblOldPasswordShouldNotBeSameAsNewPassword;

  String get lblSave;

  String get lblHello;

  String get lblMyItems;

  String get lblNoRestaurant;

  String get lblDataUpdated;

  String get lbDoYouWantToUpdateProfile;

  String get lblEditProfile;

  String get lblNumber;

  String get lblTryAgain;

  String get lblQR;

  String get lblScanForOurOnlineMenu;

  String get lblUhOhSomethingWentWrong;

  String get lblScanned;

  String get lblWrongQRCode;

  String get lblNoPermission;

  String get lblDoYouWantToDeleteRestaurant;

  String get lblSettings;

  String get lblChangePassword;

  String get lblUserLoginWithSocialAccountCannotChangeThePassword;

  String get lblDarkMode;

  String get lblPrivacyPolicy;

  String get lblRateUs;

  String get lblTerms;

  String get lblShare;

  String get lblLogout;

  String get lblAreYouSureYouWantToLogout;

  String get lblVisitAgain;

  String get lblPleaseEnterYourEmail;

  String get lblPleaseEnterYourPassword;

  String get lblPassword;

  String get lblForgotPassword;

  String get lblSignIn;

  String get lblDontHaveAnAccount;

  String get lblCreateAccountHere;

  String get lblOR;

  String get lblSignUp;

  String get lblPleaseEnterName;

  String get lblPleaseEnterPhoneNumber;

  String get lblPhoneNumber;

  String get lblPleaseEnterEmail;

  String get lblPleasEnterPassword;

  String get lblAlreadyHaveAccount;

  String get lblSignInHere;

  String get lblGoPaperless;

  String get lblGoPaperlessWithOurDigitalMenu;

  String get lblGetStarted;

  String get lblWaitToScan;

  String get lblUserAlreadyRegisterWithEmail;

  String get lblWrongURL;

  String get lblRemoveImage;

  String get lblSelectLanguage;

  String get lblSelectTheme;

  String get lblChangeRestaurantImage;

  String get lblChangeLogoImage;

  String get lblSelectThemeDesc;

  String get lblSelectLanguageDesc;
}
