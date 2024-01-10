
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiqa_tutoring_app/src/presentations/views/home/home_view.dart';
import 'package:thiqa_tutoring_app/src/presentations/views/instructors/instructors_view.dart';
import 'package:thiqa_tutoring_app/src/presentations/views/my_class/my_class_view.dart';
import 'package:thiqa_tutoring_app/src/presentations/views/profile/profile_view.dart';

part 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomIndex());
  }

  List<Widget> views = [
    const HomeView(),
    const InstructorsView(),
    const MyClassView(),
    const ProfileView(),
  ];
}
