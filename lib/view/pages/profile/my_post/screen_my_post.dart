import 'package:buzz_buddy/model/my_post_model/my_post_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/post_listing_page_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ScreenMyPost extends StatefulWidget {
  final List<MyPostModel> post;

  const ScreenMyPost({super.key, required this.post});

  @override
  State<ScreenMyPost> createState() => _ScreenMyPostState();
}

class _ScreenMyPostState extends State<ScreenMyPost> {
  @override
  void initState() {
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Posts'),
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
      ),
      body: BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
        builder: (context, state) {
          if (state is FetchMyPostLoadingState) {
            return ListView.builder(
              itemCount: 6, 
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: grey300!,
                  highlightColor: grey100!,
                  child: shimmerWidget1(media)
                );
              },
            );
          } else if (state is FetchMyPostSuccesState) {
            if (state.posts.isEmpty) {
              return const Center(child: Text('No posts available.'));
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                final postItem = state.posts[index];
                return PostListingPageTile(
                  media: media,
                  mainImage: postItem.image.toString(),
                  profileImage: postItem.userId?.profilePic ?? '',
                  post: state.posts,
                  onTapSettings: () {},
                  userName: postItem.userId?.userName.toString() ?? '',
                  postTime: formatDate(postItem.createdAt.toString()),
                  description: postItem.description.toString(),
                  likeCount: postItem.likes!.length.toString(),
                  commentCount: '2', // need to add
                  likeButtonPressed: () {},
                  commentButtonPressed: () {},
                  index: index,
                );
              },
              itemCount: state.posts.length,
            );
          } else if (state is FetchMyPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No posts available.'));
        },
      ),
    );
  }
}
