import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/models/top_scorer.dart';
import 'package:futawesome/core/services/brazilian_league_service.dart';
import 'package:jovial_svg/jovial_svg.dart';

class GoalStats extends StatefulWidget {
  const GoalStats({Key? key}) : super(key: key);

  @override
  State<GoalStats> createState() => _GoalStatsState();
}

class _GoalStatsState extends State<GoalStats>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  List<DataColumn> getColumns(List<String> columns) {
    List<DataColumn> dataColumns = [];
    for (final column in columns) {
      dataColumns.add(DataColumn(label: Text(column)));
    }
    return dataColumns;
  }

  List<DataRow> getRows(List<TopScorer> scorers) {
    List<DataRow> dataRows = [];
    // int currentIndex = 1;

    scorers.asMap().forEach((index, scorer) {
      dataRows.add(DataRow(
        color: MaterialStateColor.resolveWith((states) {
          if (index == 0) {
            return AppColors.tablePositions[TablePositions.leader]!;
          }

          if (index <= 2) {
            return AppColors
                .tablePositions[TablePositions.topAutomaticQualifiers]!;
          }

          return Colors.transparent;
        }),
        cells: [
          DataCell(Text("${index + 1}º")),
          DataCell(Text(scorer.goals.toString())),
          DataCell(
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(right: 10),
                  child: ScalableImageWidget.fromSISource(
                    si: ScalableImageSource.fromSvgHttpUrl(
                      Uri.parse(scorer.team.badge),
                    ),
                  ),
                ),
                Text(scorer.athlete.name),
              ],
            ),
          ),
          DataCell(
            Text(scorer.athlete.position != null
                ? scorer.athlete.position!.name
                : ''),
          ),
        ],
      ));
    });

    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: FutureBuilder(
        future: BrazilianLeagueService().getTopScorers(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const CupertinoActivityIndicator();
          }

          List<TopScorer> scorers = snapshot.data! as List<TopScorer>;

          return DataTable(
            columnSpacing: 0,
            columns: getColumns(["P", "Gols", "Jogador", "Pos."]),
            rows: getRows(scorers.sublist(0, 15)),
          );
        },
      ),
    );
  }
}
