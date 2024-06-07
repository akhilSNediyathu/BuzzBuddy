import 'package:buzz_buddy/model/my_post_model/my_post_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/profile/my_post/screen_my_post.dart';
import 'package:buzz_buddy/view/pages/profile/saved_post/screen_saved_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyPostsGrid extends StatelessWidget {
  final List<MyPostModel> post;

  const MyPostsGrid({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.isEmpty) {
      return const Center(
        child: Text(
          'No posts available',
          style: greyMeduim,
        ),
      );
    }
    return GridView.builder(
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
                builder: (context) => ScreenMyPost(index: index, post: post),
              ),
            );
          },
          child: CachedNetworkImage(imageUrl: post[index].image.toString(),fit: BoxFit.cover, placeholder: (context, url) {
            return LoadingAnimationWidget.fourRotatingDots(color: grey, size: 30);
          },
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
