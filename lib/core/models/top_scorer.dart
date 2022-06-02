class TopScorer {
  final Athlete athlete;
  final Team team;
  final int goals;

  TopScorer({
    required this.athlete,
    required this.team,
    required this.goals,
  });

  factory TopScorer.fromJson(Map<String, dynamic> json) {
    return TopScorer(
      athlete: Athlete.fromJson(json["atleta"]),
      team: Team.fromJson(json["time"]),
      goals: json["gols"],
    );
  }
}

class Athlete {
  final int athleteId;
  final String name;
  final Position? position;

  Athlete({
    required this.athleteId,
    required this.name,
    this.position,
  });

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      athleteId: json["atleta_id"],
      name: json["nome_popular"],
      position: json["posicao"] is Map<String, dynamic>
          ? Position.fromJson(json["posicao"])
          : null,
    );
  }
}

class Position {
  final String name;
  final String acronym;

  Position({
    required this.name,
    required this.acronym,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      name: json["nome"],
      acronym: json["sigla"],
    );
  }
}

class Team {
  final int teamId;
  final String name;
  final String acronym;
  final String badge;

  Team({
    required this.teamId,
    required this.name,
    required this.acronym,
    required this.badge,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json["time_id"],
      name: json["nome_popular"],
      acronym: json["sigla"],
      badge: json["escudo"],
    );
  }
}
