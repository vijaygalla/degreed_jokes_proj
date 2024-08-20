abstract class JokeEvent {}

class SearchQueryEvent extends JokeEvent {
  final String searchQuery;
  SearchQueryEvent(this.searchQuery);
}
