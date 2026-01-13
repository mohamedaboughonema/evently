import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.primaryBlue,
        shape: StadiumBorder(
          side: BorderSide(color: AppColor.white, width: 4),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        selectedLabelStyle: AppTextStyle.bold12White,
        unselectedLabelStyle: AppTextStyle.bold12White,
      ),
      primaryColor: AppColor.primaryBlue,
      indicatorColor: AppColor.white,
      secondaryHeaderColor: AppColor.blue,
      scaffoldBackgroundColor: AppColor.white,
      primaryColorDark: AppColor.black,
      primaryColorLight: AppColor.grey,
      hintColor: AppColor.grey,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: AppTextStyle.medium20Primary,
          backgroundColor: Colors.white,
          foregroundColor: AppColor.primaryBlue,
          iconTheme: IconThemeData(color: AppColor.primaryBlue)));

  static ThemeData darkTheme = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.darkBlue,
        shape: StadiumBorder(
          side: BorderSide(color: AppColor.white, width: 4),
        ),
        // RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(100),
        //     side: BorderSide(color: AppColor.white, width: 4))
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        selectedLabelStyle: AppTextStyle.bold12White,
        unselectedLabelStyle: AppTextStyle.bold12White,
      ),
      // scaffoldBackgroundColor: AppColor.darkBlue,
      primaryColor: AppColor.darkBlue,
      indicatorColor: AppColor.blue,
      secondaryHeaderColor: AppColor.white,
      scaffoldBackgroundColor: AppColor.darkBlue,
      primaryColorDark: AppColor.white,
      primaryColorLight: AppColor.primaryBlue,
      hintColor: AppColor.white,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: AppTextStyle.medium20Primary,
          backgroundColor: AppColor.darkBlue,
          foregroundColor: AppColor.primaryBlue,
          iconTheme: IconThemeData(color: AppColor.primaryBlue)));
}
