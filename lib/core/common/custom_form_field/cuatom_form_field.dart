import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_form_field/custom_drop_down.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_image_picker.dart';
import 'package:noteapp/core/common/custom_form_field/custom_multi_line_form_field.dart';
import 'package:noteapp/core/common/custom_form_field/custom_switch.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/core/utils/form_field/decoration.dart';
import 'package:noteapp/core/utils/form_field/input_formatter.dart';
import 'package:noteapp/core/utils/form_field/keyboard_selector.dart';
import 'package:noteapp/core/utils/form_field/validators.dart';

class CustomFormField extends StatefulWidget {
  final Function(dynamic)? onFieldSubmitted;
  final CustomFormFieldConfig config;
  const CustomFormField({
    super.key,
    required this.config,
    this.onFieldSubmitted,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isHidden = true;

  @override
  void initState() {
    isHidden = widget.config.isObscure ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.config.fieldType) {
      case FieldType.text:
        return textFieldWidget();
      case FieldType.multiLine:
        return CustomMultiLineFormField(config: widget.config);
      case FieldType.password:
        return textFieldWidget();
      case FieldType.confirmPassword:
        return textFieldWidget();
      case FieldType.switchs:
        return CustomSwitchFormField(config: widget.config);
      case FieldType.dropDown:
        if (widget.config.options == null) {
          return textFieldWidget();
        } else {
          return CustomDropDownFormField(
            onFieldSubmitted: widget.onFieldSubmitted,
            config: widget.config,
          );
        }
      case FieldType.imageUpload:
        return CustomImagePickerFormField(config: widget.config);
      case FieldType.number:
        return textFieldWidget();
      default:
        return textFieldWidget();
    }
  }

  textFieldWidget() {
    int maxLength = 50;
    if (widget.config.id == 'memberCode') maxLength = 10;
    if (widget.config.fieldType == FieldType.phone) maxLength = 16;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.config.label,
            style: context.textBlackStyle().bold.medium,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          style:
              context
                  .textStyle(palette: ColorPalete.slate, swatch: 700)
                  .large
                  .regular,
          textCapitalization:
              widget.config.enableCaps == true
                  ? TextCapitalization.characters
                  : TextCapitalization.none,
          maxLength: maxLength,
          enabled: widget.config.enabled,
          onChanged: widget.config.onChanged ?? widget.config.onFieldSubmitted,
          onFieldSubmitted: (value) {
            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted!(value);
            }
            if (widget.config.onFieldSubmitted != null) {
              widget.config.onFieldSubmitted!(value);
            }
          },
          onSaved: widget.config.onSaved ?? widget.config.onFieldSubmitted,
          validator: (value) {
            return FormValidator.checkValidation(
              isLogIn: widget.config.isLogIn ?? false,
              isRequired: widget.config.isRequired ?? false,
              value: value ?? "",
              fieldType: widget.config.fieldType,
              label: widget.config.label,
            );
          },
          inputFormatters: InputFormatter.formFieldInputFormatters(
            widget.config.fieldType,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.config.controller!,
          // ..selection = TextSelection.fromPosition(
          //     TextPosition(offset: widget.config.controller!.text.length)),
          obscureText:
              widget.config.fieldType == FieldType.password ||
                      widget.config.fieldType == FieldType.confirmPassword
                  ? isHidden
                  : false,
          keyboardType: KeyboardSelector.keyboardType(widget.config.fieldType),
          readOnly: widget.config.fieldType == FieldType.country ? true : false,
          decoration: InputDecoration(
            counterText: "",
            suffixIcon:
                widget.config.fieldType == FieldType.password ||
                        widget.config.fieldType == FieldType.confirmPassword
                    ? IconButton(
                      icon: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isHidden = isHidden ? false : true;
                        });
                      },
                    )
                    : widget.config.suffixIcon,
            focusedBorder: FormFieldDecoration.getFocusedBorder(context),
            border: FormFieldDecoration.getBorder(),
            fillColor: AppColor.greyColor.withAlpha(20),
            filled: true,
            focusColor: widget.config.style == null ? null : Colors.white,
            prefixIcon: widget.config.prefixIcon,
            hintText: widget.config.hintText,
            labelText:
                "${widget.config.label}${widget.config.isRequired ?? false ? " * " : ""}",
            labelStyle: context.textBlackStyle().medium.regular.copyWith(
              color: AppColor.greyColor.withAlpha(254),
            ),
          ),
        ),
      ],
    );
  }
}
