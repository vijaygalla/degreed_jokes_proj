import 'package:dad_jokes/blocs_models/event/joke_event.dart';
import 'package:dad_jokes/blocs_models/joke_bloc.dart';
import 'package:dad_jokes/blocs_models/state/joke_state.dart';
import 'package:dad_jokes/constants/debouncer.dart';
import 'package:dad_jokes/models/joke_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JokesList extends StatefulWidget {
  const JokesList({super.key});

  @override
  State<JokesList> createState() => _JokesListState();
}

class _JokesListState extends State<JokesList> {
  @override
  Widget build(BuildContext context) {
    context.read<JokeBloc>().add(SearchQueryEvent(""));
    final debouncer = Debouncer(seconds: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text("I can haz dad joke"),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SearchBar(
              hintText: "Search",
              onChanged: (value) {
                debouncer.run(() {
                  context.read<JokeBloc>().add(SearchQueryEvent(value));
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<JokeBloc, JokeState>(builder: (context, state) {
              if (state is JokesErrorState) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              if (state is JokesLoadedState) {
                return loadedJokesWidget(state.jokes);
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.brown.shade800,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget loadedJokesWidget(List<Result> results) {
    if (results.isEmpty) {
      return const Center(
        child: Text(
          "No Search results",
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.brown.shade50,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(results[index].joke.toString()),
              ),
            );
          });
    }
  }
}