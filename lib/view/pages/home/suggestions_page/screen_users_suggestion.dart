import 'package:buzz_buddy/model/explore_users_user_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:buzz_buddy/view/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:buzz_buddy/view/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:buzz_buddy/view/bloc/suggestions_bloc/fetch_user_suggestions_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/commonwidget/list_tile.dart';
import 'package:buzz_buddy/view/pages/explore/explore_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class ScreenUsersSuggestion extends StatefulWidget {
  const ScreenUsersSuggestion({super.key});

  @override
  State<ScreenUsersSuggestion> createState() => _ScreenUsersSuggestionState();
}

class _ScreenUsersSuggestionState extends State<ScreenUsersSuggestion> {
  @override
  void initState() {
    context.read<FetchUserSuggestionsBloc>().add(OnfetchUserSuggestionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Suggestions'),
      ),
      body: BlocListener<FollowUnfollowBloc, FollowUnfollowState>(
        listener: (context, followState) {
          if (followState is FollowUserSuccesfulState ||
              followState is UnFollowUserSuccesfulState) {
            context
                .read<FetchUserSuggestionsBloc>()
                .add(OnfetchUserSuggestionEvent());
            context
                .read<FetchFollowingBloc>()
                .add(OnFetchFollowingUsersEvent());
            context
                .read<AllFollowersPostsBloc>()
                .add(AllFollowersPostsInitialFetchEvent());
          }
        },
        child:
            BlocConsumer<FetchUserSuggestionsBloc, FetchUserSuggestionsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchUserSuggestionsSuccessState) {
              if (state.suggessionModel.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No suggestions available at the moment.',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.suggessionModel.data!.length,
                  itemBuilder: (context, index) {
                    var suggestion = state.suggessionModel.data![index];
                    return BlocBuilder<FollowUnfollowBloc, FollowUnfollowState>(
                      builder: (context, followState) {
                        if (state is FollowUserLoadingState) {
                          return Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: grey,
                              size: 30,
                            ),
                          );
                        }
                        return CustomListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenExploreUserProfile(
                                      userId: state.suggessionModel.data![index].id
                                          .toString(),
                                      user: UserIdSearchModel(
                                          bio: state.suggessionModel.data![index].bio ??
                                              '',
                                          id: state.suggessionModel.data![index].id
                                              .toString(),
                                          userName: state.suggessionModel
                                              .data![index].userName
                                              .toString(),
                                          email: state.suggessionModel
                                              .data![index].email
                                              .toString(),
                                          profilePic: state.suggessionModel
                                              .data![index].profilePic
                                              .toString(),
                                          online: state.suggessionModel.data![index].online ?? true,
                                          blocked: state.suggessionModel.data![index].blocked ?? false,
                                          verified: state.suggessionModel.data![index].verified ?? false,
                                          role: state.suggessionModel.data![index].role.toString(),
                                          isPrivate: state.suggessionModel.data![index].isPrivate ?? false,
                                          backGroundImage: state.suggessionModel.data![index].backGroundImage.toString(),
                                          createdAt: state.suggessionModel.data![index].createdAt ?? DateTime(2000),
                                          updatedAt: state.suggessionModel.data![index].updatedAt ?? DateTime(2000),
                                          v: state.suggessionModel.data![index].v ?? 0)),
                                ));
                          },
                          buttonText: 'Follow',
                          onUnfollow: () {
                            context.read<FollowUnfollowBloc>().add(
                                  OnFollowButtonClickedEvent(
                                    followeesId: suggestion.id.toString(),
                                  ),
                                );
                          },
                          profileImageUrl: suggestion.profilePic.toString(),
                          titleText: suggestion.userName.toString(),
                          imageSize: media.height * 0.05,
                          backgroundColor: kwhiteColor,
                          borderRadius: BorderRadius.circular(100),
                        );
                      },
                    );
                  },
                );
              }
            } else if (state is FetchUserSuggestionsLoadingState) {
              // Show shimmer
              return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: grey300!,
                    highlightColor: grey100!,
                    child: shimmerTile(),
                  );
                },
              );
            } else if (state is FetchUserSuggestionsErroState) {
              // Show error
              return const Center(
                child: Text(
                  'Failed to load suggestions. Please try again later.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No suggestions available at the moment.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
