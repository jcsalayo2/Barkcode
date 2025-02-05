import 'package:barkcode/main.dart';
import 'package:barkcode/widgets/form_widget.dart';
import 'package:barkcode/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLandscape
          ? Row(
              children: [
                Expanded(
                  child: LoginFormWidget(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ),
                Expanded(child: ImageWidget(asset: "assets/login/login.jpeg")),
              ],
            )
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageWidget(asset: "assets/login/login.jpeg"),
                LoginFormWidget(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              ],
            )),
    );
  }
}
