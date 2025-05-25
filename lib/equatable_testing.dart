import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class EquatableTesting extends StatefulWidget {
  const EquatableTesting({super.key});

  @override
  State<EquatableTesting> createState() => _EquatableTestingState();
}

class _EquatableTestingState extends State<EquatableTesting> {
  Person? person;
  Person? person1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare to Text'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (person != null && person1 != null)
            Center(
              child: Text(
                person == person1
                    ? "Both persons are equal"
                    : "Persons are not equal",
                style: const TextStyle(fontSize: 18),
              ),
            )
          else
            Center(child: const Text("Press the button to compare persons")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){

            person = Person(name: 'Nasir Khan', age: 23);
            person1 = Person(name: 'Nasir Khan', age: 24);

            print(person.hashCode.toString());
            print(person1.hashCode.toString());

            print(person == person1);

            setState(() {

            });
          },
          child: Icon(Icons.compare),
      ),
    );
  }
}

class Person extends Equatable {
  final String name ;
  final int age ;

  const Person({required this.name, required this.age});

  @override
  List<Object> get props => [name, age];
}