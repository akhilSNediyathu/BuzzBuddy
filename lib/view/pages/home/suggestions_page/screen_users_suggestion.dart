import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/suggestions_bloc/fetch_user_suggestions_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/commonwidget/list_tile.dart';
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
    // Fetch user suggestions when the widget is initialized
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FollowUnfollowBloc(),
          ),
          BlocProvider(
            create: (context) =>
                FetchUserSuggestionsBloc()..add(OnfetchUserSuggestionEvent()),
          ),
        ],
        child: BlocListener<FollowUnfollowBloc, FollowUnfollowState>(
          listener: (context, followState) {
            if (followState is FollowUserSuccesfulState ||
                followState is UnFollowUserSuccesfulState) {
              // Refetch suggestions after follow/unfollow action
              context
                  .read<FetchUserSuggestionsBloc>()
                  .add(OnfetchUserSuggestionEvent());
            }
          },
          child:
              BlocBuilder<FetchUserSuggestionsBloc, FetchUserSuggestionsState>(
            builder: (context, state) {
              if (state is FetchUserSuggestionsSuccessState) {
                // Check if there are suggestions available
                if (state.suggessionModel.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No suggestions available at the moment.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  // Display list of suggestions
                  return ListView.builder(
                    itemCount: state.suggessionModel.data!.length,
                    itemBuilder: (context, index) {
                      var suggestion = state.suggessionModel.data![index];
                      return BlocBuilder<FollowUnfollowBloc,
                          FollowUnfollowState>(
                        builder: (context, followState) {
                          if (state is FollowUserLoadingState) {
                            Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: grey, size: 30),
                            );
                          }
                          return CustomListTile(
                            buttonText: 'Follow',
                            onUnfollow: () {
                              context.read<FollowUnfollowBloc>().add(
                                  OnFollowButtonClickedEvent(
                                      followeesId: suggestion.id.toString()));
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
                // Show shimmer effect while loading
                return ListView.builder(
                  itemCount: 6, // Number of shimmer tiles to show
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: grey300!,
                      highlightColor: grey100!,
                      child: shimmerTile(),
                    );
                  },
                );
              } else if (state is FetchUserSuggestionsErroState) {
                // Show error message if there was an error loading suggestions
                return const Center(
                  child: Text(
                    'Failed to load suggestions. Please try again later.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                );
              } else {
                // Fallback for any other states
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
      ),
    );
  }
}
