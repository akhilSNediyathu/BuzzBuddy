part of 'fetch_explore_bloc.dart';

@immutable
sealed class FetchExploreState {}

final class FetchExploreInitial extends FetchExploreState {}
final class FetchExplorePostsSuccesState extends FetchExploreState{
      final List<ExplorePostModel> posts;

  FetchExplorePostsSuccesState({required this.posts});

}
final class FetchExplorePostsErrorState extends FetchExploreState {}
final class FetchExplorePostsLoadingState extends FetchExploreState {}
