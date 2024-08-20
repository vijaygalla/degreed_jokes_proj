import 'package:dad_jokes/blocs_models/joke_bloc.dart';
import 'package:dad_jokes/pages/jokes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context) => JokeBloc(),
      child: JokesList(),
    ),
  ));
}
