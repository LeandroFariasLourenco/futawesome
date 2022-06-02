import 'package:flutter/cupertino.dart';
import 'package:futawesome/screens/favorites/widgets/league_table_preview.dart';
import 'package:futawesome/screens/favorites/widgets/main_section.dart';
import 'package:futawesome/screens/favorites/widgets/most_followed_teams.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  Widget _renderDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 48),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MainSection(),
          _renderDivider(),
          const MostFollowedTeams(),
          _renderDivider(),
          const LeagueTablePreview(),
        ],
      ),
    );
  }
}
