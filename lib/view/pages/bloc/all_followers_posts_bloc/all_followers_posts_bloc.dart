import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/followers_posts_model.dart';
import 'package:buzz_buddy/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Importing the new models

part 'all_followers_posts_event.dart';
part 'all_followers_posts_state.dart';

class AllFollowersPostsBloc
    extends Bloc<AllFollowersPostsEvent, AllFollowersPostsState> {
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  AllFollowersPostsBloc() : super(AllFollowersPostsInitial()) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        add(LoadMoreEvent());
      }
    });

    on<AllFollowersPostsEvent>((event, emit) {});
    on<AllFollowersPostsInitialFetchEvent>(allFollowersPostsInitialFetchEvent);
    on<LoadMoreEvent>(loadMoreEvent);
  }

  FutureOr<void> allFollowersPostsInitialFetchEvent(
      AllFollowersPostsInitialFetchEvent event,
      Emitter<AllFollowersPostsState> emit) async {
    emit(AllFollowersPostsLoadingState());

    // Reset page for initial fetch
    page = 1;

    try {
      final http.Response result = await PostRepo.getFollowersPost(page: page);

      final List<dynamic> responseBody = jsonDecode(result.body);

      debugPrint('Status code: ${result.statusCode}');
    

      if (result.statusCode == 200) {
        List<FollowersPostModel> posts = responseBody
            .map((json) => FollowersPostModel.fromJson(json))
            .toList();
       
        emit(AllFollowersPostsSuccesfulState(post: posts));
      } else {
        emit(AllFollowersPostsServerErrorState());
      }
    } catch (error) {
      log('Error fetching posts: $error');
      emit(AllFollowersPostsServerErrorState());
    }
  }

  FutureOr<void> loadMoreEvent(
      LoadMoreEvent event, Emitter<AllFollowersPostsState> emit) async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    emit(AllFollowersPostsLoadingState());

    try {
      page += 1;

      final http.Response result = await PostRepo.getFollowersPost(page: page);

      final List<dynamic> responseBody = jsonDecode(result.body);

      if (result.statusCode == 200) {
        List<FollowersPostModel> newPosts = responseBody
            .map((json) => FollowersPostModel.fromJson(json))
            .toList();
        emit(AllFollowersPostsSuccesfulState(post: newPosts));
      } else {
        emit(AllFollowersPostsServerErrorState());
      }
    } catch (error) {
      log('Error loading more posts: $error');
      emit(AllFollowersPostsServerErrorState());
    }

    isLoadingMore = false;
  }

  // Mock method to fetch followers' posts
}
