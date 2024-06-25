part of 'fetch_followers_bloc.dart';

@immutable
sealed class FetchFollowersState {}

final class FetchFollowersInitial extends FetchFollowersState {}
final class FetchFollowersSuccesState extends FetchFollowersState {
      final FollowersModel followersModel;

  FetchFollowersSuccesState({required this.followersModel});
}
final class FetchFollowersErrorState extends FetchFollowersState {}
final class FetchFollowersLoadingState extends FetchFollowersState {}
