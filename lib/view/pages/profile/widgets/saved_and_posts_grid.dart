import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:flutter/material.dart';

class MyPostsGrid extends StatelessWidget {
  const MyPostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        
        return Container(
          color: Colors.blueGrey, //  demo
          child: Center(
            child: Text('My Post ${index + 1}'),
          ),
        );
      },
    );
  }
}

class SavedPostsGrid extends StatelessWidget {
  const SavedPostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: profileImages.length,
      itemBuilder: (context, index) {
       
        return Container(
          color: Colors.blue,
          child: Center(
            child: Text('Saved Post ${index + 1}'),
          ),
        );
      },
    );
  }
}