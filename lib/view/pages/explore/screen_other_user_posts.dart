// ignore_for_file: must_be_immutable

import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/model/post_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/profile_posts_bloc/profile_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/comment_bottomsheet.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/main_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ScreenOtherUserPosts extends StatelessWidget {
  final List<Post> posts;
  ScreenOtherUserPosts({super.key, required this.posts});
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _commentss = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: appBarTitleStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
            if(state is ProfilePostFetchSuccesfulState){
             return ListView.builder(
            itemBuilder: (context, index) {
              return ExplorePageMainTile(
                  media: media,
                  mainImage: posts[index].image,
                  profileImage: posts[index].userId.profilePic,
                  userName: posts[index].userId.userName,
                  postTime: formatDate(posts[index].createdAt.toString()),
                  description: posts[index].description,
                  likeCount: posts[index].likes.length.toString(),
                  commentCount: '',
                  index: index,
                  removeSaved: () async {},
                  statesaved: state,
                  likeButtonPressed: () {},
                  commentButtonPressed: ()async {
                    context.read<GetCommentsBloc>().add(
                        CommentsFetchEvent(postId: posts[index].id.toString()));
                    commentBottomSheet(context, posts[index], commentController,
                        formkey: _formkey,
                        // userName: posts[index].userId.userName.toString(),
                        // profiePic: posts[index].userId.profilePic.toString(),
                        comments: _commentss,
                        id: posts[index].id.toString());
                    context.read<GetCommentsBloc>().add(
                        CommentsFetchEvent(postId: posts[index].id.toString()));
                  });
            },
            itemCount: posts.length,
          );
            }else{
                   return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: grey300!,
                    highlightColor: grey100!,
                    child: shimmerWidget1(media));
              },
            );
            }
          
        },
      ),
    );
  }
}
