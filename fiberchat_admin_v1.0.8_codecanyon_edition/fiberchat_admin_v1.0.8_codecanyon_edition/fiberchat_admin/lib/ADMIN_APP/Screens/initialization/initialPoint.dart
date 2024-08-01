import 'package:thinkcreative_technologies/ADMIN_APP/Screens/authentication/AdminAuth.dart';
import 'package:thinkcreative_technologies/COMMONS/Services/providers/CommonSession.dart';
import 'package:thinkcreative_technologies/COMMONS/Services/providers/ConnectivityServices.dart';
import 'package:thinkcreative_technologies/COMMONS/Services/providers/FirestoreCOLLECTIONDataProvider.dart';
import 'package:thinkcreative_technologies/COMMONS/Services/providers/FirestoreDOCUMENTDataProvider.dart';
import 'package:thinkcreative_technologies/COMMONS/Services/providers/Observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/COMMONS/Services/providers/BottomNavBar.dart';
import 'package:thinkcreative_technologies/COMMONS/Services/providers/DownloadInfoProvider.dart';

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MultiProvider for top-level services that can be created right away
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Observer>(
            create: (BuildContext context) {
              return Observer();
            },
          ),

          ChangeNotifierProvider<FirestoreDataProviderUSERS>(
            create: (BuildContext context) {
              return FirestoreDataProviderUSERS();
            },
          ),
          ChangeNotifierProvider<FirestoreDataProviderCALLHISTORY>(
            create: (BuildContext context) {
              return FirestoreDataProviderCALLHISTORY();
            },
          ),
          ChangeNotifierProvider<FirestoreDataProviderDocNOTIFICATION>(
            create: (BuildContext context) {
              return FirestoreDataProviderDocNOTIFICATION();
            },
          ),

          ChangeNotifierProvider<CommonSession>(
            create: (BuildContext context) {
              return CommonSession();
            },
          ),
          ChangeNotifierProvider<DownloadInfoprovider>(
            create: (BuildContext context) {
              return DownloadInfoprovider();
            },
          ),
          //---- All the above providers are AUTHENTICATION PROVIDER -------

          ChangeNotifierProvider<BottomNavigationBarProvider>(
            create: (BuildContext context) {
              return BottomNavigationBarProvider();
            },
          ),
        ],
        child: StreamProvider<ConnectivityStatus>(
            initialData: ConnectivityStatus.Cellular,
            create: (context) =>
                ConnectivityService().connectionStatusController.stream,
            child: MaterialApp(
                debugShowCheckedModeBanner: false, home: AdminAauth())));
  }
}
