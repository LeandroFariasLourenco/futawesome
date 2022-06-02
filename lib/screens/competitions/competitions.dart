import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/screens/competitions/brazilian_cup/brazilian_cup.dart';
import 'package:futawesome/screens/competitions/brazilian_league/brazilian_league.dart';
import 'package:futawesome/screens/competitions/champions_league/champions_league.dart';

class Competitions extends StatelessWidget {
  const Competitions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          viewportFraction: 1,
          height: MediaQuery.of(context).size.height,
        ),
        items: [
          const BrazilianLeague(),
          BrazilianCup(),
          ChampionsLeague(),
        ],
      ),
    );
  }
}
