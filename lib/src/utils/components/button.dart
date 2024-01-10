import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'loading.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    super.key,
    required this.function,
    required this.text,
    this.width,
    this.height = 45.0,
    this.background = ColorManager.primary,
    this.isUpperCase = true,
    this.isLoading = false,
  });

  Function function;
  String text;
  double? width;
  double? height;
  Color? background;
  bool? isUpperCase;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Conditional.single(
        context: context,
        conditionBuilder: (BuildContext context) => !isLoading,
        widgetBuilder: (BuildContext context) {
          return SizedBox(
            width: width ?? double.infinity,
            height: height,
            child: ElevatedButton(
              onPressed: () => function(),
              style: ElevatedButton.styleFrom(
                backgroundColor: background,
              ),
              child: Text(
                isUpperCase! ? text.toUpperCase() : text,
                style: getRegularStyle(
                  color: ColorManager.white,
                  fontSize: AppSize.s16,
                ),
              ),
            ),
          );
        },
        fallbackBuilder: (BuildContext context) {
          return const DefaultLoading();
        },
      ),
    );
  }
}
