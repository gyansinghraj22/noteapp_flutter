import 'package:flutter/material.dart';
import 'package:noteapp/constants/font_size.dart';
import 'package:noteapp/constants/font_weight.dart';

extension AppTextStyleExtension on TextStyle {
  //font weight
  TextStyle get bold => copyWith(fontWeight: AppFontWeight.bold);
  TextStyle get semiBold => copyWith(fontWeight: AppFontWeight.semiBold);
  TextStyle get regular => copyWith(fontWeight: AppFontWeight.regular);
  TextStyle get light => copyWith(fontWeight: AppFontWeight.light);

  //font size
  TextStyle get header1 =>
      copyWith(fontSize: FontSize.header1, fontWeight: AppFontWeight.bold);
  TextStyle get header2 =>
      copyWith(fontSize: FontSize.header2, fontWeight: AppFontWeight.bold);
  TextStyle get header3 =>
      copyWith(fontSize: FontSize.header3, fontWeight: AppFontWeight.bold);
  TextStyle get header4 =>
      copyWith(fontSize: FontSize.header4, fontWeight: AppFontWeight.bold);
  TextStyle get header5 =>
      copyWith(fontSize: FontSize.header5, fontWeight: AppFontWeight.bold);
  TextStyle get header6 =>
      copyWith(fontSize: FontSize.header6, fontWeight: AppFontWeight.bold);

  //font size
  TextStyle get newheader1 =>
      copyWith(fontSize: FontSize.newheader1, fontWeight: AppFontWeight.bold);
  TextStyle get newheader2 =>
      copyWith(fontSize: FontSize.newheader2, fontWeight: AppFontWeight.bold);
  TextStyle get newheader3 =>
      copyWith(fontSize: FontSize.newheader3, fontWeight: AppFontWeight.bold);
  TextStyle get newheader4 =>
      copyWith(fontSize: FontSize.newheader4, fontWeight: AppFontWeight.bold);
  TextStyle get newheader5 =>
      copyWith(fontSize: FontSize.newheader5, fontWeight: AppFontWeight.bold);
  TextStyle get newheader6 =>
      copyWith(fontSize: FontSize.newheader6, fontWeight: AppFontWeight.bold);

  TextStyle get xlarge => copyWith(fontSize: FontSize.xlarge);
  TextStyle get large => copyWith(fontSize: FontSize.large);
  TextStyle get medium => copyWith(fontSize: FontSize.medium);
  TextStyle get small => copyWith(fontSize: FontSize.small);
  TextStyle get xsmall => copyWith(fontSize: FontSize.xsmall);

  //body text
  TextStyle get extraLarge => copyWith(fontSize: FontSize.extraLarge);
  TextStyle get largeBody => copyWith(fontSize: FontSize.largeBody);
  TextStyle get baseBody => copyWith(fontSize: FontSize.baseBody);
  TextStyle get base => copyWith(fontSize: FontSize.baseBody);
  TextStyle get smallBody => copyWith(fontSize: FontSize.smallBody);
  TextStyle get footNoteLarge => copyWith(fontSize: FontSize.footNoteLarge);
  TextStyle get footNote => copyWith(fontSize: FontSize.footNote);
  TextStyle get labelCap => copyWith(fontSize: FontSize.labelCap);
}
