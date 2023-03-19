// ignore_for_file: constant_identifier_names

import 'package:cbo_employee/utils/show_msg_utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import '../models/user_model.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  User? get user => _user;

  User? getuser() {
    return _auth.currentUser;
  }

  Status _status = Status.Uninitialized;

  Status get status => _status;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> authListener() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<String> googleSignIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        _status = Status.Authenticated;
        notifyListeners();
        return user.uid;
      } else {
        _status = Status.Unauthenticated;
        notifyListeners();
        return "";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // Handle account already exists error
      } else if (e.code == 'invalid-credential') {
        // Handle invalid credentials error
      }
      _status = Status.Unauthenticated;
      notifyListeners();
      rethrow;
    } catch (_) {
      _status = Status.Unauthenticated;
      notifyListeners();
      rethrow;
    }
    // return "";
  }

  //Method to handle user sign in using email and password
  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required bool signUp}) async {
    try {
      _status = Status.Authenticating;
      email = email.trim();
      password = password.trim();
      notifyListeners();
      var regdUser = signUp
          ? await _auth.createUserWithEmailAndPassword(
              email: email, password: password)
          : await _auth.signInWithEmailAndPassword(
              email: email, password: password);
      print("UserCredential is $regdUser");

      if (regdUser.user != null) {
        _status = Status.Authenticated;
        notifyListeners();
        // return regdUser.user?.uid;
      } else {
        _status = Status.Unauthenticated;
        notifyListeners();
        // return "";
      }
      // return true;
    } on FirebaseAuthException catch (e) {
      ShowMsgUtils.showsnackBar(
          title: "SignIn Falied Error is ${e.code}", color: Colors.red);
      _status = Status.Unauthenticated;
      notifyListeners();
    } catch (e) {
      ShowMsgUtils.showsnackBar(
          title: "SignIn Falied Error is $e", color: Colors.red);
      _status = Status.Unauthenticated;
      notifyListeners();
      // return false;
    }
  }

  // Future<void> signUpWithEmailAndPassword(String email, String password) async {
  //   try {
  //     _status = Status.Authenticating;
  //     notifyListeners();
  //    var regdUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);

  //     if (regdUser.user != null) {
  //       _status = Status.Authenticated;
  //       notifyListeners();
  //       // return regdUser.user?.uid;
  //     } else {
  //       _status = Status.Unauthenticated;
  //       notifyListeners();
  //       // return "";
  //     }
  //     // return true;
  //   } catch (e) {
  //       _status = Status.Unauthenticated;
  //       notifyListeners();
  //     // return false;
  //   }
  // }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
