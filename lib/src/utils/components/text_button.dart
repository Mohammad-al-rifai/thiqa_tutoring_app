import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class DTextButton extends StatelessWidget {
  DTextButton({
    Key? key,
    required this.text,
    required this.function,
    this.isUpperCase = false,
  }) : super(key: key);

  Function function;
  bool isUpperCase;
  String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => function(),
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: getMediumStyle(color: ColorManager.primary),
      ),
    );
  }
}
