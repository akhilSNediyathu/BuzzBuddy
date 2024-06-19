import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/showdialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SavedPostListingPageTile extends StatelessWidget {
  const SavedPostListingPageTile(
      {super.key,
      required this.media,
      required this.mainImage,
      required this.profileImage,
      required this.userName,
      required this.postTime,
      required this.description,
      required this.likeCount,
      required this.commentCount,
      required this.likeButtonPressed,
      required this.commentButtonPressed,
      required this.index,
      required this.removeSaved});
  final String profileImage;
  final String mainImage;
  //  final void Function() onTapSettings;
  final String userName;
  final String postTime;
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final VoidCallback commentButtonPressed;
  final Future<void> Function() removeSaved;

  final Size media;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: media.height * 0.08,
                  width: media.height * 0.08,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(profileImage), fit: BoxFit.cover),
                      color: kwhiteColor,
                      borderRadius: kradius100),
                ),
                kwidth,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(postTime),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == 'Remove') {
                      showConfirmationDialog(
                          context: context,
                          title: 'Are you sure?',
                          content: 'remove this post from saved..! ',
                          confirmButtonText: 'confirm',
                          cancelButtonText: 'cancel',
                          onConfirm: removeSaved
                          );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Remove',
                      child: Text('Remove'),
                    ),
                  ],
                ),
              ],
            ),
            kheight,
            Text(
              description,
              maxLines: 3,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.left,
            ),
            kheight,
            SizedBox(
              height: media.width * 0.984,
              width: media.width,
              child: CachedNetworkImage(
                imageUrl: mainImage,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return LoadingAnimationWidget.fourRotatingDots(
                      color: grey, size: 30);
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: customIconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: commentButtonPressed,
                      icon: const Icon(
                        Icons.mode_comment_outlined,
                        color: customIconColor,
                      ),
                    ),
                    // IconButton(onPressed: () {}, icon: Image.asset(savePostIcon))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('$likeCount likes'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
