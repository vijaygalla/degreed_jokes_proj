import 'package:dad_jokes/Blocs/event/joke_event.dart';
import 'package:dad_jokes/Blocs/joke_bloc.dart';
import 'package:dad_jokes/Blocs/state/joke_state.dart';
import 'package:dad_jokes/Commons/progress_widget.dart';
import 'package:dad_jokes/Constants/debouncer.dart';
import 'package:dad_jokes/Constants/network_constants.dart';
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
        title: const Text(
          "I can haz dad joke",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              elevation: const WidgetStatePropertyAll(2),
              onChanged: (value) {
                debouncer.run(() {
                  context.read<JokeBloc>().add(SearchQueryEvent(value));
                });
              },
            ),
          ),
          Expanded(
            // BlocProvider will receive the events and state management
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
              return const ProgressWidget();
            }),
          ),
        ],
      ),
    );
  }

// widget for after loaded the data from jokes API
  Widget loadedJokesWidget(List<Result> results) {
    if (results.isEmpty) {
      // If no search results found show a static message
      return Center(
        child: Text(
          noResults,
          style: TextStyle(
            color: Colors.brown.shade800,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      // once results found populate the jokes data from API into the listview using listview builder.
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
