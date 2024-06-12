import 'package:flutter/material.dart';

class ScreenUsersSuggestion extends StatelessWidget {
  const ScreenUsersSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Suggestions'),
      ),
      body: const SizedBox(),
    );
  }
}