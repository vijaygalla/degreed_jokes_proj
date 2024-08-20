import 'package:dad_jokes/models/joke_model.dart';

abstract class JokeState {}

class JokesLoadingState extends JokeState {}

class JokesLoadedState extends JokeState {
  List<Result> jokes;
  JokesLoadedState(this.jokes);
}

class JokesErrorState extends JokeState {
  String error;
  JokesErrorState(this.error);
}
