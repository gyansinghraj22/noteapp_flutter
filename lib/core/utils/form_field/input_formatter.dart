import 'package:flutter/services.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';

class InputFormatter {
  static formFieldInputFormatters(FieldType fieldType) {
    if (fieldType == FieldType.phone || fieldType == FieldType.number) {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ];
    } else if (fieldType == FieldType.amount) {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'^([0]|[1-9]\d*)(\.\d{0,2}(?:[1-9]\d*)?)?$'),
        ),
      ];
    } else if (fieldType == FieldType.email ||
        fieldType == FieldType.password) {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ];
    } else {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^[^\s].*')),
      ];
    }
  }
}
