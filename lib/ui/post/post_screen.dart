
import 'package:block_state_examples/bloc/posts/posts_bloc.dart';
import 'package:block_state_examples/bloc/posts/posts_event.dart';
import 'package:block_state_examples/bloc/posts/posts_state.dart';
import 'package:block_state_examples/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Api With BlocState'),
        centerTitle: true,
         backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<PostBloc, PostsState>(
          builder: (context, state){
            switch(state.postStatus){
              case PostStatus.loading:
                return Center(child: CircularProgressIndicator());
              case PostStatus.failure:
                return Center(child: Text(state.message.toString()));
              case PostStatus.success:
                return ListView.builder(
                  itemCount: state.postList.length,
                    itemBuilder: (context, index){
                    final item = state.postList[index];
                    return ListTile(
                      leading: Text(item.postId.toString()),
                      title: Text(item.email.toString()),
                      subtitle: Text(item.body.toString()),
                      trailing: Text(item.id.toString()),
                    );
                    }
                );
            }
          }
      ),
    );
  }
}
