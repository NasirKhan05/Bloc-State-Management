import 'package:block_state_examples/bloc/counter/counter_bloc.dart';
import 'package:block_state_examples/bloc/favourites_app/favourites_app_bloc.dart';
import 'package:block_state_examples/bloc/images_picker/images_picker_bloc.dart';
import 'package:block_state_examples/bloc/posts/posts_bloc.dart';
import 'package:block_state_examples/bloc/switch_examples/switch_bloc.dart';
import 'package:block_state_examples/bloc/todo/to_do_bloc.dart';
import 'package:block_state_examples/repository/favourite_repository.dart';
import 'package:block_state_examples/ui/counters/counter_screen.dart';
import 'package:block_state_examples/equatable_testing.dart';
import 'package:block_state_examples/ui/favourite_app/favourite_app_screen.dart';
import 'package:block_state_examples/ui/image_picker/image_picker_screen.dart';
import 'package:block_state_examples/ui/post/post_screen.dart';
import 'package:block_state_examples/ui/switch_example/switch_example_screen.dart';
import 'package:block_state_examples/ui/todo/todo_screen/todo_screens.dart';
import 'package:block_state_examples/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CounterBloc()),
          BlocProvider(create: (_) => SwitchBloc()),
          BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
          BlocProvider(create: (_) => ToDoBloc()),
          BlocProvider(create: (_) => PostBloc()),
          BlocProvider(create: (_) => FavouriteBloc(FavouriteRepository())),
        ],
        child: FavouriteAppScreen(),
      ),
    );
  }
}
