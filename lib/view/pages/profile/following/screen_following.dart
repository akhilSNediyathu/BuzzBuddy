import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/showdialogue.dart';
import 'package:buzz_buddy/view/pages/commonwidget/list_tile.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ScreenFollowing extends StatelessWidget {
  const ScreenFollowing({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Following',
          style: appBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FetchFollowingBloc, FetchFollowingState>(
            listener: (context, state) {
              if (state is FetchFollowingErrorState) {
                customSnackbar(context, 'failed..!', amber);
              }
            },
          ),
          BlocListener<FollowUnfollowBloc, FollowUnfollowState>(
            listener: (context, state) {
              if (state is UnFollowUserSuccesfulState) {
                context
                    .read<FetchFollowingBloc>()
                    .add(OnFetchFollowingUsersEvent());
              } else if (state is UnFollowUserErrorState) {}
            },
          ),
        ],
        child: BlocBuilder<FetchFollowingBloc, FetchFollowingState>(
          builder: (context, state) {
            if (state is FetchFollowingLoadingState ||
                state is UnFollowUserLoadingState) {
              return ListView.builder(
                itemBuilder: (context, index) => shimmerTile(),
                itemCount: 5,
              );
            } else if (state is FetchFollowingSuccesState) {
              final followings = state.model.following;

              if (followings.isEmpty) {
                return const Center(
                  child: Text(
                    'No followers yet.',
                  ),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: CustomListTile(
                      buttonText: 'unfollow',
                      profileImageUrl: followings[index].profilePic,
                      titleText: followings[index].userName,
                      onUnfollow: () {
                        showConfirmationDialog(
                          context: context,
                          title: "Are you sure?",
                          content: "Unfollow this user?",
                          confirmButtonText: 'Unfollow',
                          cancelButtonText: 'Cancel',
                          onConfirm: () async {
                            context.read<FollowUnfollowBloc>().add(
                                OnUnFollowButtonClickedEvent(
                                    followeesId: followings[index].id));
                          },
                        );
                      },
                      imageSize: media.height * 0.05,
                      backgroundColor: kwhiteColor,
                      borderRadius: BorderRadius.circular(100)),
                ),
                itemCount: followings.length,
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor,
                  size: 30,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
