import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/my_post_model/user_id.dart';
import 'package:buzz_buddy/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// ignore: unnecessary_import
import 'package:meta/meta.dart';

part 'explore_page_search_users_event.dart';
part 'explore_page_search_users_state.dart';

class ExplorePageSearchUsersBloc
    extends Bloc<ExplorePageSearchUsersEvent, ExplorePageSearchUsersState> {
  ExplorePageSearchUsersBloc() : super(ExplorePageSearchUsersInitial()) {
    on<OnSearchAllUsersEvent>((event, emit) async {
      emit(ExplorePageSearchUsersLoadingState());
      final Response response =
          await UserRepo.searchAllUsers(query: event.query);
      if (response.statusCode == 200) {
        debugPrint('searchallusers statuscode-${response.statusCode}');
        List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<UserId> users =
            jsonResponse.map((user) => UserId.fromJson(user)).toList();
        emit(ExplorePageSearchUserSuccesState(users: users));
      } else {
        emit(ExplorePageSearchUsersErrorState());
      }
    });
  }
}
