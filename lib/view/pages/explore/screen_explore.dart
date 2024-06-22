import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_explore_bloc/fetch_explore_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/comment_bottomsheet.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/loading_animation_widget.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/main_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ScreenExplore extends StatelessWidget {
   ScreenExplore({super.key});
    TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "explore",
          style: appBarTitleStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(child: BlocBuilder<FetchExploreBloc, FetchExploreState>(
        builder: (context, state) {
          if (state is FetchExplorePostsSuccesState) {
            if (state.posts.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ExplorePageMainTile(
                      media: media,
                      mainImage: state.posts[index].image,
                      profileImage: state.posts[index].userId.profilePic,
                      userName: state.posts[index].userId.userName,
                      postTime:
                          formatDate(state.posts[index].createdAt.toString()),
                      description: state.posts[index].description,
                      likeCount: state.posts[index].likes.length.toString(),
                      commentCount: '',
                      index: index,
                      removeSaved: () async {},
                      statesaved: state,
                      likeButtonPressed: () {},
                      commentButtonPressed: () {
                        context.read<GetCommentsBloc>().add(
                              CommentsFetchEvent(
                                  postId: state.posts[index].id.toString()));
                          commentBottomSheet(
                              context, state.posts[index], commentController,
                              formkey: _formkey,
                              userName:
                                  state.posts[index].userId.userName.toString(),
                              profiePic: state.posts[index].userId.profilePic
                                  .toString(),
                              comments: _comments,
                              id: state.posts[index].id.toString());
                          context.read<GetCommentsBloc>().add(
                              CommentsFetchEvent(
                                  postId: state.posts[index].id.toString()));
                      });
                },
                itemCount: state.posts.length,
              );
            } else {
              return errorStateWidget('No data found ', greyMeduim);
            }
          } else if (state is FetchExplorePostsLoadingState) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: grey300!,
                highlightColor: grey100!,
                child: shimmerWidget1(media),
              ),
            );
          } else {
            return errorStateWidget(
                'something went wrong try refreshing', greyMeduim);
          }
        },
      )),
    );
  }
}
