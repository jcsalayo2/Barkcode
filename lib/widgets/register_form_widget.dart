import 'package:barkcode/main.dart';
import 'package:barkcode/services/register/register_services.dart';
import 'package:barkcode/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isSignupButtonLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Register ✨",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Hello! Register with us to start.",
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
                controller: widget.nameController, hintText: "Name"),
            const SizedBox(height: 20),
            TextFieldWidget(
                controller: widget.emailController, hintText: "Email"),
            const SizedBox(height: 20),
            TextFieldWidget(
              controller: widget.passwordController,
              hintText: "Password",
              isPassword: true,
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              controller: widget.confirmPasswordController,
              hintText: "Confirm Password",
              isPassword: true,
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue),
              onPressed: isSignupButtonLoading
                  ? null
                  : () async {
                      if (widget.confirmPasswordController.text.trim() == '' ||
                          widget.passwordController.text.trim() == '' ||
                          widget.emailController.text.trim() == '' ||
                          widget.nameController.text.trim() == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.blue,
                                duration: Duration(seconds: 2),
                                content:
                                    Text("Complete the form and continue")));
                        return;
                      }
                      if (widget.passwordController.text !=
                          widget.confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 2),
                            content: Text(
                                "Password and Confirm Password are not the same")));
                        return;
                      }
                      setState(() {
                        isSignupButtonLoading = true;
                      });

                      var result = await RegisterServices().createAccount(
                        name: widget.nameController.text.trim(),
                        email: widget.emailController.text.trim(),
                        password: widget.passwordController.text.trim(),
                      );
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 2),
                            content: Text(result)));
                        setState(() {
                          isSignupButtonLoading = false;
                        });

                        return;
                      }

                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", ModalRoute.withName("/"));
                    },
              child: Text(
                "Sign up",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login Here',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
              ],
            ),
          ],
        ));
  }
}
