import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_fonts.dart';

extension FontFamilyExtensions on TextStyle {
  TextStyle get withBaloo2 => copyWith(fontFamily: AppFonts.baloo2);
  TextStyle get withSatoshi => copyWith(fontFamily: AppFonts.satoshi);
}
