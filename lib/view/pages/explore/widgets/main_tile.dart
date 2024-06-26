import 'package:buzz_buddy/utils/constants.dart';


import 'package:buzz_buddy/view/bloc/like_unlike_bloc/like_unlike_post_bloc.dart';
import 'package:buzz_buddy/view/pages/home/screen_home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:readmore/readmore.dart';

class ExplorePageMainTile extends StatelessWidget {
  const ExplorePageMainTile({
    super.key,
    required this.media,
    required this.mainImage,
    required this.profileImage,
    required this.userName,
    required this.postTime,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.index,
    required this.removeSaved,
    required this.statesaved,
    required this.likeButtonPressed,
    required this.commentButtonPressed,
  });

  final String profileImage;
  final String mainImage;
  final String userName;
  final String postTime;
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final VoidCallback? commentButtonPressed;
  final Future<void> Function() removeSaved;
  final dynamic statesaved;
  final Size media;
  final int index;

  @override
  Widget build(BuildContext context) {
    final post = statesaved.posts[index];

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
                      image: NetworkImage(profileImage),
                      fit: BoxFit.cover,
                    ),
                    color: kwhiteColor,
                    borderRadius: kradius100,
                  ),
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
                //
              ],
            ),
            kheight,
            ReadMoreText(
              description,
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: blueAccent,
              trimCollapsedText: 'more.',
              style: const TextStyle(fontWeight: FontWeight.w500),
              trimExpandedText: 'show less',
              moreStyle: const TextStyle(
                  fontSize: 14, color: grey, fontWeight: FontWeight.bold),
              lessStyle: const TextStyle(
                  fontSize: 14, color: grey, fontWeight: FontWeight.bold),
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
            BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState>(
              builder: (context, state) {
                bool isLiked = post.likes.contains(logginedUserId);
                int currentLikeCount = post.likes.length;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isLiked) {
                              context.read<LikeUnlikePostBloc>().add(
                                    UnlikePostButtonClickEvent(postId: post.id),
                                  );

                              post.likes.remove(logginedUserId);
                            } else {
                              context.read<LikeUnlikePostBloc>().add(
                                    LikePostButtonClickEvent(postId: post.id),
                                  );

                              post.likes.add(logginedUserId);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? red : customIconColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: commentButtonPressed,
                          icon: const Icon(
                            Icons.mode_comment_outlined,
                            color: customIconColor,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '$currentLikeCount likes',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
