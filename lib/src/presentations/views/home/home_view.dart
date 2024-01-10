import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:thiqa_tutoring_app/src/presentations/views/session/session_view.dart';
import 'package:thiqa_tutoring_app/src/utils/components/button.dart';
import 'package:thiqa_tutoring_app/src/utils/components/my_text.dart';
import 'package:thiqa_tutoring_app/src/utils/functions/functions.dart';
import 'dart:async';

import '../../../utils/resources/assets_manager.dart';
import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/styles_manager.dart';
import '../../../utils/resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();

    DatabaseCubit.get(context).getSessions(
      database: DatabaseCubit.get(context).database,
      studentId: DatabaseCubit.get(context).me.id!,
    );

    Timer(const Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leadingWidth: AppSize.s100,
            leading: Padding(
              padding: const EdgeInsetsDirectional.only(start: AppPadding.p8),
              child: SvgPicture.asset(
                IconsAssets.thiqa,
                color: ColorManager.darkPrimary,
              ),
            ),
            actions: [
              IconButton(
                color: ColorManager.primary,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: AppSize.s30,
                ),
              ),
              IconButton(
                color: ColorManager.primary,
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  size: AppSize.s30,
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(start: AppPadding.p8),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: isVisible,
                  child: MText(
                    text: 'Welcome Back "${cubit.me.name}" ',
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: AppSize.s18,
                    ),
                  ),
                ),
                MText(
                  text: 'My Sessions',
                  style: getBlackStyle(
                    color: ColorManager.darkPrimary,
                    fontSize: AppSize.s25,
                  ),
                ),
                Conditional.single(
                    context: context,
                    conditionBuilder: (context) => cubit.mySessions.isNotEmpty,
                    widgetBuilder: (context) {
                      return Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.all(
                                  AppPadding.p12),
                              child: Card(
                                child: ListTile(
                                  dense: true,
                                  leading: MText(
                                    text:
                                        cubit.mySessions[index].startFromTime ??
                                            '',
                                    style: getMediumStyle(
                                      color: ColorManager.darkPrimary,
                                      fontSize: AppSize.s18,
                                    ),
                                  ),
                                  title: MText(
                                    text: cubit.mySessions[index].dayName ?? '',
                                    style: getMediumStyle(
                                      color: ColorManager.darkPrimary,
                                      fontSize: AppSize.s18,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.edit,
                                    size: AppSize.s20,
                                    color: ColorManager.darkPrimary,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsetsDirectional.all(
                                  AppPadding.p8),
                              margin: const EdgeInsetsDirectional.all(
                                  AppMargin.m12),
                              height: 0.5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    ColorManager.lightPrimary.withOpacity(.2),
                              ),
                            );
                          },
                          itemCount: cubit.mySessions.length,
                        ),
                      );
                    },
                    fallbackBuilder: (context) {
                      return Center(
                        child: MText(
                          text: 'You Haven\'t any session.. add one.',
                        ),
                      );
                    }),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            width: 160.0,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {},
              child: DefaultButton(
                function: () {
                  navigateTo(context, const SessionView());
                },
                text: 'Book a session',
                isUpperCase: false,
              ),
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        );
      },
    );
  }
}
