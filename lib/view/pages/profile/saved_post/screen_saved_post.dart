import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/model/saved_post_model.dart';
import 'package:buzz_buddy/utils/constants.dart';

import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/comment_bottomsheet.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/loading_animation_widget.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/explore_page_shimmer.dart';
import 'package:buzz_buddy/view/pages/profile/saved_post/saved_post_tile.dart';
import 'package:buzz_buddy/view/pages/profile/screen_profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSavedPost extends StatelessWidget {
  ScreenSavedPost({super.key, required this.model});
  final List<SavedPostModel> model;
  final TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Saved Posts'),
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
      ),
      body: BlocBuilder<FetchSavedPostsBloc, FetchSavedPostsState>(
        builder: (context, state) {
          if (state is FetchSavedPostsSuccesfulState) {
            if (state.posts.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return SavedPostListingPageTile(
                    statesaved: state,
                    media: media,
                    mainImage: state.posts[index].postId.image,
                    profileImage: state.posts[index].postId.userId.profilePic,
                    userName: state.posts[index].postId.userId.userName,
                    postTime: state.posts[index].createdAt ==
                            state.posts[index].editedTime
                        ? formatDate(state.posts[index].createdAt.toString())
                        : ("${formatDate(state.posts[index].editedTime.toString())} (Edited)"),
                    description: state.posts[index].postId.description,
                    likeCount:
                        state.posts[index].postId.likes.length.toString(),
                    commentCount: '',
                    likeButtonPressed: () {},
                    removeSaved: () async {
                      context.read<SavedPostBloc>().add(
                          RemoveSavedPostButtonClickEvent(
                              postId: state.posts[index].postId.id));
                      context
                          .read<FetchSavedPostsBloc>()
                          .add(SavedPostsInitialFetchEvent());
                    },
                    commentButtonPressed: () {
                      context.read<GetCommentsBloc>().add(CommentsFetchEvent(
                          postId: state.posts[index].postId.id.toString()));
                      commentBottomSheet(
                          context, state.posts[index].postId, commentController,
                          formkey: _formkey,
                          userName: profileuserName,
                          profiePic: logginedUserProfileImage,
                          comments: _comments,
                          id: state.posts[index].postId.id.toString());
                    },
                    index: index,
                  );
                },
                itemCount: state.posts.length,
              );
            } else {
              return errorStateWidget('no items found', greyMeduim);
            }
          } else if (state is FetchSavedPostsLoadingState) {
            return explorePostShimmerLoading();
          } else {
            return errorStateWidget('something went wrong', greyMeduim);
          }
        },
      ),
    );
  }
}
