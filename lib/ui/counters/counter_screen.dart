import 'package:block_state_examples/bloc/counter/counter_bloc.dart';
import 'package:block_state_examples/bloc/counter/counter_event.dart';
import 'package:block_state_examples/bloc/counter/counter_state.dart';
import 'package:block_state_examples/ui/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }
  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _counterBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Counter Example'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
                    },
                    child: Text('Next')
                ),
                SizedBox(height: 30,),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    return Center(
                      child: Text(
                        state.counter.toString(),
                        style: TextStyle(fontSize: 60),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<CounterBloc, CounterState>(
                        buildWhen: (current, previous) => false,
                      builder: (context, state){
                          return ElevatedButton(
                            onPressed: () {
                              context.read<CounterBloc>().add(IncrementCounter());
                            },
                            child: Text('Add'),
                          );
                      },
                    ),
                    SizedBox(width: 20),
                    BlocBuilder<CounterBloc, CounterState>(
                      buildWhen: (current, previous) => false,
                      builder: (context, state){
                        return ElevatedButton(
                          onPressed: () {
                            context.read<CounterBloc>().add(DecrementCounter());
                          },
                          child: Text('Removed'),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
