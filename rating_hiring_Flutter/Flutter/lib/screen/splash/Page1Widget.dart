import 'package:flutter/material.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';

class Page1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          width: config.App(context).appWidth(100),
          height: config.App(context).appHeight(100),
          child: Image.asset(
            "assets/img/splash/intro_1_home.webp",
            fit: BoxFit.fill,
            width: config.App(context).appWidth(100),
            height: config.App(context).appHeight(100),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Image.asset(
                "assets/img/splash/logo.png",
                width: 150,
                height: 150,
              ),
              Text(
                S.of(context).rentors,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Text(
                  S.of(context).hireACarBikeMore,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: Text(
                    S.of(context).chooseFromARangeOfCarsEnjoyYourDriveTravel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
