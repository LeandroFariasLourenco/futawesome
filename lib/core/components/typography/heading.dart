import 'package:flutter/cupertino.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.text,
    this.color = const Color(0xff000000),
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: color,
      ),
    );
  }
}
