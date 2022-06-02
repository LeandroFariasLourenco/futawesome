import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/contants/sliding_up_panel.dart';
import 'package:futawesome/core/models/competition.dart';
import 'package:futawesome/core/services/competition_service.dart';
import 'package:futawesome/screens/competitions/brazilian_league/goal_stats/goal_stats.dart';
import 'package:futawesome/screens/competitions/brazilian_league/league_table/league_table.dart';
import 'package:futawesome/screens/competitions/brazilian_league/rounds/rounds.dart';
import 'package:futawesome/screens/competitions/header/header.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BrazilianLeague extends StatefulWidget {
  const BrazilianLeague({Key? key}) : super(key: key);

  @override
  State<BrazilianLeague> createState() => _BrazilianLeagueState();
}

class _BrazilianLeagueState extends State<BrazilianLeague> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SlidingUpPanel(
        snapPoint: 0.5,
        onPanelOpened: () {},
        onPanelClosed: () {},
        maxHeight: maxPanelHeight(context),
        panel: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.background,
              tabs: [
                Icons.list_alt,
                Icons.sports,
                Icons.calendar_month,
              ]
                  .map((icon) {
                    return Tab(
                      icon: Icon(
                        icon,
                        size: 32,
                        color: AppColors.background,
                      ),
                    );
                  })
                  .toList()
                  .cast<Widget>(),
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  LeagueTable(),
                  GoalStats(),
                  Rounds(),
                ],
              ),
            )
          ],
        ),
        backdropEnabled: true,
        backdropTapClosesPanel: true,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        body: FutureBuilder(
          future: CompetitionService().getCompetition(10),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const CupertinoActivityIndicator();
            }

            final competition = snapshot.data as Competition;

            return Header(
              competition: competition,
            );
          },
        ),
      ),
    );
  }
}
