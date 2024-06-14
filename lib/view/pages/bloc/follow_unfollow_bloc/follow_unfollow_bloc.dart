import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'follow_unfollow_event.dart';
part 'follow_unfollow_state.dart';

class FollowUnfollowBloc extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  FollowUnfollowBloc() : super(FollowUnfollowInitial()) {
    on<OnFollowButtonClickedEvent>(_followUserButtonClickEvent);
    on<OnUnFollowButtonClickedEvent>(_unfollowUserButtonClickEvent);
  }

  // Event handler for follow button click
  Future<void> _followUserButtonClickEvent(OnFollowButtonClickedEvent event,
      Emitter<FollowUnfollowState> emit) async {
    emit(FollowUserLoadingState());
    try {
      final Response result = await UserRepo.followUser(followeesId: event.followeesId);
      debugPrint('Follow status code: ${result.statusCode}');
      
      if (result.statusCode == 200) {
        emit(FollowUserSuccesfulState());
      } else {
        emit(FollowUserErrorState());
      }
    } catch (e) {
      debugPrint('Follow request failed with error: $e');
      emit(FollowUserErrorState());
    }
  }

  // Event handler for unfollow button click
  Future<void> _unfollowUserButtonClickEvent(OnUnFollowButtonClickedEvent event,
      Emitter<FollowUnfollowState> emit) async {
    emit(UnFollowUserLoadingState());
    try {
      final Response result = await UserRepo.unfollowUser(followeesId: event.followeesId);
      debugPrint('Unfollow status code: ${result.statusCode}');
      
      if (result.statusCode == 200) {
        emit(UnFollowUserSuccesfulState());
      } else {
        emit(FollowUserErrorState());
      }
    } catch (e) {
      debugPrint('Unfollow request failed with error: $e');
      emit(FollowUserErrorState());
    }
  }
}
