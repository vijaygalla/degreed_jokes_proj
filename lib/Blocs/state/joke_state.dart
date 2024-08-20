import 'package:dad_jokes/models/joke_model.dart';

abstract class JokeState {}

class JokesLoadingState extends JokeState {}

// to handle actual data loaded state from API
class JokesLoadedState extends JokeState {
  List<Result> jokes;
  JokesLoadedState(this.jokes);
}

// to handle error state from API
class JokesErrorState extends JokeState {
  String error;
  JokesErrorState(this.error);
}
