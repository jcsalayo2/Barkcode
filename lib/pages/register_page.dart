import 'package:barkcode/widgets/form_widget.dart';
import 'package:barkcode/widgets/image_widget.dart';
import 'package:barkcode/widgets/register_form_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var emailController = TextEditingController();

  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLandscape
          ? Row(
              children: [
                Expanded(
                  child: RegisterFormWidget(
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    nameController: nameController,
                  ),
                ),
                Expanded(
                    child: ImageWidget(asset: "assets/register/register.jpeg")),
              ],
            )
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageWidget(asset: "assets/register/register.jpeg"),
                RegisterFormWidget(
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  nameController: nameController,
                ),
              ],
            )),
    );
  }
}
