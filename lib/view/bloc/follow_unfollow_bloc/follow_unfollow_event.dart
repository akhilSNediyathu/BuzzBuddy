part of 'follow_unfollow_bloc.dart';

@immutable
sealed class FollowUnfollowEvent {}
final class OnFollowButtonClickedEvent extends FollowUnfollowEvent{
      final String followeesId;

  OnFollowButtonClickedEvent({required this.followeesId});
}
final class OnUnFollowButtonClickedEvent extends FollowUnfollowEvent{
      final String followeesId;

  OnUnFollowButtonClickedEvent({required this.followeesId});
}