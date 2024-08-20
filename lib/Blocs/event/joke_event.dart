abstract class JokeEvent {}

// check for the query if founds it will trigger the event to fetch search results
class SearchQueryEvent extends JokeEvent {
  final String searchQuery;
  SearchQueryEvent(this.searchQuery);
}
