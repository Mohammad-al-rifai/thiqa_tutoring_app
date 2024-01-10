import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiqa_tutoring_app/src/domain/models/instructor_model.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:thiqa_tutoring_app/src/presentations/views/instructors/instructor_details_view.dart';
import 'package:thiqa_tutoring_app/src/utils/components/my_text.dart';
import 'package:thiqa_tutoring_app/src/utils/components/text_form_field.dart';
import 'package:thiqa_tutoring_app/src/utils/functions/functions.dart';

import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/fonts_manager.dart';
import '../../../utils/resources/styles_manager.dart';
import '../../../utils/resources/values_manager.dart';

class InstructorsView extends StatefulWidget {
  const InstructorsView({super.key});

  @override
  State<InstructorsView> createState() => _InstructorsViewState();
}

class _InstructorsViewState extends State<InstructorsView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isBottomSheetShown = false;
  IconData fabIcon = CupertinoIcons.add;

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    setState(() {
      isBottomSheetShown = isShow;
      fabIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {
        if (state is AddInstructorDoneState) {
          Navigator.pop(context);
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          setState(() {});
        }
      },
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: MText(
              text: 'Instructors',
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s18,
              ),
            ),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              return buildInstructorItem(cubit.instructors[index]);
            },
            separatorBuilder: (context, index) {
              return Container(
                padding: const EdgeInsetsDirectional.all(AppPadding.p8),
                margin: const EdgeInsetsDirectional.all(AppMargin.m12),
                height: 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.lightPrimary.withOpacity(.2),
                ),
              );
            },
            itemCount: cubit.instructors.length,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorManager.primary,
            mini: false,
            onPressed: () {
              if (isBottomSheetShown) {
                // opened
                if (formKey.currentState!.validate()) {
                  cubit.addInstructor(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                }
              } else {
                // Closed
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      elevation: 20.0,
                      (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          color: Colors.white,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TFF(
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Name must not be Empty';
                                    }
                                  },
                                  label: 'Name',
                                  prefixIcon: Icons.person,
                                ),
                                const SizedBox(height: 15.0),
                                TFF(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'E-mail must not be Empty';
                                    }
                                  },
                                  label: 'E-mail',
                                  prefixIcon: Icons.mail,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                TFF(
                                  controller: phoneController,
                                  keyboardType: TextInputType.datetime,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Phone must not be Empty';
                                    }
                                  },
                                  label: 'Phone',
                                  prefixIcon: Icons.call,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then(
                  (value) {
                    changeBottomSheet(isShow: false, icon: Icons.edit);
                  },
                );
                changeBottomSheet(isShow: true, icon: Icons.add);
              }
            },
            child: Icon(
              fabIcon,
              color: ColorManager.white,
            ),
          ),
        );
      },
    );
  }

  Widget buildInstructorItem(Instructor instructor) {
    return InkWell(
      onTap: () {
        DatabaseCubit.get(context).getAllWorkDays4Instructor(
          database: DatabaseCubit.get(context).database,
          instId: instructor.id!,
        );
        navigateTo(context, InstructorDetailsView(instructor: instructor));
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppPadding.p12),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSize.s30,
              backgroundColor: ColorManager.lightPrimary,
              child: Icon(
                Icons.person,
                size: AppSize.s50,
                color: ColorManager.white,
              ),
            ),
            SizedBox(width: AppSize.s8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MText(
                    text: instructor.name ?? 'no Name',
                    style: getMediumStyle(
                      color: ColorManager.primary,
                      fontSize: AppSize.s18,
                    ),
                  ),
                  MText(
                    text: instructor.phone ?? 'no Name',
                    style: getMediumStyle(
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSize.s8),
            const Icon(CupertinoIcons.info),
          ],
        ),
      ),
    );
  }
}
