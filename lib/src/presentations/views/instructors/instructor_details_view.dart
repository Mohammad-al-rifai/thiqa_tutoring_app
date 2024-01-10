import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiqa_tutoring_app/src/domain/models/work_day_model.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:thiqa_tutoring_app/src/utils/components/text_button.dart';
import 'package:thiqa_tutoring_app/src/utils/components/text_form_field.dart';
import 'package:thiqa_tutoring_app/src/utils/components/toast_notifications.dart';
import 'package:thiqa_tutoring_app/src/utils/functions/functions.dart';
import 'package:thiqa_tutoring_app/src/utils/resources/values_manager.dart';

import '../../../domain/models/instructor_model.dart';
import '../../../utils/components/my_text.dart';
import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/fonts_manager.dart';
import '../../../utils/resources/styles_manager.dart';

class InstructorDetailsView extends StatefulWidget {
  const InstructorDetailsView({super.key, required this.instructor});

  final Instructor instructor;

  @override
  State<InstructorDetailsView> createState() => _InstructorDetailsViewState();
}

class _InstructorDetailsViewState extends State<InstructorDetailsView> {
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    for (var e in DatabaseCubit.get(context).instructorWorkDays) {
      for (var d in days) {
        if (e.dayName == d.dayName) {
          d.selected = true;
          break;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {
        if (state is AddInsWorkDayDoneState) {
          popScreen(context);
          showToast(text: 'Day Added Done', state: ToastStates.SUCCESS);
        }
        if (state is DeleteInsWorkDayDoneState) {
          showToast(text: 'Day Deleted Done', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: MText(
              text: '${widget.instructor.name!} Details',
              style: getBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s18,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppPadding.p8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.p12,
                  ),
                  child:
                      MText(text: 'Please Select Available Day for Teaching:'),
                ),
                SizedBox(
                  height: AppSize.s60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildDayItem(days[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: AppPadding.p4,
                        ),
                      );
                    },
                    itemCount: days.length,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return buildInstructorWorkDay(
                        cubit.instructorWorkDays[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: AppPadding.p4,
                        ),
                      );
                    },
                    itemCount: cubit.instructorWorkDays.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDayItem(DaysSelected day) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: day.selected,
              onChanged: (bool? value) {
                if (value == true) {
                  setState(() {
                    day.selected = value ?? false;
                  });
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        icon: Icon(
                          CupertinoIcons.clock,
                          size: AppSize.s30,
                          color: ColorManager.darkPrimary,
                        ),
                        title: MText(
                          text: 'Select work Time for ${day.dayName}',
                          style: getBoldStyle(
                            color: ColorManager.darkPrimary,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TFF(
                                controller: fromTimeController,
                                keyboardType: TextInputType.none,
                                label: 'From time',
                                prefixIcon: CupertinoIcons.forward_end,
                                validator: (String value) {},
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then(
                                    (value) {
                                      fromTimeController.text =
                                          value!.format(context);
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: AppSize.s16),
                              TFF(
                                controller: toTimeController,
                                keyboardType: TextInputType.none,
                                label: 'To time',
                                prefixIcon: CupertinoIcons.backward_end,
                                validator: (String value) {},
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then(
                                    (value) {
                                      toTimeController.text =
                                          value!.format(context);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          DTextButton(
                            text: 'Submit',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.addInstructorWorkDay(
                                  instructorId: widget.instructor.id!,
                                  dayName: day.dayName,
                                  fromTime: fromTimeController.text,
                                  toTime: toTimeController.text,
                                );
                              }
                            },
                          ),
                          DTextButton(
                            text: 'Cancel',
                            function: () {
                              setState(() {
                                day.selected = false;
                              });
                              popScreen(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  cubit.deleteInstructorWorkDay(
                    instructorId: widget.instructor.id!,
                    dayName: day.dayName,
                  );
                  setState(() {
                    day.selected = value;
                  });
                }
              },
            ),
            MText(text: day.dayName),
          ],
        );
      },
    );
  }

  List<DaysSelected> days = [
    DaysSelected("Su"),
    DaysSelected("Mo"),
    DaysSelected("Tu"),
    DaysSelected("We"),
    DaysSelected("Th"),
    DaysSelected("Fr"),
    DaysSelected("Sa"),
  ];

  Widget buildInstructorWorkDay(WorkDay day) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppPadding.p12),
      child: Card(
        child: ListTile(
          dense: true,
          leading: MText(
            text: day.dayName ?? 'No DayName',
            style: getMediumStyle(
              color: ColorManager.darkPrimary,
              fontSize: AppSize.s18,
            ),
          ),
          title: MText(
            text: 'From: ${day.fromTime ?? 'no fromTime'}',
            style: getMediumStyle(
              color: ColorManager.darkPrimary,
            ),
          ),
          trailing: MText(
            text: 'To: ${day.toTime ?? 'no toTime'}',
            style: getMediumStyle(
              color: ColorManager.darkPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class DaysSelected {
  String dayName;
  bool? selected;

  DaysSelected(this.dayName, {this.selected = false});
}
