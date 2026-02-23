import 'package:flutter/widgets.dart';
import 'package:noteapp/constants/app_padding.dart';
import 'package:noteapp/core/common/app_single_child_scroll_view/app_single_child_scroll_view.dart';
import 'package:noteapp/core/common/custom_form_field/cuatom_form_field.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';

class CustomFormFieldGenerator extends StatefulWidget {
  final dynamic formKey;
  final List<CustomFormFieldConfig>? formFields;
  final Map? updateData;
  final Function(dynamic)? onFieldSubmitted;

  const CustomFormFieldGenerator({
    super.key,
    required this.formFields,
    this.updateData,
    this.formKey,
    this.onFieldSubmitted,
  });

  @override
  State<CustomFormFieldGenerator> createState() =>
      _CustomFormFieldGeneratorState();
}

class _CustomFormFieldGeneratorState extends State<CustomFormFieldGenerator> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  List<TextEditingController> _controllers = [];
  Map updateData = {};
  Map<String, dynamic> formValues = {};

  void updateFieldValue(String fieldName, String value) {
    if (value.isNotEmpty) {
      formValues[fieldName] = value;
      if (widget.onFieldSubmitted != null) {
        widget.onFieldSubmitted!(formValues);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initializeControllers();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getText(String key) {
    if (widget.updateData == null) {
      return '';
    } else if (widget.updateData!.containsKey(key) &&
        widget.updateData![key] != null) {
      final value = widget.updateData![key];
      return value.toString();
    }
    return '';
  }

  void initializeControllers() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controllers = [];
    formValues.clear();
    for (int i = 0; i < widget.formFields!.length; i++) {
      String fieldId = widget.formFields![i].id;
      String initialValue = getText(fieldId);
      var controller = TextEditingController(text: initialValue);
      formValues[fieldId] = initialValue;

      _controllers.add(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildFormField(updateData, widget.formFields);
  }

  buildFormField(updateData, fields) {
    return AppSingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: widget.formKey ?? _formKey,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.formFields!.length,
              itemBuilder: (BuildContext context, index) {
                String fieldName = widget.formFields![index].id;

                CustomFormFieldConfig config = widget.formFields![index]
                    .copyWith(
                      controller: _controllers[index],
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          updateFieldValue(fieldName, value);
                        } else {
                          updateFieldValue(fieldName, _controllers[index].text);
                        }
                      },
                    );

                return Padding(
                  padding: AppPadding.onlyBottomPading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Padding(
                      //   padding: AppPadding.formFieldLabelPadding,
                      //   child: Wrap(
                      //     children: [
                      //       // Text(widget.formData![index].label),
                      //       // Text(
                      //       //   widget.formData![index].isRequired ?? false
                      //       //       ? ' * '
                      //       //       : '',
                      //       //   style:
                      //       //       widget.formData![index].isRequired ?? false
                      //       //           ? context
                      //       //               .textStyle(
                      //       //                   palette: ColorPalete.slate,
                      //       //                   swatch: 700)
                      //       //               .large
                      //       //               .semiBold
                      //       //           : const TextStyle(
                      //       //               color: AppColor.greyColor,
                      //       //               fontSize: 13),
                      //       // )

                      //     ],
                      //   ),
                      // ),
                      CustomFormField(
                        onFieldSubmitted: (value) {
                          updateFieldValue(widget.formFields![index].id, value);
                        },
                        config: config,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
