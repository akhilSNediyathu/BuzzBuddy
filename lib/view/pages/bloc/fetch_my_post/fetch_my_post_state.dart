part of 'fetch_my_post_bloc.dart';

@immutable
sealed class FetchMyPostState {}

final class FetchMyPostInitial extends FetchMyPostState {}

final class FetchMyPostSuccesState extends FetchMyPostState {
  final List<MyPostModel> posts;

  FetchMyPostSuccesState({required this.posts});
}

final class FetchMyPostLoadingState extends FetchMyPostState {}

final class FetchMyPostErrorState extends FetchMyPostState {
  final String error;

  FetchMyPostErrorState({required this.error});
}
