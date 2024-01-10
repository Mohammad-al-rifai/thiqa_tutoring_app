import 'package:flutter/material.dart';

import '../../utils/resources/color_manager.dart';
import '../../utils/resources/values_manager.dart';


class AuthContainerBox extends StatelessWidget {
  const AuthContainerBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppPadding.p18),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(
          color: ColorManager.lightPrimary.withOpacity(.5),
        ),
        boxShadow: const [
          BoxShadow(
            color: ColorManager.lightPrimary,
            blurRadius: 20.0,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: child,
    );
  }
}
