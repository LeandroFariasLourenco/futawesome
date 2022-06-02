import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/components/typography/subtitle.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/models/brazilian_league_team.dart';
import 'package:futawesome/core/services/brazilian_league_service.dart';
import 'package:jovial_svg/jovial_svg.dart';

class MostFollowedTeams extends StatefulWidget {
  const MostFollowedTeams({Key? key}) : super(key: key);

  @override
  State<MostFollowedTeams> createState() => _MostFollowedTeamsState();
}

class _MostFollowedTeamsState extends State<MostFollowedTeams> {
  final random = Random();
  int get min => random.nextInt(9);
  int get max => min + random.nextInt(19);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Subtitle(
            text: "Times mais seguidos", color: AppColors.textSecondaryColor),
        FutureBuilder(
          future: BrazilianLeagueService().getLeagueTable(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const CupertinoActivityIndicator();
            }

            final teams =
                (snapshot.data as List<BrazilianLeagueTeam>).sublist(min, max);
            return CarouselSlider(
              items: teams.map((team) {
                return Card(
                  elevation: 4,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ScalableImageWidget.fromSISource(
                      si: ScalableImageSource.fromSvgHttpUrl(
                        Uri.parse(team.time["escudo"]),
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.2,
                height: 100,
              ),
            );
          },
        ),
      ],
    );
  }
}
