// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'package:dad_jokes/blocs_models/event/joke_event.dart';
import 'package:dad_jokes/blocs_models/state/joke_state.dart';
import 'package:dad_jokes/data_layer/repositories/jokes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc main business logic will be handled in this class
class JokeBloc extends Bloc<JokeEvent, JokeState> {
  // initial state is data loading state
  JokeBloc() : super(JokesLoadingState()) {
    fetchJokes();
  }

  void fetchJokes() {
    // loading data for the first time with random joke
    // if searchQueryEvent finds a query so it will fetch searched results
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

  // loading data for the first time with random joke
  void fetchRandomJoke() async {
    final JokesRepository repository = JokesRepository();
    try {
      emit(JokesLoadingState());
      final jokes = await repository.getRandomJoke();
      emit(JokesLoadedState(jokes));
    } on IOException catch (exception) {
      emit(JokesErrorState(exception.toString()));
    }
  }

  // if searchQueryEvent finds a query so it will fetch searched results
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
