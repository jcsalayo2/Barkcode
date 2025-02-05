import 'package:barkcode/main.dart';
import 'package:barkcode/services/login/login_services.dart';
import 'package:barkcode/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(12),
        //   ),
        //   border: Border.all(color: Colors.black),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Login ✨",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome Back! Log in to Continue",
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
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
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue),
              onPressed: isLoading
                  ? null
                  : () async {
                      if (widget.emailController.text.trim() == '' ||
                          widget.passwordController.text.trim() == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 2),
                            content: Text("Input Email and Password")));
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      var result = await LoginServices().login(
                        email: widget.emailController.text.trim(),
                        password: widget.passwordController.text.trim(),
                      );
                      if (result == true) {
                        Navigator.of(context).pushNamed(
                          '/home',
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 2),
                            content: Text(result)));

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
              child: Text(
                "Log In",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not yet a member? "),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text(
                      'Register Here',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
              ],
            ),
          ],
        ));
  }
}
