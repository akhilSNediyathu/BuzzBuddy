import 'package:buzz_buddy/model/my_post_model/my_post_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/showdialogue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PostListingPageTile extends StatelessWidget {
   final List<MyPostModel> post;
  const PostListingPageTile({
    super.key,
    required this.media,
    required this.mainImage,
    required this.profileImage, required this.post, required this.userName, required this.postTime, required this.description, required this.likeCount, required this.commentCount, required this.likeButtonPressed, required this.commentButtonPressed, required this.index
  });
  final String profileImage;
  final String mainImage;
  //  final void Function() onTapSettings;
   final String userName;
   final String postTime;
   final String description;
   final String likeCount;
   final String commentCount;
   final VoidCallback likeButtonPressed;
   final VoidCallback commentButtonPressed;

  final Size media;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                          image: NetworkImage(profileImage), fit: BoxFit.cover),
                      color: kwhiteColor,
                      borderRadius: kradius100),
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
                 PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == 'Edit') {
                      // Handle edit
                      //print('Edit selected');
                    } else if (result == 'Delete') {
                       showConfirmationDialog(context: context, title: 'Are you sure?', content: 'this action will remove this post permenently ', confirmButtonText: 'confirm', cancelButtonText: 'cancel', onConfirm: ()async{
                             context.read<FetchMyPostBloc>().add(OnMyPostDeleteButtonPressedEvent(postId: post[index].id.toString()));
                             context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
                       });
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
              
            
            kheight,
             Text(
               description,
               maxLines: 3,
               style: const TextStyle(
                 overflow: TextOverflow.ellipsis,
               ),
               textAlign: TextAlign.left,
             ),
            kheight,
            Container(
              color: Colors.blue,
              height: media.width * 0.984,
              child: CachedNetworkImage(imageUrl: mainImage,fit: BoxFit.cover, placeholder: (context, url) {
            return LoadingAnimationWidget.fourRotatingDots(color: grey, size: 30);
          },
          ),
            ),
            Column(
           
              children: [
                Row(
                  
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          likeIcon,
                          width: 65,
                          fit: BoxFit.cover,
                        )),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        commentIcon,
                      ),
                    ),
                  // IconButton(onPressed: () {}, icon: Image.asset(savePostIcon))
                  ],
                ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                   child: Text('$likeCount likes'),
                 )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
