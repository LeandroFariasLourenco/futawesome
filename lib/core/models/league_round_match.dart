import 'package:futawesome/core/models/match.dart';

class LeagueRoundMatch {
  final String name; //nome;
  final String slug;
  final int round; //rodada;
  final String status;
  final String link; //_link
  final List<Match> matches; //partidas

  LeagueRoundMatch({
    required this.name,
    required this.slug,
    required this.round,
    required this.status,
    required this.link,
    required this.matches,
  });

  factory LeagueRoundMatch.fromJson(Map<String, dynamic> json) {
    return LeagueRoundMatch(
      name: json['nome'],
      slug: json['slug'],
      round: json['rodada'],
      status: json['status'],
      link: json['_link'],
      matches: (json['partidas'] as List)
          .map((e) => Match.fromJson(e))
          .toList()
          .cast<Match>(),
    );
  }
}
