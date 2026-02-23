import 'package:flutter/material.dart';
import 'package:noteapp/constants/font_size.dart';

extension AppFontSize on BuildContext {
  double get header1 => FontSize.header1;
  double get header2 => FontSize.header2;
  double get header3 => FontSize.header3;
  double get header4 => FontSize.header4;
  double get header5 => FontSize.header5;
  double get header6 => FontSize.header6;

  double get newheader1 => FontSize.newheader1;
  double get newheader2 => FontSize.newheader2;
  double get newheader3 => FontSize.newheader3;
  double get newheader4 => FontSize.newheader4;
  double get newheader5 => FontSize.newheader5;
  double get newheader6 => FontSize.newheader6;

  double get xlarge => FontSize.xlarge;
  double get large => FontSize.large;
  double get medium => FontSize.medium;
  double get small => FontSize.small;
  double get xsmall => FontSize.xsmall;
}

extension AppFontHeight on BuildContext {
  double get header1 => FontHeight.header1;
  double get header2 => FontHeight.header2;
  double get header3 => FontHeight.header3;
  double get header4 => FontHeight.header4;
  double get header5 => FontHeight.header5;
  double get header6 => FontHeight.header6;

  double get xlarge => FontHeight.xlarge;
  double get large => FontHeight.large;
  double get medium => FontHeight.medium;
  double get small => FontHeight.small;
  double get xsmall => FontHeight.xsmall;
}

extension AppFontSpecing on BuildContext {
  double get xlarge => FontSpecing.xlarge;
  double get large => FontSpecing.large;
  double get medium => FontSpecing.medium;
  double get small => FontSpecing.small;
  double get xsmall => FontSpecing.xsmall;
}
