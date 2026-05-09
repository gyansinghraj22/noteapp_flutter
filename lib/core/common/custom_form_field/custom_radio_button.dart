import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/core/utils/form_field/validators.dart';

class CustomRadioButtonFormField extends StatefulWidget {
  final CustomFormFieldConfig config;

  const CustomRadioButtonFormField({super.key, required this.config});

  @override
  State<CustomRadioButtonFormField> createState() =>
      _CustomRadioButtonFormFieldState();
}

class _CustomRadioButtonFormFieldState
    extends State<CustomRadioButtonFormField> {
  dynamic _selectedValue;

  List get _options => widget.config.options ?? const [];

  @override
  void initState() {
    super.initState();

    // Initialize from initialValue or controller text if provided
    if (widget.config.initialValue != null) {
      _selectedValue = widget.config.initialValue;
    } else if (widget.config.controller != null &&
        widget.config.controller!.text.isNotEmpty) {
      // Try to match controller text to an option label
      final match = _options.firstWhere(
        (e) => e is Map && e['label'] == widget.config.controller!.text,
        orElse: () => null,
      );
      if (match != null && match is Map) {
        _selectedValue = match['value'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            "${widget.config.label}${widget.config.isRequired ?? false ? " * " : ""}",
            style: context.textBlackStyle().bold.medium.copyWith(
              color: ColorPalete.brightSky[700],
            ),
          ),
        ),
        SizedBox(height: 8.h),

        FormField<dynamic>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (_) {
            return FormValidator.checkValidation(
              isLogIn: widget.config.isLogIn ?? false,
              isRequired: widget.config.isRequired ?? false,
              value: (_selectedValue ?? '').toString(),
              fieldType: widget.config.fieldType,
              label: widget.config.label,
            );
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._options.map<Widget>((option) {
                  if (option is! Map) return const SizedBox.shrink();
                  final value = option['value'];
                  final label = option['label']?.toString() ?? '';

                  return RadioListTile<dynamic>(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: value,
                    groupValue: _selectedValue,
                    onChanged: (val) {
                      setState(() {
                        _selectedValue = val;
                      });

                      // Keep controller in sync (store label for display)
                      if (widget.config.controller != null) {
                        widget.config.controller!.text = label;
                      }

                      // Notify listener with raw value
                      if (widget.config.onFieldSubmitted != null) {
                        widget.config.onFieldSubmitted!(val);
                      }

                      field.didChange(val);
                    },
                    title: Text(
                      label,
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.slate,
                                swatch: 700,
                              )
                              .medium
                              .regular,
                    ),
                  );
                }).toList(),

                if (field.errorText != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 4.w),
                    child: Text(
                      field.errorText!,
                      style: TextStyle(color: Colors.red, fontSize: 11.sp),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
