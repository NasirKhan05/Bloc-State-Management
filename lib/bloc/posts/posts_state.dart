import 'dart:io';

import 'package:block_state_examples/model/posts_model.dart';
import 'package:block_state_examples/utils/enums.dart';
import 'package:equatable/equatable.dart';

class PostsState extends Equatable{

  final PostStatus postStatus ;
  final List<PostModel> postList ;
  final String message;

  const PostsState({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostModel>[],
    this.message = '',
  });

  PostsState copyWith({PostStatus? postStatus, List<PostModel>? postList, String? message}){
    return PostsState(
      postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [postStatus, postList, message];

}