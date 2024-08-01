//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/Enum.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Screens/splash_screen/splash_screen.dart';
import 'package:fiberchat/Services/Providers/BroadcastProvider.dart';
import 'package:fiberchat/Services/Providers/AvailableContactsProvider.dart';
import 'package:fiberchat/Services/Providers/GroupChatProvider.dart';
import 'package:fiberchat/Services/Providers/Observer.dart';
import 'package:fiberchat/Services/Providers/StatusProvider.dart';
import 'package:fiberchat/Services/Providers/currentchat_peer.dart';
import 'package:fiberchat/Services/Providers/seen_provider.dart';
import 'package:fiberchat/Services/localization/demo_localization.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Screens/homepage/homepage.dart';
import 'package:fiberchat/Services/Providers/DownloadInfoProvider.dart';
import 'package:fiberchat/Services/Providers/call_history_provider.dart';
import 'package:fiberchat/Services/Providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart' as fd;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

//TODO : BIT BUCKET LINK : https://bitbucket.org/flutterappmobileteam/eocochat-latest/src/master/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (DESIGN_TYPE == Themetype.messenger) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:
            Color(0XFFFFFFFF), //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
  }

  //TODO: Enable Firebase Storage Locally
  try {
    FirebaseApp? app = await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
        databaseURL: '',
      ),
      name: 'EocoChat',
    );

    // final DatabaseReference db = FirebaseDatabase(app: app).reference();
    // db.child('ecochat-83b77').once().then((result){
    //   print('result = $result');
    // }).onError((error, stackTrace) {
    //   print('error = $error');
    // });

    final FirebaseDatabase database = FirebaseDatabase(app: app);
    // fd.FirebaseDatabase database = fd.FirebaseDatabase();
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  } catch (e) {
    print('FirebaseApp ERROR : $e');
  }

  if (IsBannerAdShow == true ||
      IsInterstitialAdShow == true ||
      IsVideoAdShow == true) {
    MobileAds.instance.initialize();
  }

  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  binding.renderView.automaticSystemUiAdjustment = false;

  runApp(OverlaySupport(child: FiberchatWrapper()));
}

class FiberchatWrapper extends StatefulWidget {
  const FiberchatWrapper({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _FiberchatWrapperState state =
        context.findAncestorStateOfType<_FiberchatWrapperState>()!;
    state.setLocale(newLocale);
  }

  @override
  _FiberchatWrapperState createState() => _FiberchatWrapperState();
}

class _FiberchatWrapperState extends State<FiberchatWrapper> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      print('setLocale => _locale : $_locale');
    });
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseGroupServices firebaseGroupServices = FirebaseGroupServices();
    final FirebaseBroadcastServices firebaseBroadcastServices =
        FirebaseBroadcastServices();
    if (this._locale == null) {
      return Container(
          child: Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color?>(Colors.blue[800]))));
    } else {
      return FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(' ========> firebase internet ERROR <======== ');
              return Text('ERROR OCCURED WHILE INITIALIZING FIREBASE',
                  textDirection: TextDirection.ltr);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder:
                      (context, AsyncSnapshot<SharedPreferences> snapshot) {
                    if (snapshot.hasData) {
                      return MultiProvider(
                        providers: [
                          // TODO:---- REMOVE BROADCAST FEATURE IF NOT NEEDED --------
                          ChangeNotifierProvider(
                              create: (_) =>
                                  FirestoreDataProviderMESSAGESforBROADCASTCHATPAGE()),
                          //---
                          ChangeNotifierProvider(
                              create: (_) => StatusProvider()),
                          ChangeNotifierProvider(
                              create: (_) =>
                                  FirestoreDataProviderMESSAGESforGROUPCHAT()),
                          ChangeNotifierProvider(
                              create: (_) => AvailableContactsProvider()),
                          ChangeNotifierProvider(create: (_) => Observer()),
                          Provider(create: (_) => SeenProvider()),
                          ChangeNotifierProvider(
                              create: (_) => DownloadInfoprovider()),
                          ChangeNotifierProvider(create: (_) => UserProvider()),
                          ChangeNotifierProvider(
                              create: (_) =>
                                  FirestoreDataProviderCALLHISTORY()),
                          ChangeNotifierProvider(
                              create: (_) => CurrentChatPeer()),
                        ],
                        child: StreamProvider<List<BroadcastModel>>(
                          initialData: [],
                          create: (BuildContext context) =>
                              firebaseBroadcastServices.getBroadcastsList(
                                  snapshot.data!.getString(Dbkeys.phone) ?? ''),
                          child: StreamProvider<List<GroupModel>>(
                            initialData: [],
                            create: (BuildContext context) =>
                                firebaseGroupServices.getGroupsList(
                                    snapshot.data!.getString(Dbkeys.phone) ??
                                        ''),
                            child: MaterialApp(
                              builder: (BuildContext? context, Widget? widget) {
                                ErrorWidget.builder =
                                    (FlutterErrorDetails errorDetails) {
                                  return CustomError(
                                      errorDetails: errorDetails);
                                };

                                return widget!;
                              },
                              theme: ThemeData(
                                  fontFamily: FONTFAMILY_NAME,
                                  primaryColor: fiberchatgreen,
                                  primaryColorLight: fiberchatgreen,
                                  indicatorColor: fiberchatLightGreen),
                              title: Appname,
                              debugShowCheckedModeBanner: false,

                              home: Homepage(
                                prefs: snapshot.data!,
                                currentUserNo:
                                    snapshot.data!.getString(Dbkeys.phone),
                                isSecuritySetupDone: snapshot.data!.getString(
                                            Dbkeys.isSecuritySetupDone) ==
                                        null
                                    ? false
                                    : ((snapshot.data!
                                                .getString(Dbkeys.phone) ==
                                            null)
                                        ? false
                                        : (snapshot.data!.getString(Dbkeys
                                                    .isSecuritySetupDone) ==
                                                snapshot.data!
                                                    .getString(Dbkeys.phone))
                                            ? true
                                            : false),
                              ),

                              // ignore: todo
                              //TODO:---- All localizations settings----
                              locale: _locale,
                              supportedLocales: supportedlocale,
                              localizationsDelegates: [
                                DemoLocalization.delegate,
                                GlobalMaterialLocalizations.delegate,
                                GlobalWidgetsLocalizations.delegate,
                                GlobalCupertinoLocalizations.delegate,
                              ],
                              localeResolutionCallback:
                                  (locale, supportedLocales) {
                                for (var supportedLocale in supportedLocales) {
                                  print('supportedLocale : $supportedLocale');
                                  print('supportedLocales : $supportedLocales');
                                  if (supportedLocale.languageCode ==
                                          locale!.languageCode &&
                                      supportedLocale.countryCode ==
                                          locale.countryCode) {
                                    print(
                                        'supportedLocale.languageCode : ${supportedLocale.languageCode}');
                                    print(
                                        'locale!.languageCode : ${locale.languageCode}');
                                    print(
                                        'supportedLocale.countryCode : ${supportedLocale.countryCode}');
                                    print(
                                        'locale.countryCode : ${locale.countryCode}');
                                    return supportedLocale;
                                  }
                                }
                                return supportedLocales.first;
                              },
                              //--- All localizations settings ended here----
                            ),
                          ),
                        ),
                      );
                    }
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (_) => UserProvider())
                      ],
                      child: MaterialApp(
                          theme: ThemeData(
                              fontFamily: FONTFAMILY_NAME,
                              primaryColor: fiberchatgreen,
                              primaryColorLight: fiberchatgreen,
                              indicatorColor: fiberchatLightGreen),
                          debugShowCheckedModeBanner: false,
                          home: Splashscreen()),
                    );
                  });
            }

            return MaterialApp(
                debugShowCheckedModeBanner: false, home: Splashscreen());
          });
    }
  }
}

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 0, width: 0);
  }
}
