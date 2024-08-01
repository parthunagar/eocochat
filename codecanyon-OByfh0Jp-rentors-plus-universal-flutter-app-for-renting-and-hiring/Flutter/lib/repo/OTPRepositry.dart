import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/ErrorResponse.dart';
import 'package:rentors/model/OtpResponse.dart';

Future<dynamic> sendOTP(countryCode, mobileNumber) async {
  Completer<dynamic> completer = Completer();
  FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signOut();
  await _auth.verifyPhoneNumber(
      phoneNumber: countryCode + mobileNumber,
      timeout: Duration(seconds: 10),
      verificationCompleted: (PhoneAuthCredential auth) {
        print(auth);
      },
      verificationFailed: (FirebaseAuthException mException) {
        completer.complete(ErrorResponse(101, mException.message));
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        var mResponse = OtpResponse();
        mResponse.verificationId = verificationId;
        completer.complete(mResponse);
      },
      codeAutoRetrievalTimeout: (verificationId) {});
  return completer.future;
}

Future<dynamic> verifyOTP(verificationId, smsCode) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Completer<dynamic> completer = Completer();

  var _authCredential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: smsCode);
  await _auth.signInWithCredential(_authCredential).catchError((error) {
    if(error is FirebaseAuthException) {
      if(error.code=="invalid-verification-code") {
        completer.complete(ErrorResponse(101, S.current.invalidOtp));
      }else{
        completer.complete(ErrorResponse(101, error.toString()));
      }
    }else{
      completer.complete(ErrorResponse(101, error.toString()));
    }
  }).then((value) async {
    if (value == null) {
    } else {
      completer.complete(value);
    }
  });
  return completer.future;
}
