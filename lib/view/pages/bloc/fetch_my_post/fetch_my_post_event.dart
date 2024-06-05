part of 'fetch_my_post_bloc.dart';

@immutable
sealed class FetchMyPostEvent {}

final class FetchAllMyPostsEvent extends FetchMyPostEvent {}
final class OnMyPostDeleteButtonPressedEvent extends FetchMyPostEvent{
  final String postId;

  OnMyPostDeleteButtonPressedEvent({required this.postId});
}
