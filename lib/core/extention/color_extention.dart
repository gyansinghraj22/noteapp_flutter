import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';

extension MaterialColorExtensions on BuildContext {
  //color
  Color applyAppColor({required MaterialColor palette, int swatch = 500}) =>
      palette[swatch] ?? AppColor.appThemeColor;

  /// Creates a TextStyle with a color from the specified palette and swatch value.
  TextStyle textStyle({required MaterialColor palette, int swatch = 500}) =>
      TextStyle(color: applyAppColor(palette: palette, swatch: swatch));
  TextStyle textBlackStyle() => const TextStyle(color: AppColor.blackColor);
}
