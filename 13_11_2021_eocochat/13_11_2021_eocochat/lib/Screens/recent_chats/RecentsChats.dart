//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Configs/Dbpaths.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Models/API_models/user_QR_Code.dart';
import 'package:fiberchat/Reasturant/screens/dashboard_screen.dart';
import 'package:fiberchat/Screens/Broadcast/BroadcastChatPage.dart';
import 'package:fiberchat/Screens/Groups/AddContactsToGroup.dart';
import 'package:fiberchat/Screens/Groups/GroupChatPage.dart';
import 'package:fiberchat/Screens/PayWithWalletNumber/payWithWalletNumber.dart';
import 'package:fiberchat/Screens/ScanCode/scanCodeScreen.dart';
import 'package:fiberchat/Screens/Wallet/walletScreen.dart';
import 'package:fiberchat/Screens/contact_screens/SmartContactsPage.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/Admob/admob.dart';
import 'package:fiberchat/Services/Providers/BroadcastProvider.dart';
import 'package:fiberchat/Services/Providers/GroupChatProvider.dart';
import 'package:fiberchat/Services/Providers/Observer.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Screens/chat_screen/utils/messagedata.dart';
import 'package:fiberchat/Screens/call_history/callhistory.dart';
import 'package:fiberchat/Screens/chat_screen/chat.dart';
import 'package:fiberchat/Models/DataModel.dart';
import 'package:fiberchat/Services/Providers/user_provider.dart';
import 'package:fiberchat/Utils/alias.dart';
import 'package:fiberchat/Utils/chat_controller.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:fiberchat/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fiberchat/Utils/unawaited.dart';

class RecentChats extends StatefulWidget {
  RecentChats(
      {required this.currentUserNo,
      required this.isSecuritySetupDone,
      required this.prefs,
      key})
      : super(key: key);
  final String? currentUserNo;
  final SharedPreferences prefs;
  final bool isSecuritySetupDone;
  @override
  State createState() =>
      new RecentChatsState(currentUserNo: this.currentUserNo);
}

class RecentChatsState extends State<RecentChats> {
  RecentChatsState({Key? key, this.currentUserNo}) {
    _filter.addListener(() {
      _userQuery.add(_filter.text.isEmpty ? '' : _filter.text);
    });
  }

  final TextEditingController _filter = new TextEditingController();
  bool isAuthenticating = false;

  List<StreamSubscription> unreadSubscriptions = [];

  List<StreamController> controllers = [];
  final BannerAd myBanner = BannerAd(
    adUnitId: getBannerAdUnitId()!,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  AdWidget? adWidget;
  @override
  void initState() {
    super.initState();
    Fiberchat.internetLookUp();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final observer = Provider.of<Observer>(this.context, listen: false);
      if (IsBannerAdShow == true && observer.isadmobshow == true) {
        myBanner.load();
        adWidget = AdWidget(ad: myBanner);
        setState(() {});
      }
    });
  }

  getuid(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserDetails(currentUserNo);
  }

  void cancelUnreadSubscriptions() {
    unreadSubscriptions.forEach((subscription) {
      subscription.cancel();
    });
  }

  DataModel? _cachedModel;
  bool showHidden = false, biometricEnabled = false;

  String? currentUserNo;

  bool isLoading = false;

  Widget buildItem(BuildContext context, Map<String, dynamic> user) {
    if (user[Dbkeys.phone] == currentUserNo) {
      return Container(width: 0, height: 0);
    } else {
      return StreamBuilder(
        stream: getUnread(user).asBroadcastStream(),
        builder: (context, AsyncSnapshot<MessageData> unreadData) {
          int unread = unreadData.hasData &&
                  unreadData.data!.snapshot.docs.isNotEmpty
              ? unreadData.data!.snapshot.docs
                  .where((t) => t[Dbkeys.timestamp] > unreadData.data!.lastSeen)
                  .length
              : 0;
          return Theme(
              data: ThemeData(
                  splashColor: fiberchatBlue,
                  highlightColor: Colors.transparent),
              child: Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                      onLongPress: () {
                        unawaited(showDialog(
                            context: context,
                            builder: (context) {
                              return AliasForm(user, _cachedModel);
                            }));
                      },
                      leading: customCircleAvatar(url: user['photoUrl'], radius: 22),
                      title: Text(
                        Fiberchat.getNickname(user)!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: fiberchatBlack,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        print(' ======> ON CLICK CHAT USER <====== ');
                        if (_cachedModel!.currentUser![Dbkeys.locked] != null && _cachedModel!.currentUser![Dbkeys.locked].contains(user[Dbkeys.phone])) {
                          NavigatorState state = Navigator.of(context);
                          ChatController.authenticate(_cachedModel!,
                              getTranslated(context, 'auth_neededchat'),
                              state: state,
                              shouldPop: false,
                              type: Fiberchat.getAuthenticationType(biometricEnabled, _cachedModel),
                              prefs: widget.prefs, onSuccess: () {
                            state.pushReplacement(new MaterialPageRoute(
                                builder: (context) => new ChatScreen(
                                    isSharingIntentForwarded: false,
                                    prefs: widget.prefs,
                                    unread: unread,
                                    model: _cachedModel!,
                                    currentUserNo: currentUserNo,
                                    peerNo: user[Dbkeys.phone] as String?)));
                          });
                        } else {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new ChatScreen(
                                      isSharingIntentForwarded: false,
                                      prefs: widget.prefs,
                                      unread: unread,
                                      model: _cachedModel!,
                                      currentUserNo: currentUserNo,
                                      peerNo: user[Dbkeys.phone] as String?)));
                        }
                      },
                      trailing: unread != 0
                          ? Container(
                              child: Text(unread.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              padding: const EdgeInsets.all(7.0),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: user[Dbkeys.lastSeen] == true
                                    ? Colors.green[400]
                                    : Colors.blue[400],
                              ),
                            )
                          : user[Dbkeys.lastSeen] == true
                              ? Container(
                                  child: Container(width: 0, height: 0),
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green[400]),
                                )
                              : SizedBox(
                                  height: 0,
                                  width: 0,
                                )),
                  Divider(
                    height: 0,
                  ),
                ],
              ));
        },
      );
    }
  }

  Stream<MessageData> getUnread(Map<String, dynamic> user) {
    String chatId = Fiberchat.getChatId(currentUserNo, user[Dbkeys.phone]);
    var controller = StreamController<MessageData>.broadcast();
    unreadSubscriptions.add(FirebaseFirestore.instance
        .collection(DbPaths.collectionmessages)
        .doc(chatId)
        .snapshots()
        .listen((doc) {
      if (doc[currentUserNo!] != null && doc[currentUserNo!] is int) {
        unreadSubscriptions.add(FirebaseFirestore.instance
            .collection(DbPaths.collectionmessages)
            .doc(chatId)
            .collection(chatId)
            .snapshots()
            .listen((snapshot) {
          controller.add(
              MessageData(snapshot: snapshot, lastSeen: doc[currentUserNo!]));
        }));
      }
    }));
    controllers.add(controller);
    return controller.stream;
  }

  _isHidden(phoneNo) {
    Map<String, dynamic> _currentUser = _cachedModel!.currentUser!;
    return _currentUser[Dbkeys.hidden] != null &&
        _currentUser[Dbkeys.hidden].contains(phoneNo);
  }

  StreamController<String> _userQuery = new StreamController<String>.broadcast();

  List<Map<String, dynamic>> _streamDocSnap = [];

  _chats(Map<String?, Map<String, dynamic>?> _userData, Map<String, dynamic>? currentUser) {
    return Consumer<List<GroupModel>>(
        builder: (context, groupList, _child) => Consumer<List<BroadcastModel>>(
                builder: (context, broadcastList, _child) {
              _streamDocSnap = Map.from(_userData).values.where((_user) => _user.keys.contains(Dbkeys.chatStatus)).toList().cast<Map<String, dynamic>>();
              Map<String?, int?> _lastSpokenAt = _cachedModel!.lastSpokenAt;
              List<Map<String, dynamic>> filtered = List.from(<Map<String, dynamic>>[]);
              groupList.forEach((element) {
                _streamDocSnap.add(element.docmap);
              });
              broadcastList.forEach((element) {
                _streamDocSnap.add(element.docmap);
              });
              _streamDocSnap.sort((a, b) {
                int aTimestamp = a.containsKey(Dbkeys.groupISTYPINGUSERID)
                    ? a[Dbkeys.groupLATESTMESSAGETIME]
                    : a.containsKey(Dbkeys.broadcastBLACKLISTED)
                        ? a[Dbkeys.broadcastLATESTMESSAGETIME]
                        : _lastSpokenAt[a[Dbkeys.phone]] ?? 0;
                int bTimestamp = b.containsKey(Dbkeys.groupISTYPINGUSERID)
                    ? b[Dbkeys.groupLATESTMESSAGETIME]
                    : b.containsKey(Dbkeys.broadcastBLACKLISTED)
                        ? b[Dbkeys.broadcastLATESTMESSAGETIME]
                        : _lastSpokenAt[b[Dbkeys.phone]] ?? 0;
                return bTimestamp - aTimestamp;
              });

              if (!showHidden) {
                _streamDocSnap.removeWhere((_user) =>
                    !_user.containsKey(Dbkeys.groupISTYPINGUSERID) &&
                    !_user.containsKey(Dbkeys.broadcastBLACKLISTED) &&
                    _isHidden(_user[Dbkeys.phone]));
              }

              return ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                shrinkWrap: true,
                children: [
                  Container(
                      child: _streamDocSnap.isNotEmpty
                          ? StreamBuilder(
                              stream: _userQuery.stream.asBroadcastStream(),
                              builder: (context, snapshot) {
                                if (_filter.text.isNotEmpty || snapshot.hasData) {
                                  filtered = this._streamDocSnap.where((user) {
                                    return user[Dbkeys.nickname].toLowerCase().trim().contains(new RegExp(r'' + _filter.text.toLowerCase().trim() + ''));
                                  }).toList();
                                  if (filtered.isNotEmpty)
                                    return ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(10.0),
                                      itemBuilder: (context, index) => buildItem(context, filtered.elementAt(index)),
                                      itemCount: filtered.length,
                                    );
                                  else
                                    return ListView(
                                        physics: AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
                                            child: Center(
                                              child: Text(
                                                getTranslated(context, 'nosearchresult'),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 18, color: fiberchatGrey)),
                                              ))
                                        ]);
                                }
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 120),
                                  itemBuilder: (context, index) {
                                    if (_streamDocSnap[index].containsKey(
                                        Dbkeys.groupISTYPINGUSERID)) {
                                      ///----- Build Group Chat Tile ----
                                      return Theme(
                                          data: ThemeData(splashColor: fiberchatBlue, highlightColor: Colors.transparent),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                leading: customCircleAvatarGroup(url: _streamDocSnap[index][Dbkeys.groupPHOTOURL], radius: 22),
                                                title: Text(
                                                  _streamDocSnap[index][Dbkeys.groupNAME],
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(color: fiberchatBlack, fontSize: 16)),
                                                subtitle: Text(
                                                  '${_streamDocSnap[index][Dbkeys.groupMEMBERSLIST].length} ${getTranslated(context, 'participants')}',
                                                  style: TextStyle(color: fiberchatGrey, fontSize: 14)),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) => new GroupChatPage(
                                                              isSharingIntentForwarded:
                                                                  false,
                                                              model:
                                                                  _cachedModel!,
                                                              prefs:
                                                                  widget.prefs,
                                                              joinedTime:
                                                                  _streamDocSnap[
                                                                          index]
                                                                      [
                                                                      '${widget.currentUserNo}-joinedOn'],
                                                              currentUserno: widget
                                                                  .currentUserNo!,
                                                              groupID:
                                                                  _streamDocSnap[
                                                                          index]
                                                                      [Dbkeys
                                                                          .groupID])));
                                                },
                                                trailing: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(DbPaths
                                                          .collectiongroups)
                                                      .doc(_streamDocSnap[index]
                                                          [Dbkeys.groupID])
                                                      .collection(DbPaths
                                                          .collectiongroupChats)
                                                      .where(
                                                          Dbkeys.groupmsgTIME,
                                                          isGreaterThan:
                                                              _streamDocSnap[
                                                                      index][
                                                                  widget
                                                                      .currentUserNo])
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot<
                                                                      dynamic>>
                                                              snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return SizedBox(
                                                        height: 0,
                                                        width: 0,
                                                      );
                                                    } else if (snapshot
                                                            .hasData &&
                                                        snapshot.data!.docs
                                                                .length >
                                                            0) {
                                                      return Container(
                                                        child: Text(
                                                            '${snapshot.data!.docs.length}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(7.0),
                                                        decoration:
                                                            new BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Colors.blue[400],
                                                        ),
                                                      );
                                                    }
                                                    return SizedBox(
                                                      height: 0,
                                                      width: 0,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Divider(
                                                height: 0,
                                              ),
                                            ],
                                          ));
                                    }
                                    //TODO:---- REMOVE BROADCAST FEATURE IF NOT NEEDED--------
                                    else if (_streamDocSnap[index].containsKey(
                                        Dbkeys.broadcastBLACKLISTED)) {
                                      ///----- Build Broadcast Chat Tile ----
                                      return Theme(
                                          data: ThemeData(
                                              splashColor: fiberchatBlue,
                                              highlightColor:
                                                  Colors.transparent),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20, 0, 20, 0),
                                                leading:
                                                    customCircleAvatarBroadcast(
                                                        url: _streamDocSnap[
                                                                index][
                                                            Dbkeys
                                                                .broadcastPHOTOURL],
                                                        radius: 22),
                                                title: Text(
                                                  _streamDocSnap[index]
                                                      [Dbkeys.broadcastNAME],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: fiberchatBlack,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  '${_streamDocSnap[index][Dbkeys.broadcastMEMBERSLIST].length} ${getTranslated(context, 'recipients')}',
                                                  style: TextStyle(
                                                    color: fiberchatGrey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(context, new MaterialPageRoute(
                                                    builder: (context) => new BroadcastChatPage(
                                                      model: _cachedModel!,
                                                      prefs: widget.prefs,
                                                      currentUserno: widget.currentUserNo!,
                                                      broadcastID: _streamDocSnap[index][Dbkeys.broadcastID])));
                                                },
                                              ),
                                              Divider(height: 0),
                                            ],
                                          ));
                                    } else {
                                      return buildItem(context,
                                          _streamDocSnap.elementAt(index));
                                    }
                                  },
                                  itemCount: _streamDocSnap.length,
                                );
                              })
                          : ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.5),
                                      child: Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(30.0),
                                            child: Text(
                                                groupList.length != 0
                                                    ? ''
                                                    : getTranslated(
                                                        context, 'startchat'),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.59,
                                                  color: fiberchatGrey,
                                                ))),
                                      ))
                                ])),
                ],
              );
            }));
  }

  Widget buildGroupitem() {
    return Text(
      Dbkeys.groupNAME,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  DataModel? getModel() {
    _cachedModel ??= DataModel(currentUserNo);
    return _cachedModel;
  }

  @override
  void dispose() {
    super.dispose();

    if (IsBannerAdShow == true) {
      myBanner.dispose();
    }
  }


  void _modalBottomSheetMenu(var h,var w){
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0))
        ),
        builder: (builder){
          return new Container(
            height: h * 0.25,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child:  Container(
               decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius:  BorderRadius.only(
                      topLeft:  Radius.circular(30.0),
                      topRight:  Radius.circular(30.0))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w *0.04),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.07),
                      GestureDetector(
                        onTap: () {
                          print(' ==========> ON CLICK QR CODE SCREEN <========== ');
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanCodeScreen()));
                        },
                        // child: Container(
                        //   // color: eocochatYellow,
                        //   child: Row(
                        //     children: [
                        //       SvgPicture.asset(Assets.qrCodeImage,height: 30),
                        //       SizedBox(width: w * 0.04),
                        //       Text(
                        //         // "Pay via QR Code",
                        //         getTranslated(context, 'lblPayViaQRCode'),
                        //         style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //     ],
                        //   ),
                        // ),
                        child: Container(
                          // color: eocochatYellow,
                          child: Row(
                            children: [
                              Image.asset(Assets.scanCircleImage,height: 40),
                              SizedBox(width: w * 0.04),
                              Text(
                                getTranslated(context, 'lblPayViaQRCode'),
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.03),
                      GestureDetector(
                        onTap: () async {
                          print(' ==========> ON CLICK PAY WITH WALLET NUMBER SCREEN <========== ');

                          await SharedPreferences.getInstance().then((value) {
                            SharedPreferences val = value;
                            print('getPrefData USER ID : ${val.getString(Dbkeys.sharedPrefUserId).toString()}');
                            setState(() {
                             var  userId = val.getString(Dbkeys.sharedPrefUserId).toString();
                             APIServices.getMakeUserQRCode(val.getString(Dbkeys.sharedPrefUserId).toString()).then((userQrCodeSnapshotValue) {
                               print('userQrCodeSnapshotValue : $userQrCodeSnapshotValue');
                               setState(() {
                                 var userCodeData = UserQrCode.fromJson(json.decode(userQrCodeSnapshotValue));
                                 print('userCodeData id : ${userCodeData.userQrCodeData!.id}');
                                 print('userCodeData accountNumber : ${userCodeData.userQrCodeData!.accountNumber}');
                                 var userName = userCodeData.userQrCodeData!.username;
                                 Navigator.pop(context);
                                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  PayWithWalletNumberScreen(
                                   userCodeData: userCodeData,
                                   // userDetailWithMobileNo: userDetailValue,
                                   // userId: val.getString(Dbkeys.sharedPrefUserId).toString(),
                                 )));
                               });
                             }).onError((e, stackTrace) {
                               print('getMakeUserQRCode ERROR : $e');
                             });
                            });
                          }).onError((e, stackTrace) {
                            print('SharedPreferences.getInstance() ERROR : $e');
                          });
                        },
                        child: Container(
                          // color: eocochatYellow,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                  decoration: new BoxDecoration(color: fiberchatLightGreen, shape: BoxShape.circle,),
                                  child: Icon(Icons.credit_card,color: eocochatWhite,)),
                              // SvgPicture.asset(Assets.qrCodeImage,height: 30),
                              SizedBox(width: w *0.04),
                              Text(
                                  // "Pay via Wallet Number",
                                  getTranslated(context, 'lblPayViaWalletNumber'),
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: h * 0.02),
                    ],

                  ),
                )),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final observer = Provider.of<Observer>(this.context, listen: false);
    return Fiberchat.getNTPWrappedWidget(ScopedModel<DataModel>(
      model: getModel()!,
      child:
          ScopedModelDescendant<DataModel>(builder: (context, child, _model) {
        _cachedModel = _model;
        return Scaffold(
          bottomSheet: IsBannerAdShow == true &&
            observer.isadmobshow == true &&
            adWidget != null
          ? Container(
              height: 60,
              margin: EdgeInsets.only(bottom: Platform.isIOS == true ? 25.0 : 5, top: 0),
              child: Center(child: adWidget))
          : SizedBox(height: 0),
          backgroundColor: fiberchatWhite,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            // alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: IsBannerAdShow == true && observer.isadmobshow == true ? 60 : 3,left: 5,right: 5, top: 3),

            decoration: BoxDecoration(
              color: SplashBackgroundSolidColor,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    backgroundColor: fiberchatLightGreen,
                    child: Icon(Icons.chat, size: 30.0),
                    onPressed: () {
                      print(' ==========> ON CLICK MESSAGE <========== ');
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new SmartContactsPage(
                                  onTapCreateGroup: () {
                                    if (observer.isAllowCreatingGroups == false) {
                                      Fiberchat.showRationale(getTranslated(this.context, 'disabled'));
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddContactsToGroup(
                                                    currentUserNo: widget.currentUserNo,
                                                    model: _cachedModel,
                                                    biometricEnabled: false,
                                                    prefs: widget.prefs,
                                                    isAddingWhileCreatingGroup: true,
                                                  )));
                                    }
                                  },
                                  prefs: widget.prefs,
                                  biometricEnabled: biometricEnabled,
                                  currentUserNo: currentUserNo!,
                                  model: _cachedModel!)));
                    }),
                SizedBox(width: 10),
                // GestureDetector(
                //   onTap: () {
                //     print(' ==========> ON CLICK QR CODE SCREEN <========== ');
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => ScanCodeScreen()));
                //     _modalBottomSheetMenu(h,w);
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         // color: fiberchatBlue,
                //         borderRadius: BorderRadius.circular(50)
                //     ),
                //     // child: Image.asset(Assets.qrCodeImage),
                //     child: SvgPicture.asset(Assets.qrCodeImage,height: 55),//height: 60
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    print(' ==========> ON CLICK QR CODE SCREEN <========== ');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScanCodeScreen()));
                    // _modalBottomSheetMenu(h,w);
                  },
                  child: Container(

                    decoration: BoxDecoration(
                      // color: fiberchatLightGreen,
                      border: Border.all(color: fiberchatLightGreen),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    // child: Image.asset(Assets.qrCodeImage),
                    child: Image.asset(Assets.scanCircleImage,
                      height: 55,
                      // fit: BoxFit.cover,
                    ),//height: 60
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    print(' ==========> ON CLICK WALLET SCREEN <========== ');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: SvgPicture.asset(Assets.walletImage,height: 55),
                  ),
                ),
                // SizedBox(width: 10),
                // GestureDetector(
                //   onTap: () {
                //     print(' ==========> ON CLICK RESTAURANT <========== ');
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                //     child: SvgPicture.asset(Assets.restaurantImage,height: 55),
                //   ),
                // ),
                // GestureDetector(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: fiberchatLightGreen,
                //       borderRadius: BorderRadius.circular(50)),
                //     child: Padding(
                //       padding: EdgeInsets.all(13.0),
                //       child: Icon(IconData(0xe532,fontFamily: 'MaterialIcons',),color: Colors.white,size: 30)),
                //   ),
                // )
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              isAuthenticating = !isAuthenticating;
              setState(() {
                showHidden = !showHidden;
              });
              return Future.value(true);
            },
            child: _chats(_model.userData, _model.currentUser),
          ),
        );
      }),
    ));
  }
}
