
import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldChatPage extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onchanged;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  const TextFormFieldChatPage(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboard,
      this.validator, this.onchanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      cursorWidth: 2,
      controller: controller,
      keyboardType: keyboard,
      onChanged: onchanged,
      cursorColor:
          Theme.of(context).brightness == Brightness.light ? black : kwhiteColor,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: grey)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: grey)),
        prefixIcon: const Icon(
          Icons.search,
        ),
        fillColor: Theme.of(context).brightness == Brightness.light
            ? lightgrey
            : darkgreymain,
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
