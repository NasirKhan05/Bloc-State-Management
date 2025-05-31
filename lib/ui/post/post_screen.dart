import 'package:block_state_examples/bloc/counter/counter_bloc.dart';
import 'package:block_state_examples/bloc/counter/counter_state.dart';
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
        actions: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Center(
                child: Text(
                  state.counter.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 60),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostsState>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return Center(child: CircularProgressIndicator());
            case PostStatus.failure:
              return Center(child: Text(state.message.toString()));
            case PostStatus.success:
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3, right: 10, left: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (filterKey) {
                        context.read<PostBloc>().add(SearchItem(filterKey));
                      },
                    ),
                  ),
                  Expanded(
                    child:
                        state.searchMessage.isNotEmpty
                            ? Center(
                              child: Text(state.searchMessage.toString()),
                            )
                            : ListView.builder(
                              itemCount:
                                  state.temPostList.isEmpty
                                      ? state.postList.length
                                      : state.temPostList.length,
                              itemBuilder: (context, index) {
                                if (state.temPostList.isNotEmpty) {
                                  final item = state.temPostList[index];
                                  return Card(
                                    child: ListTile(
                                      leading: Text(item.postId.toString()),
                                      title: Text(item.email.toString()),
                                      subtitle: Text(item.body.toString()),
                                      trailing: Text(item.id.toString()),
                                    ),
                                  );
                                } else {
                                  final item = state.postList[index];
                                  return Card(
                                    child: ListTile(
                                      leading: Text(item.postId.toString()),
                                      title: Text(item.email.toString()),
                                      subtitle: Text(item.body.toString()),
                                      trailing: Text(item.id.toString()),
                                    ),
                                  );
                                }
                              },
                            ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
