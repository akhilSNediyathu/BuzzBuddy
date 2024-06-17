import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldExplore extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboard;
  final String? Function(String?)? validator;

  const TextFormFieldExplore({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboard,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      cursorWidth: 2,
      controller: controller,
      keyboardType: keyboard,
      cursorColor: black,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: grey,
        ),
        // filled: true,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: grey),
        ),
      ),
    );
  }
}
