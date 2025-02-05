import 'package:barkcode/pages/home_page.dart';
import 'package:barkcode/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      return const LoginPage();
    } else {
      return const PopScope(
        child: HomePage(),
      );
    }
  }
}
