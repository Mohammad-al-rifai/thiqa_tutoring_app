import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../utils/components/my_text.dart';
import '../../utils/resources/assets_manager.dart';
import '../../utils/resources/color_manager.dart';
import '../../utils/resources/styles_manager.dart';
import '../../utils/resources/values_manager.dart';


class AuthBackGroundWidget extends StatelessWidget {
  const AuthBackGroundWidget({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeInUp(
              duration: const Duration(seconds: 1),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.light1),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 140,
            width: 80,
            height: 150,
            child: FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.light2),
                    ),
                  ),
                )),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: 80,
            height: 150,
            child: FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.clock),
                    ),
                  ),
                )),
          ),
          Positioned(
            child: FadeInUp(
              duration: const Duration(milliseconds: 1600),
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: MText(
                    text: title,
                    maxLines: 2,
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: AppSize.s30,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
