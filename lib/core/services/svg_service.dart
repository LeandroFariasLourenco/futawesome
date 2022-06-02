import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';

class SvgService {
  final _db = Localstore.instance;

  Future<dynamic> getSvg(String url) async {
    final storedSvg = await _db.collection('svgs').doc(url).get();

    if (storedSvg == null) {
      final response = await http.get(Uri.parse(url));
      await _db.collection('svgs').doc(url).set({"svg": response.body});
      return response.body;
    }

    return storedSvg["svg"];
  }
}
