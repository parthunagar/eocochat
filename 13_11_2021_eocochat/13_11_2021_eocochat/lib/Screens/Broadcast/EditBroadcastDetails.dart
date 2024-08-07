//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/Dbpaths.dart';
import 'package:fiberchat/Configs/Enum.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Services/Admob/admob.dart';
import 'package:fiberchat/Services/Providers/Observer.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Screens/calling_screen/pickup_layout.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class EditBroadcastDetails extends StatefulWidget {
  final String? broadcastName;
  final String? broadcastDesc;
  final String? broadcastID;
  final String currentUserNo;
  final bool isadmin;
  EditBroadcastDetails(
      {this.broadcastName,
      this.broadcastDesc,
      required this.isadmin,
      this.broadcastID,
      required this.currentUserNo});
  @override
  State createState() => new EditBroadcastDetailsState();
}

class EditBroadcastDetailsState extends State<EditBroadcastDetails> {
  TextEditingController? controllerName = new TextEditingController();
  TextEditingController? controllerDesc = new TextEditingController();

  bool isLoading = false;

  final FocusNode focusNodeName = new FocusNode();
  final FocusNode focusNodeDesc = new FocusNode();

  String? broadcastTitle;
  String? broadcastDesc;
  final BannerAd myBanner = BannerAd(
    adUnitId: getBannerAdUnitId()!,
    size: AdSize.mediumRectangle,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  AdWidget? adWidget;
  @override
  void initState() {
    super.initState();
    Fiberchat.internetLookUp();
    broadcastDesc = widget.broadcastDesc;
    broadcastTitle = widget.broadcastName;
    controllerName!.text = broadcastTitle!;
    controllerDesc!.text = broadcastDesc!;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final observer = Provider.of<Observer>(this.context, listen: false);
      if (IsBannerAdShow == true && observer.isadmobshow == true) {
        myBanner.load();
        adWidget = AdWidget(ad: myBanner);
        setState(() {});
      }
    });
  }

  void handleUpdateData() {
    focusNodeName.unfocus();
    focusNodeDesc.unfocus();

    setState(() {
      isLoading = true;
    });
    broadcastTitle =
        controllerName!.text.isEmpty ? broadcastTitle : controllerName!.text;
    broadcastDesc = controllerDesc!.text.isEmpty ? '' : controllerDesc!.text;
    setState(() {});
    FirebaseFirestore.instance
        .collection(DbPaths.collectionbroadcasts)
        .doc(widget.broadcastID)
        .update({
      Dbkeys.broadcastNAME: broadcastTitle,
      Dbkeys.broadcastDESCRIPTION: broadcastDesc,
    }).then((value) async {
      DateTime time = DateTime.now();
      await FirebaseFirestore.instance
          .collection(DbPaths.collectionbroadcasts)
          .doc(widget.broadcastID)
          .collection(DbPaths.collectionbroadcastsChats)
          .doc(time.millisecondsSinceEpoch.toString() +
              '--' +
              widget.currentUserNo)
          .set({
        Dbkeys.broadcastmsgCONTENT: widget.isadmin
            ? getTranslated(context, 'broadcastupdatedbyadmin')
            : '${widget.currentUserNo} ${getTranslated(context, 'updatedbroadcast')}',
        Dbkeys.broadcastmsgLISToptional: [],
        Dbkeys.broadcastmsgTIME: time.millisecondsSinceEpoch,
        Dbkeys.broadcastmsgSENDBY: widget.currentUserNo,
        Dbkeys.broadcastmsgISDELETED: false,
        Dbkeys.broadcastmsgTYPE:
            Dbkeys.broadcastmsgTYPEnotificationUpdatedbroadcastDetails,
      });
      Navigator.of(context).pop();
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });

      Fiberchat.toast(err.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (IsBannerAdShow == true) {
      myBanner.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final observer = Provider.of<Observer>(this.context, listen: false);
    return PickupLayout(
        scaffold: Fiberchat.getNTPWrappedWidget(Scaffold(
            backgroundColor: fiberchatWhite,
            appBar: new AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: DESIGN_TYPE == Themetype.whatsapp
                      ? fiberchatWhite
                      : fiberchatBlack,
                ),
              ),
              titleSpacing: 0,
              backgroundColor: DESIGN_TYPE == Themetype.whatsapp
                  ? fiberchatDeepGreen
                  : fiberchatWhite,
              title: new Text(
                getTranslated(context, 'editbroadcast'),
                style: TextStyle(
                  fontSize: 20.0,
                  color: DESIGN_TYPE == Themetype.whatsapp
                      ? fiberchatWhite
                      : fiberchatBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: handleUpdateData,
                  child: Text(
                    getTranslated(this.context, 'save'),
                    style: TextStyle(
                      fontSize: 16,
                      color: DESIGN_TYPE == Themetype.whatsapp
                          ? fiberchatWhite
                          : fiberchatgreen,
                    ),
                  ),
                )
              ],
            ),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      ListTile(
                          title: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: controllerName,
                        validator: (v) {
                          return v!.isEmpty
                              ? getTranslated(context, 'validdetails')
                              : null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          labelStyle: TextStyle(height: 0.8),
                          labelText: getTranslated(context, 'broadcastname'),
                        ),
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      ListTile(
                          title: TextFormField(
                        minLines: 1,
                        maxLines: 10,
                        controller: controllerDesc,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          labelStyle: TextStyle(height: 0.8),
                          labelText: getTranslated(context, 'broadcastdesc'),
                        ),
                      )),
                      SizedBox(
                        height: 85,
                      ),
                      IsBannerAdShow == true &&
                              observer.isadmobshow == true &&
                              adWidget != null
                          ? Container(
                              height: MediaQuery.of(context).size.width - 30,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(
                                bottom: 5.0,
                                top: 2,
                              ),
                              child: adWidget!)
                          : SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                ),
                // Loading
                Positioned(
                  child: isLoading
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    fiberchatBlue)),
                          ),
                          color: DESIGN_TYPE == Themetype.whatsapp
                              ? fiberchatBlack.withOpacity(0.8)
                              : fiberchatWhite.withOpacity(0.8))
                      : Container(),
                ),
              ],
            ))));
  }
}
