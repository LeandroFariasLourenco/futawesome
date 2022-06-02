import 'package:flutter/material.dart';

const primaryHex = 0xff008C1A;
final primaryColor = Colors.green.shade500;

enum TablePositions {
  leader,
  topAutomaticQualifiers,
  topQualifiers,
  subAutomaticQualifiers,
  relegation,
}

class AppColors {
  static const primary = Color(0xff00FF87);

  static const secondary = Color(0xffE90052);

  static const tertiary = Color(0xff04F5FF);

  static const accent = Color(0xffEAFF04);

  static const textSecondaryColor = Color(0xffffffff);

  static const background = Color(0xff1A1A1A);

  static final Map<TablePositions, Color> tablePositions = {
    TablePositions.leader: Colors.green.shade100,
    TablePositions.topAutomaticQualifiers: Colors.blue.shade200,
    TablePositions.topQualifiers: Colors.blue.shade100,
    TablePositions.subAutomaticQualifiers: Colors.orange.shade100,
    TablePositions.relegation: Colors.red.shade100,
  };
}
