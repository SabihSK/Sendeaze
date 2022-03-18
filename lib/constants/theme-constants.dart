import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendeaze/constants/color-constants.dart';

class AppTheme {
  static final ThemeData coreTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    primaryColor: AppColors.BACKGROUND_DARK,
    accentColor: AppColors.PRIMARY_ACCENT,
    backgroundColor: AppColors.BACKGROUND_DARK,
    scaffoldBackgroundColor: AppColors.WHITE,
    fontFamily: 'Montserrat',
    unselectedWidgetColor: AppColors.GREY,
    iconTheme: IconThemeData(
      color: AppColors.PRIMARY,
    ),
    textTheme: TextTheme(
      // subtitle1: Get.textTheme.subtitle1!.copyWith(color: Colors.white),
      // subtitle2: Get.textTheme.subtitle2!.copyWith(color: Colors.white),
      // bodyText1: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
      // bodyText2: Get.textTheme.bodyText2!.copyWith(color: Colors.white),
      // caption: Get.textTheme.caption!.copyWith(color: Colors.white),
      button: Get.textTheme.button!.copyWith(fontWeight: FontWeight.bold),
      // overline: Get.textTheme.overline!.copyWith(color: Colors.white),
      headline6: Get.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
      // headline5: Get.textTheme.headline5!.copyWith(color: Colors.white),
      // headline4: Get.textTheme.headline4!.copyWith(color: Colors.white),
      // headline3: Get.textTheme.headline3!.copyWith(color: Colors.white),
      // headline2: Get.textTheme.headline2!.copyWith(color: Colors.white),
      // headline1: Get.textTheme.headline1!.copyWith(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 6),
        disabledBorder: InputBorder.none,
        isDense: true),
    appBarTheme: Get.theme.appBarTheme
        .copyWith(brightness: Brightness.dark, titleSpacing: 0),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: AppColors.PRIMARY, width: 1)))),
  );
}
