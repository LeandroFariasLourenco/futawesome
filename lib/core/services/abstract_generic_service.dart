import 'package:futawesome/core/clients/api_futebol.dart';
import 'package:localstore/localstore.dart';

abstract class GenericeService {
  final APIFutebol client = APIFutebol();
  final db = Localstore.instance;
  final String url = '';
  final int championshipId = 0;
}
