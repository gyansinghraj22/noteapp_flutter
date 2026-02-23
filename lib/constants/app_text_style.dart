import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_fonts.dart';
import 'package:noteapp/constants/font_size.dart';
import 'package:noteapp/constants/font_weight.dart';

class AppTextStyle {
  //heading
  static TextStyle header1 = TextStyle(
    fontSize: FontSize.header1,
    height: FontHeight.header1,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.baloo2,
  );

  static TextStyle header2 = TextStyle(
    fontSize: FontSize.header2,
    height: FontHeight.header2,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.baloo2,
  );

  static TextStyle header3 = TextStyle(
    fontSize: FontSize.header3,
    height: FontHeight.header3,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.baloo2,
  );

  static TextStyle header4 = TextStyle(
    fontSize: FontSize.header4,
    height: FontHeight.header4,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.baloo2,
  );

  static TextStyle header5 = TextStyle(
    fontSize: FontSize.header5,
    height: FontHeight.header5,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.baloo2,
  );

  static TextStyle header6 = TextStyle(
    fontSize: FontSize.header6,
    height: FontHeight.header6,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.baloo2,
  );

  //body
  static TextStyle body = TextStyle(
    fontSize: FontSize.large,
    height: FontHeight.large,
    letterSpacing: FontSpecing.large,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.satoshi,
  );

  static TextStyle newBody = TextStyle(
    fontSize: FontSize.largeBody,
    // height: FontHeight.large,
    letterSpacing: FontSpecing.large,
    color: AppColor.appThemeColor,
    fontWeight: AppFontWeight.bold,
    fontFamily: AppFonts.satoshi,
  );
}
