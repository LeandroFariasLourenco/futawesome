class LeagueRound {
  final String name;
  final String slug;
  final int round;
  final String status;
  final String link;

  LeagueRound({
    required this.link,
    required this.name,
    required this.slug,
    required this.round,
    required this.status,
  });

  factory LeagueRound.fromJson(Map<String, dynamic> json) {
    return LeagueRound(
      link: json['_link'],
      name: json['nome'],
      slug: json['slug'],
      round: json['rodada'],
      status: json['status'],
    );
  }
}
