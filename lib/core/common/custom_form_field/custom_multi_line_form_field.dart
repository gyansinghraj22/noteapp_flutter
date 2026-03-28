import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/core/utils/form_field/decoration.dart';

class CustomMultiLineFormField extends StatefulWidget {
  final Function(dynamic)? onFieldSubmitted;
  final CustomFormFieldConfig config;

  const CustomMultiLineFormField({
    super.key,
    required this.config,
    this.onFieldSubmitted,
  });

  @override
  State<CustomMultiLineFormField> createState() =>
      _CustomMultiLineFormFieldState();
}

class _CustomMultiLineFormFieldState extends State<CustomMultiLineFormField> {
  late TextEditingController _controller;
  int _characterCount = 0;
  static const int maxLength = 1000;

  @override
  void initState() {
    super.initState();
    _controller = widget.config.controller ?? TextEditingController();
    _controller.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    if (widget.config.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.config.width ?? double.infinity,
      height: widget.config.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              widget.config.label,
              style: context.textBlackStyle().bold.medium,
            ),
          ),
          TextFormField(
            style:
                context
                    .textStyle(palette: ColorPalete.slate, swatch: 700)
                    .large
                    .regular,
            controller: _controller,
            maxLines: widget.config.maxLines,
            maxLength: maxLength,
            validator: ((value) {
              if (widget.config.isRequired == true) {
                return "${widget.config.label} can not be empty";
              }
              return null;
            }),
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              focusedBorder: FormFieldDecoration.getFocusedBorder(context),
              border: FormFieldDecoration.getBoarder(),
              filled: true,
              // labelText:
              //     "${widget.config.label}${widget.config.isRequired ?? false ? " * " : ""}",
              labelStyle:
                  context
                      .textStyle(palette: ColorPalete.brand, swatch: 700)
                      .medium
                      .semiBold,
              // hintText: widget.config.hintText ?? '',
              hintStyle: TextStyle(color: Colors.grey[400]),
              contentPadding: const EdgeInsets.all(16),
              focusColor: AppColor.whiteColor,
              counterText: '', // Hide default counter
            ),
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus();
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(value);
              }
              if (widget.config.onFieldSubmitted != null) {
                widget.config.onFieldSubmitted!(value);
              }
              // if (widget.config.onFieldSubmitted != null &&
              //     value.isNotEmpty) {
              //   widget.config.onFieldSubmitted!(value);
              // }
            },
            onChanged: (value) {
              if (widget.config.onChanged != null) {
                widget.config.onChanged!(value);
              }
            },
          ),
          const SizedBox(height: 4),
          Text(
            '$_characterCount/$maxLength',
            style: TextStyle(
              color:
                  _characterCount >= maxLength ? Colors.red : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
