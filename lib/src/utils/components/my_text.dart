// ignore_for_file: must_be_immutable

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import 'package:flutter/material.dart';

class MText extends StatelessWidget {
  MText({
    Key? key,
    required this.text,
    this.style,
    this.maxLines = 1,
    this.color,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  String text;
  TextStyle? style;
  int? maxLines;
  Color? color;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          getMediumStyle(
            color: color ?? ColorManager.primary,
          ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
