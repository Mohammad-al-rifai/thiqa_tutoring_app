import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:thiqa_tutoring_app/src/presentations/views/splash/splash_view.dart';
import 'package:thiqa_tutoring_app/src/utils/components/button.dart';
import 'package:thiqa_tutoring_app/src/utils/components/my_text.dart';
import 'package:thiqa_tutoring_app/src/utils/functions/functions.dart';
import 'package:thiqa_tutoring_app/src/utils/resources/color_manager.dart';
import 'package:thiqa_tutoring_app/src/utils/resources/fonts_manager.dart';
import 'package:thiqa_tutoring_app/src/utils/resources/styles_manager.dart';
import 'package:thiqa_tutoring_app/src/utils/resources/values_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: MText(
              text: 'Profile',
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s18,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.all(AppPadding.p12),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      height: getScreenHeight(context) / 4,
                      width: getScreenHeight(context),
                      decoration: BoxDecoration(
                        color: ColorManager.lightPrimary,
                        borderRadius:
                            BorderRadiusDirectional.circular(AppSize.s8),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, 50.0),
                      child: CircleAvatar(
                        radius: AppSize.s70,
                        child: Icon(
                          CupertinoIcons.person,
                          size: AppSize.s70,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s50),
                MText(
                  text: cubit.me.name ?? '',
                  style: getBlackStyle(
                    color: ColorManager.darkPrimary,
                    fontSize: AppSize.s25,
                  ),
                ),
                MText(
                  text: cubit.me.email ?? '',
                  style: getLightStyle(
                    color: ColorManager.lightPrimary,
                    fontSize: AppSize.s20,
                  ),
                ),
                MText(
                  text: cubit.me.phone ?? '',
                  style: getLightStyle(
                    color: ColorManager.lightPrimary,
                    fontSize: AppSize.s20,
                  ),
                ),
                SizedBox(height: AppSize.s12),
                DefaultButton(
                  function: () {
                    navigateAndFinish(context, const SplashView());
                  },
                  text: 'Logout',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
