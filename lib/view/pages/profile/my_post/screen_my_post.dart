import 'package:buzz_buddy/model/my_post_model/my_post_model.dart';
import 'package:buzz_buddy/utils/constants.dart';

import 'package:buzz_buddy/utils/functions.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/post_listing_page_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenMyPost extends StatelessWidget {
   final List<MyPostModel> post;
  const ScreenMyPost({super.key,required this.post});

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
          if(state is FetchMyPostLoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is FetchMyPostSuccesState){
             return ListView.builder(
              itemBuilder: (context, index) {
                // print(post[index].date);
                //  print(post[index].createdAt);
                return PostListingPageTile(media: media, mainImage: state.posts[index].image.toString(), profileImage: state.posts[index].userId?.profilePic??'', post: state.posts, onTapSettings: (){}, userName: state.posts[index].userId!.userName.toString(), postTime:formatDate( state.posts[index].createdAt.toString()), description:state.posts[index].description.toString() , likeCount: state.posts[index].likes!.length.toString(), commentCount: '2', likeButtonPressed: (){}, commentButtonPressed: (){},index:index);
                    
                    
              },
              itemCount: state.posts.length,
            );
          }
          return ListView.builder(
              itemBuilder: (context, index) {
                // print(post[index].date);
                //  print(post[index].createdAt);
                return PostListingPageTile(media: media, mainImage: post[index].image.toString(), profileImage: post[index].userId?.profilePic??'', post: post, onTapSettings: (){}, userName: post[index].userId!.userName.toString(), postTime:formatDate( post[index].createdAt.toString()), description:post[index].description.toString() , likeCount: post[index].likes!.length.toString(), commentCount: '2', likeButtonPressed: (){}, commentButtonPressed: (){},index:index);
                    
                    
              },
              itemCount: post.length,
            );
        },
      ),
    );
  }
}
