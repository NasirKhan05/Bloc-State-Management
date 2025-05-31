


import 'package:bloc/bloc.dart';
import 'package:block_state_examples/bloc/posts/posts_event.dart';
import 'package:block_state_examples/bloc/posts/posts_state.dart';
import 'package:block_state_examples/repository/post_repository.dart';
import 'package:block_state_examples/utils/enums.dart';

import '../../model/posts_model.dart';

class PostBloc extends Bloc<PostsEvent, PostsState>{

  List<PostModel> temPostList = [] ;

  PostRepository postRepository = PostRepository();
  PostBloc() : super (const PostsState()){
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(_filterList);
  }

  void _filterList(SearchItem event, Emitter<PostsState> emit) async{
    if(event.stSearch.isEmpty){
      emit(state.copyWith(temPostList: [] , searchMessage: ''));
    }else{
      // temPostList = state.postList.where((element) => element.id.toString() == event.stSearch.toString()).toList();
      temPostList = state.postList.where((element) => element.email.toString().toLowerCase().contains(event.stSearch.toLowerCase())).toList();
      if(temPostList.isEmpty){
        emit(state.copyWith(temPostList: temPostList, searchMessage: 'No Data Found'));
      }else{
        emit(state.copyWith(temPostList: temPostList));
      }
    }
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