import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  String savedEmail = '';
  List<CustomFormFieldConfig> formFields = [];

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  getInitialData() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "title",
        label: "Title",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.multiLine,
        id: "content",
        label: "Note Body",
        maxLines: 20,
      ),
      const CustomFormFieldConfig(
        id: "tags",
        label: "Tags",
        fieldType: FieldType.dropDown,
        options: [
          {"label": "work", "value": "Work", "icon": Icons.work},
          {"label": "personal", "value": "Personal", "icon": Icons.person},
          {"label": "ideas", "value": "Ideas", "icon": Icons.light_mode},
          {"label": "to-do", "value": "To-Do", "icon": Icons.check_box},
          {"label": "other", "value": "Other", "icon": Icons.label},
        ],
        isRequired: false,
      ),
    ];
  }

  void _saveDraft() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement save draft functionality
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Draft saved successfully')));
    }
  }

  void _createNote() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement create note functionality
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note created successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text(
        "Create New Note",
        style: context.textBlackStyle().bold.large,
      ),
      trailing: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Save Draft",
              style: context.textStyle(
                palette: ColorPalete.clinicCloud,
                swatch: 900,
              ),
            ),
          ),
        ),
      ],

      centerTitle: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormFieldGenerator(
                        onFieldSubmitted: (data) {
                          formData = data;
                          setState(() {});
                        },
                        formKey: _formKey,
                        formFields: formFields,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Attachments",
                        style: context.textBlackStyle().bold.medium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonWithIcon(
                              color: AppColor.greyColor,

                              leadingIcon: Icons.attach_file,
                              label: "Add Image",
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButtonWithIcon(
                              color: AppColor.greyColor,

                              leadingIcon: Icons.attach_file,

                              label: "Add Pdf File",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CustomBorderButton(
                      label: "Cancel",
                      onPressed: _createNote,
                      width: 80.w,
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: CustomButtonWithIcon(
                        label: "Create Note",
                        onPressed: _createNote,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
