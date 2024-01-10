import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/resources/color_manager.dart';
import '../../utils/resources/fonts_manager.dart';
import '../../utils/resources/styles_manager.dart';
import '../../utils/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primarySwatch: Colors.amber,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.white,

    scaffoldBackgroundColor: ColorManager.white,
    // cardView theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s8,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: AppSize.s4,
      selectedItemColor: ColorManager.darkPrimary,
      unselectedItemColor: ColorManager.grey,
      selectedIconTheme: IconThemeData(size: AppSize.s28),
      backgroundColor: ColorManager.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedLabelStyle: getMediumStyle(
        color: ColorManager.lightPrimary,
        fontSize: AppSize.s12,
      ),
      selectedLabelStyle: getMediumStyle(
        color: ColorManager.darkPrimary,
        fontSize: AppSize.s14,
      ),
      enableFeedback: true,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      color: ColorManager.white,
      elevation: AppSize.s0,
      toolbarHeight: AppSize.s70,
      shadowColor: ColorManager.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: ColorManager.white,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorManager.white,
        systemNavigationBarDividerColor: ColorManager.white,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.primary,
      ),
      actionsIconTheme: const IconThemeData(
        color: ColorManager.primary,
      ),
      iconTheme: const IconThemeData(
        color: ColorManager.primary,
      ),
    ),

    // Bottom Theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s17,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
        ),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      displayLarge: getExtraBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineLarge: getExtraBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary /* fontSize: FontSize.s14*/,
      ),
      bodyLarge: getRegularStyle(color: ColorManager.grey1),
      bodySmall: getRegularStyle(color: ColorManager.grey),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),

      // focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      // focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  );
}
