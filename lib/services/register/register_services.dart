import 'dart:async';

import 'package:barkcode/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterServices {
  FutureOr<dynamic> createAccount(
      {required String name,
      required String email,
      required String password}) async {
    var result = await FirebaseAuthService(FirebaseAuth.instance).signUp(
      email: email.trim(),
      password: password.trim(),
      name: name.trim(),
    );

    if (result == true) {
      return null;
    } else {
      return getErrorDisplay(result);
    }
  }

  getErrorDisplay(result) {
    switch (result) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      default:
        return 'An unknown error occurred.';
    }
  }
}
