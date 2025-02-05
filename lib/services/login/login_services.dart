import 'dart:async';

import 'package:barkcode/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginServices {
  FutureOr<dynamic> login(
      {required String email, required String password}) async {
    var result = await FirebaseAuthService(FirebaseAuth.instance).logIn(
      email: email,
      password: password,
    );

    return result;
  }
}
