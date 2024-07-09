import 'package:buzz_buddy/model/comment_model.dart';
import 'package:buzz_buddy/view/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/comment_bottomsheet.dart';
import 'package:buzz_buddy/view/pages/home/commonwidgets/load_more_loading_widget.dart';
import 'package:buzz_buddy/view/pages/home/commonwidgets/mainwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildPostList({
  required BuildContext context,
  required Size media,
  required List<dynamic> posts,
  required ScrollController scrollController,
  required bool isLoadingMore,
  required TextEditingController commentControllers,
  required GlobalKey<FormState> formKey,
  required List<Comment> comments,
}) {
  return ListView.builder(
    controller: scrollController,
    itemCount: posts.length + 1, // Extra item for the loading indicator
    itemBuilder: (context, index) {
      if (index == posts.length) {
        return LoadingIndicator(isLoadingMore: isLoadingMore);
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: HomeWidgetMain(
          onCommentTap: () {
            context.read<GetCommentsBloc>().add(CommentsFetchEvent(
                postId: posts[index].id.toString()));
            commentBottomSheet(context, posts[index], commentControllers,
                formkey: formKey,
                comments: comments,
                id: posts[index].id.toString());
          },
          onSaveTap: () {},
          media: media,
          model: posts[index],
          index: index,
        ),
      );
    },
  );
}