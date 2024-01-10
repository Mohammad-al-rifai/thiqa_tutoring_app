import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thiqa_tutoring_app/src/config/themes/themes_manager.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/app_cubit/app_cubit.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';

import '../../presentations/views/splash/splash_view.dart';
import '../../utils/functions/functions.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => DatabaseCubit()..createDataBase(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(getScreenWidth(context), getScreenHeight(context)),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          ScreenUtil.init(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
