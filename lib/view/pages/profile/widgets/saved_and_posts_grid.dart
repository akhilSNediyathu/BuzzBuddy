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
      //  physics: NeverScrollableScrollPhysics(),
     // shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
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
                  builder: (context) => ScreenMyPost(post: post,),
                ));
          },
          child: Container(
          
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(post[index].image.toString()),fit: BoxFit.cover)
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
        crossAxisCount: 3,
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
