import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoadingMore;

  const LoadingIndicator({super.key, required this.isLoadingMore});

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
