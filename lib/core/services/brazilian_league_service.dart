import 'dart:convert';
import 'dart:developer';

import 'package:futawesome/core/clients/api_futebol.dart';
import 'package:futawesome/core/models/brazilian_league_team.dart';
import 'package:futawesome/core/models/league_round.dart';
import 'package:futawesome/core/models/league_round_match.dart';
import 'package:futawesome/core/models/match.dart';
import 'package:futawesome/core/models/top_scorer.dart';
import 'package:localstore/localstore.dart';

class BrazilianLeagueService {
  final APIFutebol _client = APIFutebol();

  final _db = Localstore.instance;

  final String _url = 'campeonatos';

  final int _championshipId = 10;

  final String _collection = 'brazilian_league';

  Future<List<BrazilianLeagueTeam>> getLeagueTable() async {
    final storedData = await _db.collection(_collection).doc('table').get();

    if (storedData != null) {
      return (jsonDecode(storedData['teams']))
          .map((team) => BrazilianLeagueTeam.fromJson(team))
          .toList()
          .cast<BrazilianLeagueTeam>();
    }

    final teams = await _client.getUrl('$_url/$_championshipId/tabela');

    await _db.collection(_collection).doc('table').set({"teams": teams});
    return jsonDecode(teams)
        .map((team) => BrazilianLeagueTeam.fromJson(team))
        .toList()
        .cast<BrazilianLeagueTeam>();
  }

  Future<List<TopScorer>> getTopScorers() async {
    final storedData = await _db.collection(_collection).doc('scorers').get();

    if (storedData != null) {
      return (jsonDecode(storedData["scorers"]))
          .map((scorer) => TopScorer.fromJson(scorer))
          .toList()
          .cast<TopScorer>();
    }

    final scorer = await _client.getUrl('$_url/$_championshipId/artilharia');
    await _db.collection(_collection).doc('scorers').set({"scorers": scorer});
    return jsonDecode(scorer)
        .map((scorer) => TopScorer.fromJson(scorer))
        .toList()
        .cast<TopScorer>();
  }

  Future<List<LeagueRound>> getRounds() async {
    final storedData = await _db.collection(_collection).doc('rounds').get();

    if (storedData != null) {
      return jsonDecode(storedData['rounds'])
          .map((round) => LeagueRound.fromJson(round))
          .toList()
          .cast<LeagueRound>();
    }

    final rounds = await _client.getUrl('$_url/$_championshipId/rodadas');
    await _db.collection(_collection).doc('rounds').set({"rounds": rounds});
    return jsonDecode(rounds)
        .map((round) => LeagueRound.fromJson(round))
        .toList()
        .cast<LeagueRound>();
  }

  Future<LeagueRoundMatch> getRoundMatches(int roundId) async {
    final storedData =
        await _db.collection(_collection).doc("rounds-$roundId").get();

    if (storedData != null) {
      return LeagueRoundMatch.fromJson(jsonDecode(storedData['matches']));
    }

    final matches =
        await _client.getUrl('$_url/$_championshipId/rodadas/$roundId');
    await _db
        .collection(_collection)
        .doc("rounds-$roundId")
        .set({"matches": matches});

    return LeagueRoundMatch.fromJson(jsonDecode(matches));
  }
}
