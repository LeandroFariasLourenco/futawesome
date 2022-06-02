import 'package:flutter/cupertino.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key? key,
    required this.text,
    this.color = const Color(0xff000000),
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontFamily: "OswaldBold",
        color: color,
      ),
    );
  }
}
