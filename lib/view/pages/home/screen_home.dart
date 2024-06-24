import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/comment_bottomsheet.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/loading_animation_widget.dart';
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
  TextEditingController commentControllers = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
    getToken();
  }

  Future<void> _onRefresh() async {
    // Trigger a re-fetch of the posts
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
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
        title: Image.asset(appBarLogo, width: media.width * 0.26),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScreenUsersSuggestion()));
            },
            icon: const Icon(Iconsax.user_cirlce_add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<AllFollowersPostsBloc, AllFollowersPostsState>(
          builder: (context, state) {
            if (state is AllFollowersPostsSuccesfulState) {
              if (state.post.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HomeWidgetMain(
                        onCommentTap: () {
                          //   context.read<GetCommentsBloc>().add(
                          //       CommentsFetchEvent(
                          //           postId: state.post[index].id.toString()));
                          //   commentBottomSheet(
                          //       context, state.post[index], commentControllers,
                          //       formkey: _formkey,
                          //       // userName:
                          //       //     state.post[index].userId.userName.toString(),
                          //       // profiePic: state.post[index].userId.profilePic
                          //       //   .toString(),
                          //       comments: _comments,
                          //       id: state.post[index].id.toString());
                          //   context.read<GetCommentsBloc>().add(
                          //       CommentsFetchEvent(
                          //           postId: state.post[index].id.toString()));
                          //   //   context
                          //   //       .read<AllFollowersPostsBloc>()
                          //   //       .add(AllFollowersPostsInitialFetchEvent());
                          context.read<GetCommentsBloc>().add(
                              CommentsFetchEvent(
                                  postId: state.post[index].id.toString()));
                          commentBottomSheet(
                              context, state.post[index], commentControllers,
                              formkey: _formkey,
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
              } else {
                return errorStateWidget(
                    'No feeds available, follow someone', greyMeduim);
              }
            } else if (state is AllFollowersPostsLoadingState) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: grey300!,
                  highlightColor: grey100!,
                  child: shimmerWidget1(media),
                ),
              );
            } else {
              return const Center(
                  child: Text('Something went wrong, try refreshing.'));
            }
          },
        ),
      ),
    );
  }
}
