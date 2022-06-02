import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/components/match_card.dart';
import 'package:futawesome/core/components/typography/heading.dart';
import 'package:futawesome/core/components/typography/subtitle.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/models/competition.dart';
import 'package:futawesome/core/models/league_round_match.dart';
import 'package:futawesome/core/services/brazilian_league_service.dart';
import 'package:futawesome/core/services/competition_service.dart';

class MainSection extends StatefulWidget {
  const MainSection({Key? key}) : super(key: key);

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(
          image: AssetImage("assets/images/brasileirao.jpg"),
          height: 500,
          fit: BoxFit.cover,
        ),
        FutureBuilder(
          future: CompetitionService().getCompetition(10),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const CupertinoActivityIndicator();
            }

            final competition = snapshot.data as Competition;
            return FutureBuilder(
              future: BrazilianLeagueService()
                  .getRoundMatches(competition.rodadaAtual!.rodada),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const CupertinoActivityIndicator();
                }

                final round = snapshot.data as LeagueRoundMatch;
                return Card(
                  elevation: 4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Subtitle(
                              text: "Rodada ${competition.rodadaAtual!.rodada}",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                color: Colors.grey[200],
                                child: Heading(
                                    text: "${round.matches[0].realizedDate}"),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: round.matches
                              .map(
                                (match) => SizedBox(
                                  width: 320,
                                  child: MatchCard(
                                    match: match,
                                    layout: Layout.compact,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        CupertinoButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text("Todas as rodadas"),
                                Icon(Icons.arrow_right_alt_rounded),
                              ],
                            ),
                            onPressed: () {})
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
