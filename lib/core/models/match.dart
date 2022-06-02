class Match {
  final int matchId;
  final String score;
  final Team hostTeam;
  final Team visitorTeam;
  final int? hostScore;
  final int? visitorScore;
  final String status;
  final String slug;
  final String? realizedDate;
  final String realizedHour;
  final String realizedDateIso;
  final Stadium stadium;

  Match({
    required this.matchId,
    required this.score,
    required this.hostTeam,
    required this.visitorTeam,
    required this.hostScore,
    required this.visitorScore,
    required this.status,
    required this.slug,
    required this.realizedDate,
    required this.realizedHour,
    required this.realizedDateIso,
    required this.stadium,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      matchId: json['partida_id'],
      score: json['placar'],
      hostTeam: Team.fromJson(json['time_mandante']),
      visitorTeam: Team.fromJson(json['time_visitante']),
      hostScore: json['placar_mandante'],
      visitorScore: json['placar_visitante'],
      status: json['status'],
      slug: json['slug'],
      realizedDate: json['data_realizacao'],
      realizedHour: json['hora_realizacao'],
      realizedDateIso: json['data_realizacao_iso'],
      stadium: Stadium.fromJson(json['estadio']),
    );
  }
}

class Team {
  final int teamId;
  final String name;
  final String acronym;
  final String badge;

  Team(
      {required this.teamId,
      required this.name,
      required this.acronym,
      required this.badge});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['time_id'],
      name: json['nome_popular'],
      acronym: json['sigla'],
      badge: json['escudo'],
    );
  }
}

class Stadium {
  final int stadiumId;
  final String name;

  Stadium({required this.stadiumId, required this.name});

  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      stadiumId: json['estadio_id'],
      name: json['nome_popular'],
    );
  }
}
