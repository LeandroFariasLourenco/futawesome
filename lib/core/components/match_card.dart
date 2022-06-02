import 'package:flutter/material.dart';
import 'package:futawesome/core/components/typography/heading.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/models/match.dart';
import 'package:jovial_svg/jovial_svg.dart';

enum TeamType {
  home,
  away,
}

enum Layout {
  compact,
  regular,
}

class MatchCard extends StatelessWidget {
  const MatchCard({
    Key? key,
    required this.match,
    this.layout = Layout.regular,
  }) : super(key: key);

  final Match match;
  final Layout layout;

  bool get isCompact => layout == Layout.compact;

  Widget _renderScoreBoardBox(int? score) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        color: score == null ? AppColors.tertiary : AppColors.primary,
      ),
      child: Text(
        "${score ?? "-"}",
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _renderTeam(Team team, TeamType type) {
    Widget teamBadge() {
      return Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.only(
          right: type == TeamType.home ? 5 : 0,
          left: type == TeamType.away ? 5 : 0,
        ),
        child: ScalableImageWidget.fromSISource(
          si: ScalableImageSource.fromSvgHttpUrl(
            Uri.parse(team.badge),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: type == TeamType.away
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        (() {
          if (type != TeamType.home) return Container();
          return teamBadge();
        })(),
        Heading(text: isCompact ? team.acronym : team.name),
        (() {
          if (type == TeamType.home) return Container();
          return teamBadge();
        })(),
      ],
    );
  }

  Widget _renderLayoutBasedOnType(Widget content) {
    if (isCompact) {
      return Container();
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    _renderTeam(
                      match.hostTeam,
                      TeamType.home,
                    ),
                    Container(height: 10),
                    _renderLayoutBasedOnType(Row(
                      children: [
                        const Icon(Icons.stadium, size: 18),
                        SizedBox(
                          width: 100,
                          child: Heading(text: match.stadium.name),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _renderScoreBoardBox(match.hostScore),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 36,
                          width: 1,
                          color: AppColors.background,
                        ),
                        _renderScoreBoardBox(match.visitorScore),
                      ],
                    ),
                    Container(height: 10),
                    _renderLayoutBasedOnType(
                      Row(
                        children: [
                          const Icon(Icons.punch_clock, size: 17),
                          Heading(text: match.realizedHour),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    _renderTeam(
                      match.visitorTeam,
                      TeamType.away,
                    ),
                    Container(height: 10),
                    _renderLayoutBasedOnType(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_month, size: 18),
                          Heading(text: match.realizedDate ?? ""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            color: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}
