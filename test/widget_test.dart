import 'package:dad_jokes/Constants/network_constants.dart';
import 'package:dad_jokes/models/joke_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'widget_test.mocks.dart';
import 'package:dad_jokes/NetworkLayer/Repositories/jokes_repository.dart';

/*calling live api calls will slow down the test execution
hence we are mocking the real api data instead calling the live api call
as it may fail the test and it is difficult handle the success and failure 
scenarios in all cases
*/
@GenerateMocks([http.Client])
void main() {
  // Group Test case for random joke api for both success and failure cases.
  group("Testing for joke search results for a given search query", () {
    test("Fetched random joke", () async {
      final client = MockClient();
      when(client.get(Uri.parse(randomJokeApi))).thenAnswer((_) async =>
          http.Response(
              '{"id": "R7UfaahVfFd", "joke": "My dog used to chase people on a bike a lot. It got so bad I had to take his bike away.", "status": 200,}',
              200));
      expect(await JokesRepository().getRandomJoke(), isA<List<Result>>());
    });

    test("Fetched random joke failed and return exception", () async {
      final client = MockClient();
      when(client.get(Uri.parse(randomJokeApi)))
          .thenAnswer((_) async => http.Response('Not results found', 200));
      expect(await JokesRepository().getRandomJoke(), throwsException);
    });
  });

  // Group Test case for search jokes api for both success and failure cases.
  group("Testing for joke search results for a given search query", () {
    test("Fetched search jokes", () async {
      final client = MockClient();
      when(client.get(Uri.parse(randomJokeApi))).thenAnswer((_) async =>
          http.Response(
              '{"current_page": 1,"limit": 20,"next_page": 1,"previous_page": 1,"results": [{"id": "GlGBIY0wAAd","joke": "How much does a hipster weigh? An instagram."},{"id": "xc21Lmbxcib","joke": "How did the hipster burn the roof of his mouth? He ate the pizza before it was cool."}],"search_term": "hipster","status": 200,"total_jokes": 2,"total_pages": 1}',
              200));
      expect(await JokesRepository().getSearchJokes("hipster"),
          isA<List<Result>>());
    });

    test("Fetched search jokes failed and return exception", () async {
      final client = MockClient();
      when(client.get(Uri.parse(randomJokeApi)))
          .thenAnswer((_) async => http.Response('Not results found', 200));
      expect(
          await JokesRepository().getSearchJokes("hipster"), throwsException);
    });
  });
}
