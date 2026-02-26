import 'package:flutter/material.dart';

enum FieldType {
  password,
  confirmPassword,
  email,
  phone,
  text,
  datepicker,
  country,
  imageUpload,
  dropDown,
  checkBox,
  number,
  switchs,
  amount,
  multiLine,
  selectOptions,
}

@immutable
class CustomFormFieldConfig {
  final String label;
  final bool? enabled;
  final String? hintText;
  final Widget? prefixIcon;
  final FieldType fieldType;
  final TextEditingController? controller;
  final dynamic initialValue;
  final bool? isRequired;
  final VoidCallback? onTap;
  final Function(dynamic)? onFieldSubmitted;
  final bool? isObscure;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final List? options;
  final String id;
  final dynamic rules;
  final Map? updateData;
  final bool? textCapitalization;
  final TextStyle? style;
  final String? maskedInputCountryCode;
  final bool? isLogIn;
  final Color? fieldColor;
  final Widget? suffixIcon;
  final bool? enableCaps;
  final int? maxLines;
  final double? height;
  final double? width;
  final IconData? itemIcon; // Icon for dropdown items

  const CustomFormFieldConfig({
    this.initialValue,
    this.maxLines,
    this.onTap,
    this.height,
    this.width,
    this.itemIcon,
    this.onFieldSubmitted,
    this.isObscure,
    this.onChanged,
    this.onSaved,
    this.options,
    required this.id,
    this.rules,
    this.textCapitalization,
    this.style,
    this.maskedInputCountryCode,
    this.isLogIn = false,
    this.fieldColor,
    this.suffixIcon,
    this.enableCaps = false,
    this.updateData,
    required this.label,
    this.enabled = true,
    this.hintText,
    this.prefixIcon,
    required this.fieldType,
    this.controller,
    this.isRequired = false,
  });

  CustomFormFieldConfig copyWith({
    String? label,
    int? maxLine,
    double? height,
    double? width,
    IconData? itemIcon,
    bool? enabled,
    String? hintText,
    Widget? prefixIcon,
    FieldType? fieldType,
    TextEditingController? controller,
    dynamic initialValue,
    bool? isRequired,
    VoidCallback? onTap,
    Function(dynamic)? onFieldSubmitted,
    bool? isObscure,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    List? options,
    String? id,
    dynamic rules,
    Map? updateData,
    bool? textCapitalization,
    TextStyle? style,
    String? maskedInputCountryCode,
    bool? isLoggedIn,
    Color? fieldColor,
    Widget? suffixIcon,
    bool? enableCaps,
  }) {
    return CustomFormFieldConfig(
      initialValue: initialValue ?? this.initialValue,
      onTap: onTap ?? this.onTap,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      isObscure: isObscure ?? this.isObscure,
      onChanged: onChanged ?? this.onChanged,
      onSaved: onSaved ?? this.onSaved,
      options: options ?? this.options,
      id: id ?? this.id,
      rules: rules ?? this.rules,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      style: style ?? this.style,
      maskedInputCountryCode:
          maskedInputCountryCode ?? this.maskedInputCountryCode,
      isLogIn: isLogIn ?? isLogIn,
      fieldColor: fieldColor ?? this.fieldColor,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      enableCaps: enableCaps ?? this.enableCaps,
      updateData: updateData ?? this.updateData,
      label: label ?? this.label,
      maxLines: maxLine ?? maxLines,
      height: height ?? this.height,
      width: width ?? this.width,
      itemIcon: itemIcon ?? this.itemIcon,
      enabled: enabled ?? this.enabled,
      hintText: hintText ?? this.hintText,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      fieldType: fieldType ?? this.fieldType,
      controller: controller ?? this.controller,
      isRequired: isRequired ?? this.isRequired,
    );
  }
}
