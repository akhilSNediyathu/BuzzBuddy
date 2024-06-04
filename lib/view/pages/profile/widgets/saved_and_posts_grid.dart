import 'package:buzz_buddy/model/my_post_model/my_post_model.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/profile/my_post/screen_my_post.dart';
import 'package:buzz_buddy/view/pages/profile/saved_post/screen_saved_post.dart';
import 'package:flutter/material.dart';

class MyPostsGrid extends StatelessWidget {
  
  const MyPostsGrid({super.key,required this.post});
 final List<MyPostModel> post;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: post.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenMyPost(),
                ));
          },
          child: Container(
            color: Colors.blueGrey, //  demo
            child: Center(
             
              child: Image.network(post[index].image.toString(),fit: BoxFit.cover,),
            ),
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
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenSavedPost(),
                ));
          },
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Text('Saved Post ${index + 1}'),
            ),
          ),
        );
      },
    );
  }
}
