import 'package:flutter/material.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';

class CustomSwitchFormField extends StatefulWidget {
  final CustomFormFieldConfig config;
  const CustomSwitchFormField({super.key, required this.config});

  @override
  State<CustomSwitchFormField> createState() => _CustomSwitchFormFieldState();
}

class _CustomSwitchFormFieldState extends State<CustomSwitchFormField> {
  bool switchStatus = false;
  @override
  Widget build(BuildContext context) {
    return Switch(value: switchStatus, onChanged: toggleSwitch);
  }

  void toggleSwitch(bool value) {
    if (switchStatus == false) {
      setState(() {
        switchStatus = true;
        widget.config.controller!.text == 1;
        widget.config.onFieldSubmitted!.call(1);
      });
    } else {
      setState(() {
        switchStatus = false;
        widget.config.controller!.text == 0;
        widget.config.onFieldSubmitted!.call(0);
      });
    }
  }
}
