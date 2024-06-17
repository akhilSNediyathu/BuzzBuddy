part of 'fetch_explore_bloc.dart';

@immutable
sealed class FetchExploreEvent {}
final class OnFetchExplorePostsEvent extends FetchExploreEvent{}
