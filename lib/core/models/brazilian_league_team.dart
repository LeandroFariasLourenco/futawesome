class BrazilianLeagueTeam {
  final int posicao;
  final int pontos;
  final Map<String, dynamic> time;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsPro;
  final int golsContra;
  final int saldoGols;
  final dynamic aproveitamento;
  final int variacaoPosicao;
  final List<dynamic> ultimosJogos;

  const BrazilianLeagueTeam({
    required this.posicao,
    required this.pontos,
    required this.time,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsPro,
    required this.golsContra,
    required this.saldoGols,
    required this.aproveitamento,
    required this.variacaoPosicao,
    required this.ultimosJogos,
  });

  factory BrazilianLeagueTeam.fromJson(Map<String, dynamic> json) {
    return BrazilianLeagueTeam(
      posicao: json["posicao"],
      pontos: json["pontos"],
      time: json["time"],
      jogos: json["jogos"],
      vitorias: json["vitorias"],
      empates: json["empates"],
      derrotas: json["derrotas"],
      golsPro: json["gols_pro"],
      golsContra: json["gols_contra"],
      saldoGols: json["saldo_gols"],
      aproveitamento: json["aproveitamento"],
      variacaoPosicao: json["variacao_posicao"],
      ultimosJogos: json["ultimos_jogos"],
    );
  }
}
