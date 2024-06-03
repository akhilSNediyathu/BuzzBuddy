import 'package:bloc/bloc.dart';
import 'package:buzz_buddy/repository/post_repo.dart';
import 'package:meta/meta.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<OnPostButtonClickedEvent>((event, emit)async {
      emit(AddPostLoadingstate());
      final response = await PostRepo.addPost(event.description, event.imagePath);
      if(response!=null&& response.statusCode==200){
        emit(AddPostSuccesState());
        print(response.body);
      }
      else if(response!=null){
        emit(AddPostErrorState(error: 'something went wrong'));
      }else {
        emit(AddPostErrorState(error: 'unknown error'));
      }

     
    });
  }
}
