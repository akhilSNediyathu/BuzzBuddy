import 'package:buzz_buddy/model/followers_posts_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:flutter/material.dart';

class HomeWidgetMain extends StatelessWidget {
  const HomeWidgetMain({
    super.key,
    required this.media,
    required this.model, required this.onLikeTap, required this.onCommentTap, required this.onSaveTap,
  });

  final Size media;
  final FollowersPostModel model;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: media.height * 0.08,
              width: media.height * 0.08,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(model.userId.profilePic),
                      fit: BoxFit.cover),
                  color: kwhiteColor,
                  borderRadius: kradius100),
            ),
            kwidth,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.userId.name ?? model.userId.userName,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  model.createdAt == model.updatedAt
                      ? formatDate(model.createdAt.toString())
                      : ("${formatDate(model.updatedAt.toString())} (Edited)"),
                ),
              ],
            )
          ],
        ),
        kheight,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.description,
            maxLines: 3,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        kheight,
        Container(
          color: Colors.blue,
          height: media.width * 0.984,
          child: Image(
            image: NetworkImage(model.image),
            fit: BoxFit.cover,
            width: media.width,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                  ),
                  iconSize: 30,
                  color: customIconColor,
                ),
                Text(model.likes.length.toString())
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mode_comment_outlined,
                  ),
                  iconSize: 28,
                  color: customIconColor,
                ),
                const Text('1 comment ')
              ],
            ),
            IconButton(onPressed: () {}, icon: Image.asset(savePostIcon))
          ],
        ),
      ],
    );
  }
}
