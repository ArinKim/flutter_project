import 'package:flutter/material.dart';
import 'package:fluttergram/utils/colours.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Color colour;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    required this.colour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      style: TextStyle(color: colour),
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: colour),
          border: inputBorder,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: secondaryColor),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
