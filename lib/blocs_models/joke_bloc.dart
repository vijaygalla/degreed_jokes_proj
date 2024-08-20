// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'package:dad_jokes/blocs_models/event/joke_event.dart';
import 'package:dad_jokes/blocs_models/state/joke_state.dart';
import 'package:dad_jokes/data_layer/repositories/jokes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc() : super(JokesLoadingState()) {
    fetchJokes();
  }

  void fetchJokes() {
    on<SearchQueryEvent>(
      (event, emit) async {
        if (event.searchQuery.isEmpty) {
          fetchRandomJoke();
        } else {
          fetchSearchJokes(event.searchQuery);
        }
      },
    );
  }

  void fetchRandomJoke() async {
    final JokesRepository repository = JokesRepository();
    emit(JokesLoadingState());
    try {
      final jokes = await repository.getRandomJoke();
      emit(JokesLoadedState(jokes));
    } on IOException catch (exception) {
      emit(JokesErrorState(exception.toString()));
    }
  }

  void fetchSearchJokes(String query) async {
    final JokesRepository repository = JokesRepository();
    emit(JokesLoadingState());
    try {
      final jokes = await repository.getSearchJokes(query);
      emit(JokesLoadedState(jokes));
    } on IOException catch (exception) {
      emit(JokesErrorState(exception.toString()));
    }
  }
}
