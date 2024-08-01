# fiberchat_admin

## RELEASE NOTES v1.0.8 - 13th July 2021

- This update has lot many new Controls in the Usage Controls Section in the Settings Page. Following are the new Controls:

  - Added "IsCalltotallyHideFeature" switch
  - Added "Is24hrsTimeFormat" switch
  - Added "IsPercentindicatorShow" switch
  - Added "IsAllowCreatingGroups" switch
  - Added "IsAllowCreatingStatusStatus" switch.
  - Added "IsAllowCreatingBroadcasts" switch
  - Added "IsLogoutButtonShowInUserSettings" switch
  - Added "Max.FileSizeAllowed" field
  - Added "groupMemberLimit" field
  - Added "braodcastMemberLimit" field
  - Added "StatusDeleteTime" field
  - Added "feedbackEmail" field
  - Notification Section improved

- FOLLOWING FILES HAVE BEEN UPDATED IN THIS UPDATE:
  ○ android/app/build.gradle
  ○ lib/ADMIN_APP/Screens/account/AdminAccount.dart
  ○ lib/COMMONS/Screens/notifications/AllNotifications.dart
  ○ lib/COMMONS/Configs/Dbkeys.dart
  ○ lib/COMMONS/Configs/App_constants.dart
  ○ lib/COMMONS/Screens/users/ProfileDetails.dart
  ○ lib/ADMIN_APP/Screens/initialization/Setupdata.dart
  ○ lib/ADMIN_APP/Screens/settings/EditUserAppSettings.dart

  You can just replace the above files to integrate update. However, It is always RECOMMENDED to clone the whole project to ensure you might not miss out any new feature updated in the latest source code.

## Please refer to the Installation Guide provided in the Source Code Package for quick & easy installation.

PLEASE DONT FORGET TO FILL INFORMATION IN ALL THESE FILES FOR INSTALLATION:

1. .firebaserc
2. add key.jks inside android folder
3. fill - key.properties
4. google-services file download from firebase for android and ios
5. fill info in - app_constants.dart inside lib/config

## PLEASE NOTE: Controls in Settings Page related to Broadcast feature will only work if you have custom Broadcast feature integrated in User app.

## Thank you for using Fiberchat Admin.
