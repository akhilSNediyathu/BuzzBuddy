part of 'like_unlike_post_bloc.dart';

@immutable
sealed class LikeUnlikePostState {}

final class LikeUnlikePostInitial extends LikeUnlikePostState {}
final class LikePostNotFoundState extends LikeUnlikePostState {}

final class LikePostLoadingState extends LikeUnlikePostState {}

final class LikePostAlreadyLikedState extends LikeUnlikePostState {}

final class LikePostSuccesfulState extends LikeUnlikePostState {}

final class LikePostServerErrorState extends LikeUnlikePostState {}

final class UnlikePostLoadingState extends LikeUnlikePostState {}

final class UnlikePostNotFoundState extends LikeUnlikePostState {}

final class UnlikePostUserNotLikedPostState extends LikeUnlikePostState {}

final class UnlikePostServerErrorState extends LikeUnlikePostState {}

final class UnlikePostSuccesfulState extends LikeUnlikePostState{}