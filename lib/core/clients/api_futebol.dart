import 'package:http/http.dart' as http;

class APIFutebol {
  final String url = 'https://api.api-futebol.com.br/v1';

  final String token = 'Bearer live_4da3672fafd830478d3c24eecf493b';

  Future<String> getUrl(String path) async {
    http.Response result = await http.get(Uri.parse("$url/$path"), headers: {
      "Authorization": token,
    });

    if (result.statusCode == 200) {
      return result.body;
    } else {
      throw Exception('Failed to fetch the client');
    }
  }
}
