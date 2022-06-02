import 'dart:convert';

import 'package:futawesome/core/clients/api_futebol.dart';
import 'package:futawesome/core/models/competition.dart';
import 'package:localstore/localstore.dart';

class CompetitionService {
  final APIFutebol client = APIFutebol();

  String url = 'campeonatos';

  final db = Localstore.instance;

  Future<List<Competition>> getCompetitions() async {
    final storedData = await db.collection('competitions').doc('all').get();
    final List<Competition> listToReturn = [];

    List<Competition> filterCompetitions(competitions) {
      return competitions.where((competition) =>
          (competition["nome_popular"] == 'Brasileirão' ||
              competition["nome_popular"] == 'Copa do Brasil' ||
              competition["nome_popular"] == 'Champions League'));
    }

    if (storedData != null) {
      final Iterable<dynamic> storedList =
          filterCompetitions(jsonDecode(storedData['competitions']));
      for (final competition in storedList) {
        listToReturn.add(Competition.fromJson(competition));
      }
      return listToReturn;
    }

    final competitions = await client.getUrl(url);
    await db.collection('competitions').doc('all').set({
      "competitions": competitions,
    });
    filterCompetitions(jsonDecode(competitions))
        .map((competition) => Competition.fromJson(competition as dynamic))
        .toList()
        .cast<Competition>();

    return listToReturn;
  }

  Future<Competition> getCompetition(int id) async {
    dynamic storedData = await db.collection('competitions').doc('all').get();
    if (storedData == null) {
      await getCompetitions();
      storedData = await db.collection('competitions').doc('all').get();
    }

    Competition competition = Competition.fromJson(
      jsonDecode(storedData!["competitions"]).firstWhere(
        (competition) => competition["campeonato_id"] == id,
      ),
    );

    return competition;
  }
}
