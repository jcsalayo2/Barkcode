import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldPetWidget extends StatefulWidget {
  const TextFieldPetWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  @override
  State<TextFieldPetWidget> createState() => _TextFieldPetWidgetState();
}

class _TextFieldPetWidgetState extends State<TextFieldPetWidget> {
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
              return const Icon(Icons.pets_rounded);
            case "Gender":
              return Container(
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  color: Color(0xff44474f),
                  "assets/icons/svg/venus-mars.svg",
                  height: 1,
                  width: 1,
                ),
              );
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
