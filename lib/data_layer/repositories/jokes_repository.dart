import 'package:dad_jokes/constants/network_constants.dart';
import 'package:dad_jokes/data_layer/network_api.dart';
import 'package:dad_jokes/models/joke_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class JokesRepository {
  // api to fetch random joke for the first time and when search is empty
  Future<List<Result>> getRandomJoke() async {
    final NetworkApi networkApi = NetworkApi();
    try {
      Response response = await networkApi.getData(randomJokeApi);

      Map<String, dynamic> data = jsonDecode(response.body);
      return [Result.fromJson(data)];
    } catch (exception) {
      rethrow;
    }
  }

// api to fetch jokes based on the search query
  Future<List<Result>> getSearchJokes(String query) async {
    final NetworkApi networkApi = NetworkApi();
    try {
      Response response = await networkApi.getData("$searchJokeApi$query");
      Map<String, dynamic> data = jsonDecode(response.body);
      final searchData = JokeSearchModel.fromJson(data);
      return searchData.results ?? [];
    } catch (exception) {
      rethrow;
    }
  }
}
