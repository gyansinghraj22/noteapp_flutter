import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';

class FormValidator {
  static checkValidation({
    required String value,
    required bool isRequired,
    required bool isLogIn,
    required FieldType fieldType,
    required String label,
  }) {
    if (isRequired) {
      if (value.isEmpty) {
        return "$label is required";
      } else if (fieldType == FieldType.email) {
        if (!validateEmail(value)) {
          return 'Enter valid email address';
        }
      } else if (fieldType == FieldType.phone) {
        if (value.length < 11) {
          return 'Enter valid phone number';
        }
      } else if (fieldType == FieldType.password) {
        if (!isValidPassword(value) && !isLogIn) {
          return 'Password must be at least 8 characters long,\nwith at least 1 uppercase, and 1 number.';
        }
      }
    } else {
      return null;
    }
  }

  static bool isValidPassword(String password) {
    final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return regex.hasMatch(password);
  }

  static validateEmail(String email) {
    if (RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email)) {
      return true;
    }
    return false;
  }
}
