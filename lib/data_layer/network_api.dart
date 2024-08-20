import 'package:http/http.dart';

const Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

class NetworkApi {
  Future<Response> getData(String endPoint) async {
    try {
      final uri = Uri.parse(endPoint);
      Response response = await get(uri, headers: header);
      return response;
    } catch (exception) {
      rethrow;
    }
  }
}
