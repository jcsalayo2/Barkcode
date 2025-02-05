import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? isPasswordHidden : false,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: () {
          switch (widget.hintText) {
            case "Name":
              return const Icon(Icons.person_outline_rounded);
            case "Email":
              return const Icon(Icons.email_outlined);
            case "Password":
              return const Icon(Icons.lock_outline_rounded);
            case "Confirm Password":
              return const Icon(Icons.lock_outline_rounded);
          }
        }(),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  !isPasswordHidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: const Color.fromARGB(255, 233, 233, 233),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.blueAccent)),
        labelText: widget.hintText,
      ),
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
