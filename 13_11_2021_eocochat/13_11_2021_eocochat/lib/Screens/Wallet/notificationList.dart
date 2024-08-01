import 'package:fiberchat/Configs/Enum.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Screens/calling_screen/pickup_layout.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: PickupLayout(
          scaffold: Fiberchat.getNTPWrappedWidget(
              Scaffold(
                  body: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                        elevation: 5,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(color: eocochatYellow, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 24,
                                  color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack,
                                ),
                              ),
                              new Text(
                                getTranslated(context, 'notifications'),
                                // 'Notifications',
                                style: TextStyle(fontSize: 20.0, color: DESIGN_TYPE == Themetype.whatsapp ? eocochatWhite : eocochatBlack, fontWeight: FontWeight.w600,),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        height: h * 0.87,
                        padding: EdgeInsets.only(left: w * 0.04,right: w * 0.04,top: h * 0.02 ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount:  20,
                          itemBuilder: (context,indx){
                            return Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: w *0.02, vertical: h * 0.01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Spotify',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                        SizedBox(height: h*0.006),
                                        Text('10 Oct,9:00 PM'),
                                      ],),
                                    Text('$eocoChatCurrency 10.00',style: TextStyle(fontSize: h*0.025,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            );
                          }),
                      ),
                    ],
                  )))),
    );
  }
}
