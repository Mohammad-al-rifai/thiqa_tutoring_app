import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiqa_tutoring_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:thiqa_tutoring_app/src/presentations/layouts/home_layout/home_layout.dart';
import 'package:thiqa_tutoring_app/src/utils/components/toast_notifications.dart';

import '../../../utils/components/button.dart';
import '../../../utils/components/my_divider.dart';
import '../../../utils/components/text_button.dart';
import '../../../utils/components/text_form_field.dart';
import '../../../utils/functions/functions.dart';
import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/styles_manager.dart';
import '../../../utils/resources/values_manager.dart';
import '../../widgets/auth_background_widget.dart';
import '../../widgets/container_box.dart';
import '../login/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassShowed = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {
        if (state is StudentRegisterDoneState) {
          showToast(text: 'Registered Done✔️', state: ToastStates.SUCCESS);
          navigateAndFinish(context, const HomeLayout());
        }
      },
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const AuthBackGroundWidget(title: 'Register'),
                  Padding(
                    padding: const EdgeInsetsDirectional.all(AppPadding.p18),
                    child: Column(
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 1800),
                          child: AuthContainerBox(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TFF(
                                    controller: nameController,
                                    label: 'Full Name',
                                    prefixIcon: CupertinoIcons.person,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Full Name Must not be empty!';
                                      }
                                    },
                                  ),
                                  SizedBox(height: AppSize.s12),
                                  TFF(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    label: 'E-mail',
                                    prefixIcon: CupertinoIcons.mail,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Email Must not be empty!';
                                      }
                                    },
                                  ),
                                  SizedBox(height: AppSize.s12),
                                  TFF(
                                    isPassword: isPassShowed,
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    label: 'Password',
                                    prefixIcon: CupertinoIcons.lock,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Password Must not be empty!';
                                      }
                                    },
                                    suffix: isPassShowed
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    suffixPressed: () => changeVisibility(),
                                  ),
                                  SizedBox(height: AppSize.s12),
                                  TFF(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    label: 'Phone',
                                    prefixIcon: CupertinoIcons.phone,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Phone Must not be empty!';
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSize.s30),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1900),
                          child: DefaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.studentRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                          ),
                        ),
                        SizedBox(height: AppSize.s8),
                        FadeInUp(
                          duration: const Duration(milliseconds: 2100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyDivider(width: getScreenWidth(context) / 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8,
                                ),
                                child: Text(
                                  'OR',
                                  style:
                                      getBoldStyle(color: ColorManager.primary),
                                ),
                              ),
                              MyDivider(width: getScreenWidth(context) / 12),
                            ],
                          ),
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 2300),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'I have an account',
                                style: getRegularStyle(
                                  color: ColorManager.primary,
                                ),
                              ),
                              DTextButton(
                                text: 'login',
                                isUpperCase: true,
                                function: () {
                                  navigateAndFinish(
                                    context,
                                    const LoginView(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSize.s40),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  changeVisibility() {
    setState(() {
      isPassShowed = !isPassShowed;
    });
  }
}
