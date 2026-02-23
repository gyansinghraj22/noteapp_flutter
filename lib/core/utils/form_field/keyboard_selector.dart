import 'package:flutter/material.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';

class KeyboardSelector {
  static TextInputType keyboardType(FieldType fieldType) {
    if (fieldType == FieldType.email) {
      return TextInputType.emailAddress;
    } else if (fieldType == FieldType.amount) {
      return const TextInputType.numberWithOptions(signed: true, decimal: true);
    } else if (fieldType == FieldType.number) {
      return TextInputType.number;
    } else if (fieldType == FieldType.phone) {
      return const TextInputType.numberWithOptions(signed: true);
    } else {
      return TextInputType.text;
    }
  }
}
