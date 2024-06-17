import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/explore_posts_model.dart';
import 'package:buzz_buddy/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'fetch_explore_event.dart';
part 'fetch_explore_state.dart';

class FetchExploreBloc extends Bloc<FetchExploreEvent, FetchExploreState> {
  FetchExploreBloc() : super(FetchExploreInitial()) {
    on<OnFetchExplorePostsEvent>((event, emit) async {
      emit(FetchExplorePostsLoadingState());

      final Response response = await PostRepo.fetchExplorePosts();
      debugPrint('status code  fetch explore : ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        log(responseBody.toString());

        // Parse the JSON response into a list of ExplorePostModel objects
        List<ExplorePostModel> posts = responseBody
            .map((json) => ExplorePostModel.fromJson(json))
            .toList();
        print(posts);
        return emit(FetchExplorePostsSuccesState(posts: posts));
      } else {
        return emit(FetchExplorePostsErrorState());
      }
    });
  }
}
