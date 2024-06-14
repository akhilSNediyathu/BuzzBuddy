part of 'follow_unfollow_bloc.dart';

@immutable
sealed class FollowUnfollowState {}

final class FollowUnfollowInitial extends FollowUnfollowState {}

final class FollowUserLoadingState extends FollowUnfollowState {}

final class FollowUserSuccesfulState extends FollowUnfollowState {}

final class FollowUserErrorState extends FollowUnfollowState {}

final class UnFollowUserErrorState extends FollowUnfollowState {}

final class UnFollowUserSuccesfulState extends FollowUnfollowState {}

final class UnFollowUserLoadingState extends FollowUnfollowState {}
