import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_form_field/cuatom_form_field.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_tile.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_view_builder.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/core/utils/form_field/decoration.dart';
import 'package:noteapp/core/utils/form_field/validators.dart';

class CustomDropDownFormField extends StatefulWidget {
  final CustomFormFieldConfig config;
  final Function(dynamic)? onFieldSubmitted;

  const CustomDropDownFormField({
    super.key,
    required this.config,
    this.onFieldSubmitted,
  });

  @override
  State<CustomDropDownFormField> createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  TextEditingController searchController = TextEditingController();
  List allOptions = [];

  @override
  void initState() {
    allOptions = widget.config.options ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildDropDownForm();
  }

  buildDropDownForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: widget.config.onChanged ?? widget.config.onFieldSubmitted,
          onSaved: widget.config.onSaved ?? widget.config.onFieldSubmitted,
          readOnly: true,
          enabled: widget.config.enabled,
          validator: ((value) {
            return FormValidator.checkValidation(
              isLogIn: widget.config.isLogIn ?? false,
              isRequired: widget.config.isRequired ?? false,
              value: value ?? "",
              fieldType: widget.config.fieldType,
              label: widget.config.label,
            );
          }),
          controller: widget.config.controller,
          decoration: InputDecoration(
            focusedBorder: FormFieldDecoration.getFocusedBorder(context),
            border: FormFieldDecoration.getBorder(),
            fillColor: Colors.grey.shade100,
            filled: true,
            labelText:
                "${widget.config.label}${widget.config.isRequired ?? false ? " * " : ""}",
            labelStyle: context.textBlackStyle().medium.semiBold.copyWith(
              color: const Color(0xFF7C7C7C),
            ),
            suffixIcon:
                widget.config.controller!.text.isEmpty
                    ? const Icon(Icons.arrow_drop_down)
                    : widget.config.enabled == true
                    ? GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.config.controller?.clear();

                          widget.config.onFieldSubmitted!.call("");
                        });
                      },
                      child: const Icon(Icons.close, size: 18),
                    )
                    : null,
            hintText: widget.config.hintText,
          ),
          onTap: () {
            onTabFunction();
          },
        ),
      ],
    );
  }

  onTabFunction() {
    setState(() {
      allOptions = widget.config.options ?? [];
      searchController.clear();
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => StatefulBuilder(
            builder: (context, setModalState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: widget.config.options!.length > 10,
                            child: Expanded(
                              child: CustomFormField(
                                config: CustomFormFieldConfig(
                                  fieldType: FieldType.text,
                                  controller: searchController,
                                  id: "Search",
                                  label: "Search",
                                  onChanged: (val) {
                                    setModalState(() {
                                      if (val.isEmpty) {
                                        allOptions =
                                            widget.config.options ?? [];
                                      } else {
                                        final normalizedQuery = val.replaceAll(
                                          ' ',
                                          '',
                                        );
                                        allOptions =
                                            allOptions.where((e) {
                                              final title = e["label"] ?? '';
                                              final normalizedTitle = title
                                                  .replaceAll(' ', '');
                                              return normalizedTitle.contains(
                                                normalizedQuery,
                                              );
                                            }).toList();
                                      }
                                    });
                                  },
                                  isRequired: false,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 16,
                                      left: 16,
                                    ),
                                    child: iconoir.Search(
                                      color: context.applyAppColor(
                                        palette: ColorPalete.brand,
                                        swatch: 700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  context
                                      .textStyle(
                                        palette: ColorPalete.slate,
                                        swatch: 700,
                                      )
                                      .medium
                                      .semiBold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child:
                            allOptions.isNotEmpty
                                ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: allOptions.length,
                                  itemBuilder: (context, index) {
                                    return CustomCard(
                                      cardHeight: 50,
                                      child: CustomListTile(
                                        onPress: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            widget.config.controller!.text =
                                                allOptions[index]["label"];
                                            if (widget
                                                    .config
                                                    .onFieldSubmitted !=
                                                null) {
                                              widget.config.onFieldSubmitted!
                                                  .call(
                                                    allOptions[index]["value"],
                                                  );
                                            }
                                          });
                                        },
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${allOptions[index]['label']}",
                                            style:
                                                context
                                                    .textStyle(
                                                      palette:
                                                          ColorPalete.slate,
                                                      swatch: 700,
                                                    )
                                                    .medium
                                                    .semiBold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                                : Center(
                                  child: Text(
                                    "No Data Found",
                                    style:
                                        context
                                            .textStyle(
                                              palette: ColorPalete.slate,
                                              swatch: 700,
                                            )
                                            .large
                                            .semiBold,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  // void filterSearchResults(String query) {
  //   setState(() {
  //     allOptions = widget.config.options!
  //         .where((e) =>
  //             e["label"].toLowerCase().replaceAll(' ', '').contains(query))
  //         .toList();
  //   });
  // }
}
