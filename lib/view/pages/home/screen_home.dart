import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/services/socket/socket.dart';
import 'package:buzz_buddy/view/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:buzz_buddy/view/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/comment_bottomsheet.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/home/commonwidgets/load_more_loading_widget.dart';
import 'package:buzz_buddy/view/pages/home/commonwidgets/mainwidget.dart';
import 'package:buzz_buddy/view/pages/home/commonwidgets/post_list_builder.dart';
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
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _posts = [];
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    SocketService().connectSocket(context: context);
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
    getToken();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      context.read<AllFollowersPostsBloc>().add(LoadMoreEvent());
    }
  }

  Future<void> _onRefresh() async {
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
              _posts = state.post;
              _isLoadingMore = false;
            } else if (state is FetchMoreSuccesState) {
              _posts = [..._posts, ...state.post];
              _isLoadingMore = false;
            }

            if (_posts.isNotEmpty) {
              return buildPostList(
                context: context,
                media: media,
                posts: _posts,
                scrollController: _scrollController,
                isLoadingMore: _isLoadingMore,
                commentControllers: commentControllers,
                formKey: _formkey,
                comments: _comments,
              );
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong, try refreshing.'),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _onRefresh,
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }


  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
