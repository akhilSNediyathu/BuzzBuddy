// part of 'all_followers_posts_bloc.dart';

// ignore_for_file: prefer_typing_uninitialized_variables

part of 'all_followers_posts_bloc.dart';

@immutable
sealed class AllFollowersPostsState {}

final class AllFollowersPostsInitial extends AllFollowersPostsState {}

final class AllFollowersPostsLoadingState extends AllFollowersPostsState {}

final class AllFollowersPostsSuccesfulState extends AllFollowersPostsState {
  final List<FollwersPostModel> post;

  AllFollowersPostsSuccesfulState({required this.post});
}

final class AllFollowersPostsServerErrorState extends AllFollowersPostsState {}

final class FetchMoreLoadingState extends AllFollowersPostsState {}

final class FetchMoreSuccesState extends AllFollowersPostsState {
  final List<FollwersPostModel> post;

  FetchMoreSuccesState({required this.post});
}

final class FetchMoreErrorState extends AllFollowersPostsState {}