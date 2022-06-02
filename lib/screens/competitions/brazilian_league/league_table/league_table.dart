import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/services/brazilian_league_service.dart';
import 'package:jovial_svg/jovial_svg.dart';

class LeagueTable extends StatefulWidget {
  const LeagueTable({Key? key}) : super(key: key);

  @override
  State<LeagueTable> createState() => _LeagueTableState();
}

class _LeagueTableState extends State<LeagueTable>
    with AutomaticKeepAliveClientMixin {
  late Future<List<dynamic>> futureTable;

  @override
  void initState() {
    super.initState();
    futureTable = BrazilianLeagueService().getLeagueTable();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<DataColumn> getColumns(List<String> columns) {
      List<DataColumn> dataColumns = [];
      for (final column in columns) {
        dataColumns.add(DataColumn(label: Text(column)));
      }

      return dataColumns;
    }

    List<DataRow> getRows(List<dynamic> rows) {
      List<DataRow> dataRows = [];

      for (final row in rows) {
        dataRows.add(
          DataRow(
            color: MaterialStateColor.resolveWith((states) {
              if (row.posicao == 1) {
                return AppColors.tablePositions[TablePositions.leader]!;
              }

              if (row.posicao <= 4) {
                return AppColors
                    .tablePositions[TablePositions.topAutomaticQualifiers]!;
              }

              if (row.posicao <= 6) {
                return AppColors.tablePositions[TablePositions.topQualifiers]!;
              }

              if (row.posicao <= 12) {
                return AppColors
                    .tablePositions[TablePositions.subAutomaticQualifiers]!;
              }

              if (row.posicao >= 17) {
                return AppColors.tablePositions[TablePositions.relegation]!;
              }

              return Colors.transparent;
            }),
            cells: [
              DataCell(Text("${row.posicao}º")),
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
              DataCell(Text("${row.pontos}")),
              DataCell(Text("${row.jogos}")),
              DataCell(Text("${row.vitorias}")),
              DataCell(Text("${row.empates}")),
              DataCell(Text("${row.derrotas}")),
              DataCell(Text("${row.saldoGols}")),
              DataCell(Text("${row.golsContra}")),
              DataCell(Text("${row.golsPro}")),
              DataCell(Text("${row.aproveitamento}")),
            ],
          ),
        );
      }

      return dataRows;
    }

    return FutureBuilder(
      future: futureTable,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const CupertinoActivityIndicator();
        }

        final list = snapshot.data! as List<dynamic>;

        return Expanded(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: getColumns([
                  "Pos.",
                  "Clube",
                  "P",
                  "P.J",
                  "V",
                  "E",
                  "D",
                  "GP",
                  "GS",
                  "SG",
                  "Aprov."
                ]),
                columnSpacing: 20,
                rows: getRows(list),
              ),
            ),
          ),
        );
      },
    );
  }
}
