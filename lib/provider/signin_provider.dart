import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(scopes: <String>['email']);
  bool _isSigninIn;
  bool _isLoggedIn;

  GoogleSignInProvider() {
    _isSigninIn = false;
    _isLoggedIn = false;
  }

  bool get isSigninIn => _isSigninIn;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(BuildContext context) async {
    GoogleSignInAccount _account;
    GoogleSignInAuthentication _googleAuth;
    UserCredential userCredential;

    await googleSignIn
        .signIn()
        .then((account) => _account = account)
        .catchError((error) {
      print('A problem has occurred while signing in to Google:\n$error');
    });

    if (_account == null) {
      _isSigninIn = false;
      return;
    } else {
      try {
        _googleAuth = await _account.authentication;
      } catch (e) {
        print(
            'A problem has occurred while authenticating account:\n${e.message}');
      }

      final credential = GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);

      try {
        userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        print(
            'A problem occurred while signing in with credential:\n${e.message}');
      }

      _isSigninIn = false;
      assert(userCredential != null);
      _isLoggedIn = true;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              '${userCredential.user.displayName} logged in succesfully')));

      Navigator.of(context).pushReplacementNamed('/homepage');
    }
  }

  void logout() async {
    _isLoggedIn = false;
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
