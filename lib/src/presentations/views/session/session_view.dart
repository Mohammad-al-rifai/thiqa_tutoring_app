import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:thiqa_tutoring_app/src/utils/components/toast_notifications.dart';
import 'package:thiqa_tutoring_app/src/utils/functions/functions.dart';

import '../../../domain/models/instructor_model.dart';
import '../../../utils/components/button.dart';
import '../../../utils/components/my_text.dart';
import '../../../utils/components/text_form_field.dart';
import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/styles_manager.dart';
import '../../../utils/resources/values_manager.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  TextEditingController fromTimeController = TextEditingController();

  List<String> daysOfWeek = [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];
  String selectedDay = 'Su'; // Default selected day

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {
        if (state is BookASessionDoneState) {
          showToast(
            text: 'Session Booked Successfully',
            state: ToastStates.SUCCESS,
          );
        }
        if (state is BookASessionErrorState) {
          showToast(
            text: 'Can\'t add This Session!',
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: MText(
              text: 'Book a Session',
              style: getBlackStyle(
                color: ColorManager.darkPrimary,
                fontSize: AppSize.s20,
              ),
            ),
            actions: [
              Icon(
                CupertinoIcons.bookmark_fill,
                size: AppSize.s30,
                color: ColorManager.darkPrimary,
              ),
              const Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: AppPadding.p12,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppPadding.p8,
                end: AppPadding.p8,
                bottom: AppPadding.p8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: DropdownButton<String>(
                            value: selectedDay,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDay = newValue ?? '';
                              });
                            },
                            items: daysOfWeek
                                .map<DropdownMenuItem<String>>((String day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day),
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppPadding.p12,
                              vertical: AppPadding.p12,
                            ),
                            child: TFF(
                              controller: fromTimeController,
                              label: 'Start Time',
                              keyboardType: TextInputType.none,
                              prefixIcon: CupertinoIcons.clock,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Select a valid time';
                                }
                              },
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.s12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MText(
                      text: 'All Available Instructor Now, Select One Please',
                    ),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildInstructorItem(
                        cubit.instructors[index],
                        index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: AppPadding.p8,
                        ),
                      );
                    },
                    itemCount: cubit.instructors.length,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            width: 180.0,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {},
              child: DefaultButton(
                function: () {
                  myPrint(
                    text: 'Start Time Controller : ${fromTimeController.text}',
                  );
                  myPrint(text: 'InstructorId: $instructorId');
                  myPrint(text: 'StudentId: ${cubit.me.id}');

                  if (fromTimeController.text.isNotEmpty &&
                      instructorId != 0 &&
                      cubit.me.id != null) {
                    cubit.bookASession(
                      instructorId: instructorId!,
                      studentId: cubit.me.id!,
                      startFromTime: fromTimeController.text,
                      dayName: selectedDay,
                    );
                  } else {
                    showToast(
                      text: 'Please Select a valid data',
                      state: ToastStates.ERROR,
                    );
                  }
                },
                text: 'Confirm Booking',
                isUpperCase: false,
              ),
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        );
      },
    );
  }

  int? selectedIndex;

  int? instructorId = 0;

  Widget buildInstructorItem(Instructor instructor, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          if (selectedIndex == index) {
            instructorId = instructor.id;
          }
        });
        myPrint(text: 'InstructorId : $instructorId');
      },
      child: Card(
        child: ListTile(
          leading: MText(
            text: instructor.name ?? '',
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: AppSize.s18,
            ),
          ),
          trailing: Icon(
            selectedIndex == index
                ? CupertinoIcons.checkmark_seal_fill
                : CupertinoIcons.checkmark_seal,
            color: selectedIndex == index
                ? ColorManager.darkPrimary
                : ColorManager.lightGrey,
          ),
        ),
      ),
    );
  }
}
