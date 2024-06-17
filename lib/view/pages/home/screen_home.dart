import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/comment_bottomsheet.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/home/commonwidgets/mainwidget.dart';
import 'package:buzz_buddy/view/pages/home/suggestions_page/screen_users_suggestion.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

String logginedUserToken = '';
String logginedUserId = '';


class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];
  @override
  void initState() {
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
    getToken();
    super.initState();
  }

  getToken() async {
    logginedUserToken = (await getUsertoken())!;
    logginedUserId = (await getUserId())!;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? kwhiteColor
            : black,
        title: Image.asset(
          appBarLogo,
          width: media.width * 0.26,
        ),
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenUsersSuggestion()));
              },
              icon: const Icon(
                Iconsax.user_cirlce_add,
              ))
        ],
      ),
      // backgroundColor: kwhiteColor,
      body: BlocBuilder<AllFollowersPostsBloc, AllFollowersPostsState>(
        builder: (context, state) {
          if (state is AllFollowersPostsSuccesfulState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeWidgetMain(
                    onLikeTap: () {},
                    onCommentTap: () {
                      context.read<GetCommentsBloc>().add(
                          CommentsFetchEvent(postId: state.post[index].id));
                      commentBottomSheet(
                          context, state.post[index], commentController,
                          formkey: _formkey,
                          userName: state.post[index].userId.userName,
                          profiePic:
                              state.post[index].userId.profilePic.toString(),
                          comments: _comments,
                          id: state.post[index].id.toString());
                    },
                    onSaveTap: () {},
                    media: media,
                    model: state.post[index],
                  ),
                );
              },
              itemCount: state.post.length,
            );
          } else if (state is AllFollowersPostsLoadingState) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: grey300!,
                  highlightColor: grey100!,
                  child: shimmerWidget1(media)),
            );
          } else {
            return const Center(
              child: Text('something went wrong try refresh'),
            );
          }
        },
      ),
    );
  }
}
