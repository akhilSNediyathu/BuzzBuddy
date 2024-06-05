import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/model/my_post_model/my_post_model.dart';
import 'package:buzz_buddy/repository/post_repo.dart';
import 'package:buzz_buddy/repository/user_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_my_post_event.dart';
part 'fetch_my_post_state.dart';

class FetchMyPostBloc extends Bloc<FetchMyPostEvent, FetchMyPostState> {
  FetchMyPostBloc() : super(FetchMyPostInitial()) {
    on<FetchAllMyPostsEvent>((event, emit) async {
      emit(FetchMyPostLoadingState());
      final response = await UserRepo.fetchUserPosts();
      if (response != null && response.statusCode == 200) {
         final responseBody = response.body;
        final List<MyPostModel> posts = parsePostsFromJson(responseBody);
        

        
          
        return emit(FetchMyPostSuccesState(posts: posts));
      } else if (response != null) {
        final responseBody = jsonDecode(response.body);
        

        return emit(FetchMyPostErrorState(error: responseBody["message"]));
      } else {
        return emit(FetchMyPostErrorState(error: "something went wrong"));
      }
    });
    on<OnMyPostDeleteButtonPressedEvent>((event, emit) async{
      emit(OnDeleteButtonClickedLoadingState());
      var response = await PostRepo.deletePost(event.postId);
      if(response!=null&&response.statusCode==200){
        return emit(OnDeleteButtonClickedSuccesState());
      }else if(response!=null){
        final responseBody= jsonDecode(response.body);
        return emit(OnDeleteButtonClickedErrrorState(error: responseBody['message']));
        
      }else{
        return emit(OnDeleteButtonClickedErrrorState(error: 'Something went wrong'));

      }

      
    },);
  }
  List<MyPostModel> parsePostsFromJson(String jsonString) {
  final List parsedData = jsonDecode(jsonString) as List;
  final List<MyPostModel> posts = [];

  for (var item in parsedData) {
    posts.add(MyPostModel.fromJson(item));
  }

  return posts;
}
}
