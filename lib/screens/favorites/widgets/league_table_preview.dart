import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/components/typography/subtitle.dart';
import 'package:futawesome/core/models/brazilian_league_team.dart';
import 'package:futawesome/core/services/brazilian_league_service.dart';
import 'package:jovial_svg/jovial_svg.dart';

class LeagueTablePreview extends StatefulWidget {
  const LeagueTablePreview({Key? key}) : super(key: key);

  @override
  State<LeagueTablePreview> createState() => _LeagueTablePreviewState();
}

class _LeagueTablePreviewState extends State<LeagueTablePreview> {
  List<DataRow> _getRows(List<BrazilianLeagueTeam> table) {
    List<DataRow> rows = [];

    for (final row in table) {
      rows.add(
        DataRow(
          cells: [
            DataCell(
              Row(
                children: [
                  Text("${row.posicao}"),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
            ),
            DataCell(
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 30,
                    height: 30,
                    child: ScalableImageWidget.fromSISource(
                      alignment: Alignment.center,
                      si: ScalableImageSource.fromSvgHttpUrl(
                          Uri.parse(row.time["escudo"])),
                    ),
                  ),
                  Text("${row.time["nome_popular"]}"),
                ],
              ),
            ),
            DataCell(
              Text("${row.pontos}"),
            ),
            DataCell(
              Text("${row.saldoGols}"),
            ),
            DataCell(
              Text("${row.pontos}"),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  List<DataColumn> _getColumns(List<String> columns) {
    List<DataColumn> dataColumns = [];

    for (final column in columns) {
      dataColumns.add(DataColumn(
        label: Text(column),
      ));
    }

    return dataColumns;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Card(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            children: [
              Row(
                children: const [
                  Subtitle(
                    text: "Tabela",
                  ),
                ],
              ),
              FutureBuilder(
                future: BrazilianLeagueService().getLeagueTable(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const CupertinoActivityIndicator();
                  }

                  final table = (snapshot.data! as List<BrazilianLeagueTeam>)
                      .sublist(0, 5);
                  return DataTable(
                    columns: _getColumns(["Pos", "Clube", "P", "GD", "Pts"]),
                    rows: _getRows(table),
                  );
                },
              ),
              CupertinoButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Tabela completa"),
                    Icon(Icons.arrow_right_alt_rounded),
                  ],
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
