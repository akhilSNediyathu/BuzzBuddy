import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/model/followers_posts_model.dart';
import 'package:buzz_buddy/model/followers_userid_model.dart';
import 'package:buzz_buddy/model/saved_post_model.dart';

import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:buzz_buddy/view/bloc/like_unlike_bloc/like_unlike_post_bloc.dart';
import 'package:buzz_buddy/view/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:buzz_buddy/view/pages/home/suggestions_page/screen_users_suggestion.dart';
import 'package:buzz_buddy/view/pages/profile/screen_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:readmore/readmore.dart';

import '../../../../model/user_suggestion_model.dart';

// ignore: must_be_immutable
class HomeWidgetMain extends StatelessWidget {
  HomeWidgetMain({
    super.key,
    required this.media,
    required this.model,
    required this.onCommentTap,
    required this.onSaveTap,
    required this.index,
  });

  final Size media;
  final FollwersPostModel model;

  final VoidCallback onCommentTap;
  final VoidCallback onSaveTap;
  final int index;

  List<SavedPostModel> posts = [];
  List<Comment> comments = [];

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(model.createdAt.toString());
    final editedTime = DateTime.parse(model.editedTime.toString());

    bool isEdited =
        !areDateTimesEqualIgnoringMilliseconds(createdAt, editedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: model.userId.profilePic.toString(),
              imageBuilder: (context, imageProvider) => Container(
                height: media.height * 0.065,
                width: media.height * 0.065,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  color: kwhiteColor,
                  borderRadius: kradius100,
                ),
              ),
              placeholder: (context, url) => const CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: grey,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            kwidth,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.userId.name ?? model.userId.userName.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  isEdited
                      ? "${formatDate(editedTime.toString())} (Edited)"
                      : formatDate(createdAt.toString()),
                ),
              ],
            )
          ],
        ),
        kheight,
        // Post Description Section
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ReadMoreText(
            model.description ?? '',
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
        ),
        kheight,
        // Post Image Section
        SizedBox(
          height: media.width * 0.984,
          width: media.width,
          child: CachedNetworkImage(
            imageUrl: model.image.toString(),
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return LoadingAnimationWidget.fourRotatingDots(
                  color: grey, size: 30);
            },
          ),
        ),
        MultiBlocBuilder(
          blocs: [
            context.watch<LikeUnlikePostBloc>(),
            context.watch<FetchSavedPostsBloc>(),
            context.watch<SavedPostBloc>(),
          ],
          builder: (context, state) {
            var state2 = state[1];
            if (state2 is FetchSavedPostsSuccesfulState) {
              posts = state2.posts;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        final currentUserId = userdetails.id;
                        final isLiked =
                            model.likes.any((user) => user.id == currentUserId);
                        if (!isLiked) {
                          model.likes.add(FollowersUserIdModel.fromJson(User(
                                  id: userdetails.id,
                                  userName: userdetails.userName,
                                  email: userdetails.email,
                                  profilePic: userdetails.profilePic,
                                  phone: userdetails.phone,
                                  online: userdetails.online,
                                  blocked: userdetails.blocked,
                                  verified: userdetails.verified,
                                  createdAt: userdetails.createdAt,
                                  updatedAt: userdetails.updatedAt,
                                  v: 1,
                                  role: userdetails.role,
                                  backGroundImage: userdetails.backGroundImage,
                                  isPrivate: userdetails.isPrivate)
                              .toJson()));

                          context.read<LikeUnlikePostBloc>().add(
                              LikePostButtonClickEvent(
                                  postId: model.id.toString()));
                        } else {
                          model.likes
                              .removeWhere((user) => user.id == currentUserId);
                          context.read<LikeUnlikePostBloc>().add(
                              UnlikePostButtonClickEvent(
                                  postId: model.id.toString()));
                        }
                      },
                      icon: Icon(
                        model.likes.any((user) => user.id == userdetails.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            model.likes.any((user) => user.id == userdetails.id)
                                ? red
                                : customIconColor,
                      ),
                    ),
                    Text('${model.likes.length} likes'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: onCommentTap,
                      icon: const Icon(
                        Icons.mode_comment_outlined,
                      ),
                      iconSize: 28,
                      color: customIconColor,
                    ),
                    Text("${model.commentCount} comments")
                  ],
                ),
                IconButton(
                    onPressed: () {
                      if (posts
                          .any((element) => element.postId.id == model.id)) {
                        context.read<SavedPostBloc>().add(
                            RemoveSavedPostButtonClickEvent(
                                postId: model.id.toString()));
                        posts.removeWhere(
                            (element) => element.postId.id == model.id);
                      } else {
                        posts.add(SavedPostModel(
                            userId: model.userId.id.toString(),
                            postId: PostId(
                                id: model.id.toString(),
                                userId: UserIdSavedPost.fromJson(
                                    model.userId.toJson()),
                                image: model.image.toString(),
                                description: model.description.toString(),
                                likes: model.likes,
                                hidden: model.hidden,
                                blocked: model.blocked,
                                tags: model.tags,
                                date: model.date,
                                createdAt: model.createdAt,
                                updatedAt: model.updatedAt,
                                v: model.v,
                                taggedUsers: model.taggedUsers),
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            v: model.v));
                        context.read<SavedPostBloc>().add(
                            SavePostButtonClickEvent(
                                postId: model.id.toString()));
                      }
                    },
                    icon: Icon(
                      posts.any((element) => element.postId.id == model.id)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: customIconColor,
                      size: 25,
                    ))
              ],
            );
          },
        )
      ],
    );
  }

  bool areDateTimesEqualIgnoringMilliseconds(
      DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour &&
        dateTime1.minute == dateTime2.minute &&
        dateTime1.second == dateTime2.second;
  }
}

Widget noFeedAvailableMessage(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No feed available!',
          style: TextStyle(),
        ),
        const SizedBox(height: 10),
        const Text(
          'Follow someone to see their posts or explore suggestions.',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenUsersSuggestion(),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Go to Suggestions?'),
        ),
      ],
    ),
  );
}
