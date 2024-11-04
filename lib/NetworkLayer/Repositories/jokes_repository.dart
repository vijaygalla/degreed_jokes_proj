import 'package:dad_jokes/Constants/network_constants.dart';
import 'package:dad_jokes/NetworkLayer/network_api.dart';
import 'package:dad_jokes/models/joke_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class JokesRepository {
  late NetworkApi _networkApi;
  JokesRepository() {
    _networkApi = NetworkApi();
  }

  // api to fetch random joke for the first time and when search is empty
  Future<List<Result>> getRandomJoke() async {
    try {
      Response response = await _networkApi.getData(randomJokeApi);
      Map<String, dynamic> data = jsonDecode(response.body);
      return [Result.fromJson(data)];
    } catch (exception) {
      rethrow;
    }
  }

// api to fetch jokes based on the search query
  Future<List<Result>> getSearchJokes(String query) async {
    try {
      Response response = await _networkApi.getData("$searchJokeApi$query");
      Map<String, dynamic> data = jsonDecode(response.body);
      final searchData = JokeSearchModel.fromJson(data);
      return searchData.results ?? [];
    } catch (exception) {
      rethrow;
    }
  }
}
