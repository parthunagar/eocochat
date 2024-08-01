import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/user_model.dart';
import 'package:qr_menu/screens/sign_in_screen.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

final googleSignIn = GoogleSignIn();

class AuthService {
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn().catchError(log);

    if (googleSignInAccount != null) {
      setValue(SharePreferencesKey.IS_LOGGED_IN, true);

      //Authentication
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser!;
      assert(user.uid == currentUser.uid);

      await googleSignIn.signOut();
      await loginFromFirebaseUser(user);
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> loginFromFirebaseUser(User currentUser, {String? fullName}) async {
    UserModel userModel = UserModel();

    if (await userService.isUserExist(currentUser.email)) {
      ///Return user data
      await userService.userByEmail(currentUser.email).then((user) async {
        userModel = user;

        await updateUserData(user);
      }).catchError((e) {
        log(e);
        throw e;
      });
    } else {
      /// Create user
      log("Creating User");
      userModel.email = currentUser.email;
      userModel.num = currentUser.phoneNumber;
      userModel.uid = currentUser.uid;
      userModel.image = currentUser.photoURL;
      log(currentUser.photoURL);
      userModel.isEmailLogin = false;

      userModel.createdAt = Timestamp.now();
      userModel.updatedAt = Timestamp.now();
      if (isIos) {
        userModel.name = fullName;
      } else {
        userModel.name = currentUser.displayName.validate();
      }

      log(userModel.toJson());

      await userService.addDocumentWithCustomId(currentUser.uid, userModel).then((value) {
        log("New User Added");
      }).catchError((e) {
        throw e;
      });
    }

    await setUserDetailPreference(userModel);
  }

  Future<void> updateUserData(UserModel user) async {
    userService.updateDocument({
      'updatedAt': Timestamp.now(),
    }, user.uid.validate());
  }

  Future<void> setUserDetailPreference(UserModel user) async {
    appStore.setLoggedIn(true);

    setValue(SharePreferencesKey.USER_ID, user.uid);
    setValue(SharePreferencesKey.USER_NAME, user.name.validate());
    setValue(SharePreferencesKey.USER_EMAIL, user.email!);
    setValue(SharePreferencesKey.USER_NUMBER, user.num.validate());
    setValue(SharePreferencesKey.USER_IMAGE, user.image.validate());

    appStore.setUserId(user.uid.validate());
    appStore.setFullName(user.name.validate());
    appStore.setUserEmail(user.email!);
    appStore.setUserProfile(user.image.validate());

    setValue(SharePreferencesKey.IS_EMAIL_LOGIN, user.isEmailLogin.validate());
  }

  Future<void> signUpWithEmailPassword({String? name, required String email, required String password, String? mobileNumber}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential != null && userCredential.user != null) {
      User currentUser = userCredential.user!;
      UserModel userModel = UserModel();

      userModel.email = currentUser.email;
      userModel.name = name;
      userModel.num = mobileNumber;
      userModel.uid = currentUser.uid;
      userModel.isEmailLogin = true;
      userModel.image = "";
      userModel.createdAt = Timestamp.now();
      userModel.updatedAt = Timestamp.now();

      await userService.addDocumentWithCustomId(currentUser.uid, userModel).then((value) async {
        //
        await signInWithEmailPassword(email: email, password: password).then((value) {
          //
        });
      }).catchError((e) {
        log(e);
        throw e;
      });
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> signInWithEmailPassword({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
      final User user = value.user!;
      setValue(SharePreferencesKey.PASSWORD, password);
      UserModel userModel = await userService.getUser(email: user.email);
      await updateUserData(userModel);
      await setUserDetailPreference(userModel);
    }).catchError((error) async {
      if (!await isNetworkAvailable()) {
        throw 'Please check network connection';
      }
      throw 'Enter valid email and password';
    });
  }

  Future<void> changePassword(String newPassword) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword).then((value) async {
      await setValue(SharePreferencesKey.PASSWORD, newPassword);
    });
  }

  Future<void> logout(BuildContext context) async {
    removeKey(SharePreferencesKey.USER_ID);
    removeKey(SharePreferencesKey.USER_NAME);
    removeKey(SharePreferencesKey.USER_EMAIL);
    removeKey(SharePreferencesKey.USER_NUMBER);
    removeKey(SharePreferencesKey.IS_LOGGED_IN);
    removeKey(SharePreferencesKey.IS_EMAIL_LOGIN);
    removeKey(SharePreferencesKey.PASSWORD);

    appStore.setLoggedIn(false);

    SignInScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true, duration: 450.milliseconds);
  }

  Future<void> forgotPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      //
    }).catchError((error) {
      throw error.toString();
    });
  }

  /// Sign-In with Apple.
  Future<void> appleLogIn() async {
    if (await TheAppleSignIn.isAvailable()) {
      AuthorizationResult result = await TheAppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          final appleIdCredential = result.credential!;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!),
            accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
          );
          final authResult = await _auth.signInWithCredential(credential);
          final user = authResult.user!;

          if (result.credential!.email != null) {
            await saveAppleData(result);
          }

          await loginFromFirebaseUser(
            user,
            fullName: '${getStringAsync('appleGivenName')} ${getStringAsync('appleFamilyName')}',
          );
          break;
        case AuthorizationStatus.error:
          throw ("Sign in failed: ${result.error!.localizedDescription}");
        case AuthorizationStatus.cancelled:
          throw ('User cancelled');
      }
    } else {
      throw ('Apple SignIn is not available for your device');
    }
  }

  /// UserData provided only 1st time..

  Future<void> saveAppleData(AuthorizationResult result) async {
    await setValue('appleEmail', result.credential!.email);
    await setValue('appleGivenName', result.credential!.fullName!.givenName);
    await setValue('appleFamilyName', result.credential!.fullName!.familyName);
  }
}
