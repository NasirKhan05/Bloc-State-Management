import 'package:block_state_examples/bloc/todo/to_do_bloc.dart';
import 'package:block_state_examples/bloc/todo/to_do_event.dart';
import 'package:block_state_examples/bloc/todo/to_do_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreens extends StatefulWidget {
  const TodoScreens({super.key});

  @override
  State<TodoScreens> createState() => _TodoScreensState();
}

class _TodoScreensState extends State<TodoScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<ToDoBloc, ToDoState>(builder: (context, state) {
        if(state.todosList.isEmpty){
          return Center(child: Text('No ToDo Found'));
        }else if(state.todosList.isNotEmpty){
          return ListView.builder(
            itemCount: state.todosList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todosList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<ToDoBloc>().add(RemoveToDoEvent(task: state.todosList[index]));
                    },
                  ),
                );
              }
                );
        }else{
          return SizedBox();
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for(int i = 0; i < 10 ; i++){
            context.read<ToDoBloc>().add(AddToDoEvent(task: 'Task: '+ i.toString()));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
