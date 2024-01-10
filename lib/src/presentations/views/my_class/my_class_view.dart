import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiqa_tutoring_app/src/domain/models/student_model.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:thiqa_tutoring_app/src/utils/components/my_text.dart';
import 'package:thiqa_tutoring_app/src/utils/resources/values_manager.dart';

import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/fonts_manager.dart';
import '../../../utils/resources/styles_manager.dart';

class MyClassView extends StatelessWidget {
  const MyClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: 'MyClass',
          style: getBoldStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s18,
          ),
        ),
      ),
      body: BlocConsumer<DatabaseCubit, DatabaseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DatabaseCubit cubit = DatabaseCubit.get(context);
          return ListView.separated(
            itemBuilder: (context, index) {
              return buildStudentItem(cubit.students[index]);
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
            itemCount: cubit.students.length,
          );
        },
      ),
    );
  }

  Widget buildStudentItem(Student student) {
    return Padding(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MText(
                text: student.name ?? 'no Name',
                style: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: AppSize.s18,
                ),
              ),
              MText(
                text: student.phone ?? 'no Name',
                style: getMediumStyle(
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
