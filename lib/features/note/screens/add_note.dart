import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
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
        maxLines: 10 
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text("Create New Note"),

      centerTitle: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomFormFieldGenerator(
                onFieldSubmitted: (data) {
                  formData = data;
                  setState(() {});
                },
                formKey: _formKey,
                formFields: formFields,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
