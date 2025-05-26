


import 'package:bloc/bloc.dart';
import 'package:block_state_examples/bloc/posts/posts_event.dart';
import 'package:block_state_examples/bloc/posts/posts_state.dart';
import 'package:block_state_examples/repository/post_repository.dart';
import 'package:block_state_examples/utils/enums.dart';

class PostBloc extends Bloc<PostsEvent, PostsState>{
  PostRepository postRepository = PostRepository();
  PostBloc() : super (const PostsState()){
    on<PostFetched>(fetchPostApi);
  }
  void fetchPostApi(PostFetched event, Emitter<PostsState> emit) async{
    await postRepository.fetchPost().then((value){
      emit(state.copyWith(
        postStatus: PostStatus.success,
        message: 'message',
        postList: value
      ));
    }).onError((error, stackTrace){
      emit(state.copyWith(postStatus: PostStatus.failure, message: error.toString()));
    });
  }
}