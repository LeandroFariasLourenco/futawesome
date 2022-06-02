class Competition {
  int campeonatoId;
  CurrentEdition edicaoAtual;
  CurrentPhase? faseAtual;
  String logo;
  String nome;
  String nomePopular;
  CurrentRound? rodadaAtual;
  String slug;
  String status;
  String tipo;
  String link;

  Competition({
    required this.campeonatoId,
    required this.edicaoAtual,
    this.faseAtual,
    required this.logo,
    required this.nome,
    required this.nomePopular,
    this.rodadaAtual,
    required this.slug,
    required this.status,
    required this.tipo,
    required this.link,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      campeonatoId: json["campeonato_id"],
      edicaoAtual: CurrentEdition.fromJson(json["edicao_atual"]),
      faseAtual: json["fase_atual"] != null
          ? CurrentPhase.fromJson(json["fase_atual"])
          : null,
      logo: json["logo"],
      nome: json["nome"],
      nomePopular: json["nome_popular"],
      rodadaAtual: json["rodada_atual"] != null
          ? CurrentRound.fromJson(json["rodada_atual"])
          : null,
      slug: json["slug"],
      status: json["status"],
      tipo: json["tipo"],
      link: json["_link"],
    );
  }
}

class CurrentEdition {
  int edicaoId;
  String nome;
  String nomePopular;
  String slug;
  String temporada;

  CurrentEdition({
    required this.edicaoId,
    required this.nome,
    required this.nomePopular,
    required this.slug,
    required this.temporada,
  });

  factory CurrentEdition.fromJson(Map<String, dynamic> json) {
    return CurrentEdition(
      edicaoId: json["edicao_id"],
      nome: json["nome"],
      nomePopular: json["nome_popular"],
      slug: json["slug"],
      temporada: json["temporada"],
    );
  }
}

class CurrentPhase {
  final int faseId;
  final String nome;
  final String slug;
  final String tipo;
  final String link;

  const CurrentPhase({
    required this.faseId,
    required this.nome,
    required this.slug,
    required this.tipo,
    required this.link,
  });

  factory CurrentPhase.fromJson(Map<String, dynamic> json) {
    return CurrentPhase(
      faseId: json["fase_id"],
      nome: json["nome"],
      slug: json["slug"],
      tipo: json["tipo"],
      link: json["_link"],
    );
  }
}

class CurrentRound {
  final String nome;
  final String slug;
  final int rodada;
  final String status;

  const CurrentRound({
    required this.nome,
    required this.slug,
    required this.rodada,
    required this.status,
  });

  factory CurrentRound.fromJson(Map<String, dynamic> json) {
    return CurrentRound(
      nome: json["nome"],
      slug: json["slug"],
      rodada: json["rodada"],
      status: json["status"],
    );
  }
}
