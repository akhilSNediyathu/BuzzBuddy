import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/following_model.dart';
import 'package:buzz_buddy/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// ignore: unnecessary_import
import 'package:meta/meta.dart';

part 'fetch_following_event.dart';
part 'fetch_following_state.dart';

class FetchFollowingBloc
    extends Bloc<FetchFollowingEvent, FetchFollowingState> {
  FetchFollowingBloc() : super(FetchFollowingInitial()) {
    on<OnFetchFollowingUsersEvent>((event, emit) async {
      emit(FetchFollowingLoadingState());
      final Response result = await UserRepo.fetchFollowing();
     // print(result.body);
      // final responseBody = jsonEncode(result.body);
      // log(responseBody.toString());
      debugPrint('followers fetch status code-${result.statusCode}');
      if (result.statusCode == 200) {
            final Map<String, dynamic> responseBody = jsonDecode(result.body);
           final FollowingsModel followingsModel =
              FollowingsModel.fromJson(responseBody);
         return emit(FetchFollowingSuccesState(model: followingsModel));
      } else {
      //  print("error");
        return emit(FetchFollowingErrorState());
      }
    });
  }
}
