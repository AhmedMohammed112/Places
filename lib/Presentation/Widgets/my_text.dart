import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class MyText extends StatelessWidget {
  String text;
  double size;
  bool bold = false;
  Color color;
  int lines;
  final TextStyle? style;

  MyText(
      {super.key,
        required this.text,
        this.size = 14,
        this.bold = false,
        this.color = Colors.white,
        this.lines = 99,
        this.style = const TextStyle()
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style!.copyWith(
        fontSize: size,
      ),
      maxLines: lines,
    );
  }
}
