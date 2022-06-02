import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/components/match_card.dart';
import 'package:futawesome/core/components/typography/subtitle.dart';
import 'package:futawesome/core/models/league_round.dart';
import 'package:futawesome/core/models/league_round_match.dart';
import 'package:futawesome/core/models/match.dart';
import 'package:futawesome/core/services/brazilian_league_service.dart';

class Rounds extends StatefulWidget {
  const Rounds({Key? key}) : super(key: key);

  @override
  State<Rounds> createState() => _RoundsState();
}

class _RoundsState extends State<Rounds> with AutomaticKeepAliveClientMixin {
  Map<int, Future<LeagueRoundMatch?>> roundMatches = {};
  Future<List<LeagueRound>> rounds = BrazilianLeagueService().getRounds();

  void _loadRoundMatches(int roundId) {
    setState(() {
      roundMatches[roundId] = BrazilianLeagueService().getRoundMatches(roundId);
    });
  }

  Widget _renderListItem(Match match) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: MatchCard(match: match),
      ),
    );
  }

  void _setupRoundMatches() {
    rounds.then((allRounds) {
      allRounds.forEach((round) {
        roundMatches[round.round] = Future(() => null);
      });
      // The first round
      _loadRoundMatches(1);
    });
  }

  @override
  void initState() {
    super.initState();

    _setupRoundMatches();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: rounds,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const CupertinoActivityIndicator();
        }

        List<LeagueRound> rounds = snapshot.data! as List<LeagueRound>;
        return CarouselSlider(
          items: rounds.map((round) {
            return Card(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Subtitle(
                      text: round.name,
                    ),
                    const Divider(),
                    Expanded(
                      child: (() {
                        return FutureBuilder(
                          future: roundMatches[round.round],
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const CupertinoActivityIndicator();
                            }

                            final LeagueRoundMatch currentRound =
                                snapshot.data! as LeagueRoundMatch;

                            return ListView.builder(
                              itemCount: currentRound.matches.length,
                              itemBuilder: (context, index) => _renderListItem(
                                currentRound.matches[index],
                              ),
                            );
                          },
                        );
                      })(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            enlargeCenterPage: true,
            height: 500,
            viewportFraction: 0.88,
            onPageChanged: (index, teste) {
              _loadRoundMatches(rounds[index].round);
            },
          ),
        );
      },
    );
  }
}
