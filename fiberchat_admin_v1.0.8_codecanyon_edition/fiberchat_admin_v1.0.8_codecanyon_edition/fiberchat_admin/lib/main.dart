import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thinkcreative_technologies/ADMIN_APP/Screens/initialization/initialPoint.dart';
import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/COMMONS/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/COMMONS/Screens/splashScreen/SplashScreen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Mycolors.primary, //or set color with: Color(0xFF0000FF)
  ));
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  binding.renderView.automaticSystemUiAdjustment = false;
  // Fix for: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(AdminApp());
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _AppWrapperState state =
        context.findAncestorStateOfType<_AppWrapperState>()!;
    state.setLocale(newLocale);
  }

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue[800])),
        ),
      );
    } else {
      return FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('ERROR');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder:
                      (context, AsyncSnapshot<SharedPreferences> snapshot) {
                    if (snapshot.hasData) {
                      return AdminApp();
                    }
                    return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Splashscreen());
                  });
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splashscreen(),
            );
          });
    }
  }
}
