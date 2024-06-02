part of 'add_post_bloc.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}
final class AddPostSuccesState extends AddPostState {}
final class AddPostErrorState extends AddPostState {}
final class AddPostLoadingstate extends AddPostState {}
final class SelectImageToPostSuccessState extends AddPostState{}
final class SelectImageToPostError extends AddPostState{}
final class SelectImageToPostLoadingstate extends AddPostState{}
