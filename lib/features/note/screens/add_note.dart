import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/features/note/bloc/note_bloc.dart';
import 'package:noteapp/features/tags/bloc/tag_bloc.dart';

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
    super.initState();
    getInitialData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TagBloc>().add(TagGetEvent());
      }
    });
  }

  void getInitialData() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: 'title',
        label: 'Title',
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.multiLine,
        id: 'content',
        label: 'Note Body',
        maxLines: 20,
      ),
    ];
  }

  List<String> _extractTags(dynamic response) {
    final rawTags =
        response is List
            ? response
            : response is Map<String, dynamic>
            ? response['data'] ??
                response['tags'] ??
                response['items'] ??
                response['results']
            : const [];

    if (rawTags is! List) {
      return [];
    }

    return rawTags
        .map((tag) {
          if (tag is String) {
            return tag;
          }

          if (tag is Map<String, dynamic>) {
            return (tag['name'] ?? tag['title'] ?? tag['tag'] ?? tag['label'])
                    ?.toString() ??
                '';
          }

          return '';
        })
        .where((tag) => tag.isNotEmpty)
        .toSet()
        .toList();
  }

  List<Map<String, dynamic>> _tagOptions(List<String> tags) {
    return tags
        .map((tag) => {'label': tag, 'value': tag, 'icon': Icons.label})
        .toList();
  }

  void _createNote() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    context.read<NoteBloc>().add(NoteCreateEvent(formData: formData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, noteState) {
        if (noteState is NoteCreateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note created successfully')),
          );
          Navigator.pop(context, true);
        } else if (noteState is NoteCreateErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                noteState.errorModel.message ?? 'Failed to create note',
              ),
            ),
          );
        }
      },
      builder: (context, noteState) {
        final isCreating = noteState is NoteLoadingState;

        return BlocBuilder<TagBloc, TagState>(
          builder: (context, tagState) {
            final tags =
                tagState is TagGetSuccessState
                    ? _extractTags(tagState.response)
                    : const <String>[];
            final fields = [
              ...formFields,
              CustomFormFieldConfig(
                id: 'tags',
                label: 'Tags',
                fieldType: FieldType.dropDown,
                options: _tagOptions(tags),
                isRequired: false,
              ),
            ];

            return BasePage(
              showAppBar: true,
              title: Text(
                'Create New Note',
                style: context.textBlackStyle().bold.large,
              ),
              trailing: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Save Draft',
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
                      if (tagState is TagLoadingState && tags.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: LinearProgressIndicator(minHeight: 2),
                        ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomFormFieldGenerator(
                                onFieldSubmitted: (data) {
                                  formData = data ?? {};
                                  setState(() {});
                                },
                                formKey: _formKey,
                                formFields: fields,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Attachments',
                                style: context.textBlackStyle().bold.medium,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButtonWithIcon(
                                      color: AppColor.greyColor,
                                      leadingIcon: Icons.attach_file,
                                      label: 'Add Image',
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomButtonWithIcon(
                                      color: AppColor.greyColor,
                                      leadingIcon: Icons.attach_file,
                                      label: 'Add Pdf File',
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
                              label: 'Cancel',
                              onPressed:
                                  isCreating
                                      ? null
                                      : () => Navigator.pop(context),
                              width: 80.w,
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: CustomButtonWithIcon(
                                label:
                                    isCreating ? 'Creating...' : 'Create Note',
                                onPressed: isCreating ? null : _createNote,
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
          },
        );
      },
    );
  }
}
