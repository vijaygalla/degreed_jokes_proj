import 'package:dad_jokes/Blocs/joke_bloc.dart';
import 'package:dad_jokes/Pages/jokes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // using bloc provider for Jokes List component
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => JokeBloc(),
      child: const JokesList(),
    ),
  ));
}
