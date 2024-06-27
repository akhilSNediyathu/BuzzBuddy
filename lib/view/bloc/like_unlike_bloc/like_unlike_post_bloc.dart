import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// ignore: unnecessary_import
import 'package:meta/meta.dart';

part 'like_unlike_post_event.dart';
part 'like_unlike_post_state.dart';

class LikeUnlikePostBloc extends Bloc<LikeUnlikePostEvent, LikeUnlikePostState> {
  LikeUnlikePostBloc() : super(LikeUnlikePostInitial()) {
    on<LikeUnlikePostEvent>((event, emit) {
     
    });
       
    on<LikePostButtonClickEvent>(likePostButtonClickEvent);
    on<UnlikePostButtonClickEvent>(unlikePostButtonClickEvent);
  }

  Future<void> likePostButtonClickEvent(
      LikePostButtonClickEvent event, Emitter<LikeUnlikePostState> emit) async {
    emit(LikePostLoadingState());
    final Response result = await PostRepo.likePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);
    debugPrint(result.statusCode.toString());
    debugPrint(result.body);
    if (result.statusCode == 200) {
      emit(LikePostSuccesfulState());
    } else if (responseBody['status'] == 404) {
      emit(LikePostNotFoundState());
    } else if (responseBody['message'] == 'User already liked the post') {
      emit(LikePostAlreadyLikedState());
    } else if (responseBody['status'] == 500) {
      emit(LikePostServerErrorState());
    }
  }

  Future<void> unlikePostButtonClickEvent(
      UnlikePostButtonClickEvent event, Emitter<LikeUnlikePostState> emit) async {
    emit(UnlikePostLoadingState());
    final Response result = await PostRepo.unlikePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);
    debugPrint(result.statusCode.toString());
    debugPrint(result.body);
    if (result.statusCode == 200) {
      emit(UnlikePostSuccesfulState());
    } else if (responseBody['status'] == 404) {
      emit(UnlikePostNotFoundState());
    } else if (responseBody['message'] == 'User has not liked the post') {
      emit(UnlikePostUserNotLikedPostState());
    } else if (responseBody['status'] == 500) {
      emit(UnlikePostServerErrorState());
}

  }
}
