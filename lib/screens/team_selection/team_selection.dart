import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/components/typography/subtitle.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/models/brazilian_league_team.dart';
import 'package:futawesome/core/services/brazilian_league_service.dart';
import 'package:jovial_svg/jovial_svg.dart';

class TeamSelection extends StatefulWidget {
  final VoidCallback onSelectTeams;

  const TeamSelection({Key? key, required this.onSelectTeams})
      : super(key: key);

  @override
  State<TeamSelection> createState() => _TeamSelectionState();
}

class _TeamSelectionState extends State<TeamSelection> {
  final Map<int, BrazilianLeagueTeam> _selectedTeams = {};

  void selectTeam(BrazilianLeagueTeam team) {
    setState(() {
      _selectedTeams[team.time["time_id"]] = team;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(0, 0, 0, 0.7),
            BlendMode.darken,
          ),
          image: AssetImage("assets/images/background.jpg"),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: Column(
        children: [
          const Subtitle(
            text: "Qual time gostaria de acompanhar?",
            color: AppColors.textSecondaryColor,
          ),
          Expanded(
            child: FutureBuilder(
              future: BrazilianLeagueService().getLeagueTable(),
              initialData: const [],
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.data == null) {
                  return const CupertinoActivityIndicator();
                }

                List<BrazilianLeagueTeam> teams =
                    snapshot.data! as List<BrazilianLeagueTeam>;

                return GridView.count(
                  padding: const EdgeInsets.all(28),
                  crossAxisCount: 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  children: teams.map((team) {
                    final bool isTeamSelected =
                        _selectedTeams.containsKey(team.time["time_id"]);
                    return Card(
                      elevation: 3,
                      child: MaterialButton(
                        color:
                            isTeamSelected ? AppColors.primary : Colors.white,
                        onPressed: () {
                          setState(() {
                            final bool notifyUser = _selectedTeams.isEmpty;
                            if (notifyUser) {
                              final scaffold = ScaffoldMessenger.of(context);

                              scaffold.showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "Você pode selecionar até 5 times!"),
                                  action: SnackBarAction(
                                    label: "Fechar",
                                    onPressed: scaffold.hideCurrentSnackBar,
                                  ),
                                ),
                              );
                            }

                            if (isTeamSelected) {
                              _selectedTeams.remove(team.time["time_id"]);
                              return;
                            }

                            final bool maximumReached =
                                _selectedTeams.length == 5;
                            if (maximumReached) return;

                            _selectedTeams[team.time["time_id"]] = team;
                          });
                        },
                        child: ScalableImageWidget.fromSISource(
                          alignment: Alignment.center,
                          si: ScalableImageSource.fromSvgHttpUrl(
                            Uri.parse(team.time["escudo"]),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          MaterialButton(
            elevation: 2,
            color: AppColors.secondary,
            textColor: AppColors.textSecondaryColor,
            onPressed: () {
              widget.onSelectTeams();
            },
            child: const Text("Selecionar"),
          ),
        ],
      ),
    );
  }
}
