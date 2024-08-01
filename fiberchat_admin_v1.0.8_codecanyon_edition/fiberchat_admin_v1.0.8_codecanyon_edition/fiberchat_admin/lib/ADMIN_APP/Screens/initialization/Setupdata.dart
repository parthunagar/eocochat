import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thinkcreative_technologies/COMMONS/Configs/DbPaths.dart';
import 'package:thinkcreative_technologies/COMMONS/Configs/Dbkeys.dart';

// Include all the fields for setting up the very first database when the admin login for the first time.

String initialadminloginid = 'admin';
String initialadminloginpassword = 'admin';
String initialadminloginpin = '123456';
String underconstructionmessage =
    'App under maintainance & will be right back.';
var admincredentials = {
  Dbkeys.adminemailid: null,
  Dbkeys.adminusername: initialadminloginid,
  Dbkeys.adminphone: null,
  Dbkeys.adminpassword: initialadminloginpassword,
  Dbkeys.adminphotourl: null,
  Dbkeys.adminpin: initialadminloginpin,
  Dbkeys.admintoken: null,
  Dbkeys.adminfullname: null,
  Dbkeys.adminloginhistory: [],
  Dbkeys.admincurrentdevice: null,
  Dbkeys.admindeviceslist: [],
};
var adminappsettingsmap = {
  Dbkeys.issetupdone: false, //----
  Dbkeys.isemulatorallowed: true, //----
  Dbkeys.latestappversionandroid: '1.0.0', //----
  Dbkeys.newapplinkandroid: 'https://www.google.com/', //----
  Dbkeys.latestappversionios: '1.0.0', //----
  Dbkeys.newapplinkios: 'https://www.google.com/', //----
  Dbkeys.latestappversionweb: '1.0.0', //----
  Dbkeys.newapplinkweb: 'https://www.google.com/', //----
  // Dbkeys.latestappversionmac: '1.0.0', //----
  // Dbkeys.newapplinkmac: 'https://www.google.com/', //----
  // Dbkeys.latestappversionwindows: '1.0.0', //----
  // Dbkeys.newapplinkwindows: 'https://www.google.com/', //----
  Dbkeys.isupdatemandatory: true, //----
  Dbkeys.isappunderconstructionandroid: false, //----
  Dbkeys.isappunderconstructionios: false, //----
  Dbkeys.isappunderconstructionweb: false, //----
  // Dbkeys.isappunderconstructionmac: false, //----
  // Dbkeys.isappunderconstructionwindows: false, //----
  Dbkeys.alloweddebuggersUID: [],
  Dbkeys.isblocknewlogins: false, //----
  Dbkeys.isshowerrorlog: false, //----
  Dbkeys.maintainancemessage:
      'App under maintainance & will be right back. For more info: Please contact the developer.', //----, //----
  Dbkeys.isCollectDeviceInfoAndSavetoDatabase: false,
  Dbkeys.isOnlySingleDeviceLoginAllowed: false,

  //---added in update:
  //---------
  Dbkeys.isAllowCreatingGroups: true,
  Dbkeys.isAllowCreatingBroadcasts: true,
  Dbkeys.isAllowCreatingStatus: true,
  Dbkeys.is24hrsTimeformat: true,
  Dbkeys.isPercentProgressShowWhileUploading: true,
  Dbkeys.isCallFeatureTotallyHide: false,
  Dbkeys.groupMemberslimit: 500,
  Dbkeys.broadcastMemberslimit: 500,
  Dbkeys.statusDeleteAfterInHours: 24,
  Dbkeys.feedbackEmail: '',
  Dbkeys.isLogoutButtonShowInSettingsPage: true,
  Dbkeys.maxFileSizeAllowedInMB: 60,
  Dbkeys.maxFileSizeAllowedInMB: 60,
  Dbkeys.updateV5done: true,
};

Future<bool> batchwrite() async {
  WriteBatch writeBatch = FirebaseFirestore.instance.batch();
//-------Below Firestore Document for Admin Credentials ---------
  writeBatch.set(
      FirebaseFirestore.instance
          .collection(Dbkeys.admincredentials)
          .doc(Dbkeys.admincredentials),
      admincredentials);

  //-------Below Firestore Document creation for all High Level Alert list ---------
  writeBatch.set(
      FirebaseFirestore.instance
          .collection(DbPaths.collectionTXNHIGHalerts)
          .doc(DbPaths.collectionTXNHIGHalerts),
      {
        Dbkeys.nOTIFICATIONisunseen: true,
        Dbkeys.nOTIFICATIONxxtitle: '',
        Dbkeys.nOTIFICATIONxxdesc: '',
        Dbkeys.nOTIFICATIONxxaction: Dbkeys.nOTIFICATIONactionPUSH,
        Dbkeys.nOTIFICATIONxximageurl: '',
        Dbkeys.nOTIFICATIONxxlastupdate: DateTime.now(),
        Dbkeys.nOTIFICATIONxxpagecomparekey: Dbkeys.docid,
        Dbkeys.nOTIFICATIONxxpagecompareval: '',
        Dbkeys.nOTIFICATIONxxparentid: '',
        Dbkeys.nOTIFICATIONxxextrafield: '',
        Dbkeys.nOTIFICATIONxxpagetype:
            Dbkeys.nOTIFICATIONpagetypeSingleLISTinDOCSNAP,
        Dbkeys.nOTIFICATIONxxpageID: DbPaths.collectionTXNHIGHalerts,
        //-----
        Dbkeys.nOTIFICATIONpagecollection1: DbPaths.collectionTXNHIGHalerts,
        Dbkeys.nOTIFICATIONpagedoc1: DbPaths.collectionTXNHIGHalerts,
        Dbkeys.nOTIFICATIONpagecollection2: '',
        Dbkeys.nOTIFICATIONpagedoc2: '',
        Dbkeys.nOTIFICATIONtopic: Dbkeys.topicADMIN,
        Dbkeys.list: []
      });
//-------Below Firestore Document creation for all Normal Level Alert list ---------
  writeBatch.set(
      FirebaseFirestore.instance
          .collection(DbPaths.collectionALLNORMALalerts)
          .doc(DbPaths.collectionALLNORMALalerts),
      {
        Dbkeys.nOTIFICATIONisunseen: true,
        Dbkeys.nOTIFICATIONxxtitle: '',
        Dbkeys.nOTIFICATIONxxdesc: '',
        Dbkeys.nOTIFICATIONxxaction: Dbkeys.nOTIFICATIONactionPUSH,
        Dbkeys.nOTIFICATIONxximageurl: '',
        Dbkeys.nOTIFICATIONxxlastupdate: DateTime.now(),
        Dbkeys.nOTIFICATIONxxpagecomparekey: Dbkeys.docid,
        Dbkeys.nOTIFICATIONxxpagecompareval: '',
        Dbkeys.nOTIFICATIONxxparentid: '',
        Dbkeys.nOTIFICATIONxxextrafield: '',
        Dbkeys.nOTIFICATIONxxpagetype:
            Dbkeys.nOTIFICATIONpagetypeSingleLISTinDOCSNAP,
        Dbkeys.nOTIFICATIONxxpageID: DbPaths.collectionALLNORMALalerts,
        //-----
        Dbkeys.nOTIFICATIONpagecollection1: DbPaths.collectionALLNORMALalerts,
        Dbkeys.nOTIFICATIONpagedoc1: DbPaths.collectionALLNORMALalerts,
        Dbkeys.nOTIFICATIONpagecollection2: '',
        Dbkeys.nOTIFICATIONpagedoc2: '',
        Dbkeys.nOTIFICATIONtopic: Dbkeys.topicADMIN,
        Dbkeys.list: []
      });
// unless commit is called, nothing happens. So commit is called below---
  writeBatch.commit().catchError((err) {
    // ignore: invalid_return_type_for_catch_error
    return false;
  });
  return true;
}
