import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Map<String, dynamic>? noteData;

  const UpdateNoteScreen({super.key, this.noteData});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  List<CustomFormFieldConfig> formFields = [];
  List<Map<String, dynamic>> attachments = [
    {
      'name': 'Contract_Draft.pdf',
      'type': 'pdf',
      'icon': Icons.picture_as_pdf,
      'color': Colors.red,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
  }

  void _initializeFormFields() {
    formFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "title",
        label: "Note Title",
        controller: TextEditingController(
          text: widget.noteData?["title"] ?? "Q4 Project Requirements",
        ),
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.multiLine,
        id: "content",
        label: "Note Content",
        maxLines: 15,
        controller: TextEditingController(
          text:
              widget.noteData?["content"] ??
              "The primary objective for the Q4 sprint is to finalize the core architecture for the cross-platform synchronization engine.\n\nKey deliverables include:\n• End-to-end encryption for all user notes\n• Offline-first support for mobile clients\n• Real-time collaborative editing using CRDTs\n\nWe need to review the attached contract for the cloud storage provider and ensure it meets our data residency requirements",
        ),
      ),
      CustomFormFieldConfig(
        id: "tags",
        label: "Category",
        fieldType: FieldType.dropDown,
        controller: TextEditingController(
          text: widget.noteData?["category"] ?? "Work",
        ),
        options: [
          {"label": "Work", "value": "Work", "icon": Icons.work},
          {"label": "Personal", "value": "Personal", "icon": Icons.person},
          {"label": "Ideas", "value": "Ideas", "icon": Icons.lightbulb},
          {"label": "To-Do", "value": "To-Do", "icon": Icons.check_box},
          {"label": "Other", "value": "Other", "icon": Icons.label},
        ],
        isRequired: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Note Detail",
          style: context.textStyle(palette: ColorPalete.white).large.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.pin_drop, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Last Modified Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Text(
                "Modified on 2 | 10:45 AM",
                style:
                    context
                        .textStyle(palette: ColorPalete.slate, swatch: 400)
                        .small,
                textAlign: TextAlign.center,
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form Fields
                    CustomFormFieldGenerator(
                      onFieldSubmitted: (data) {
                        formData = data;
                        setState(() {});
                      },
                      formKey: _formKey,
                      formFields: formFields,
                    ),

                    const SizedBox(height: 24),

                    // Attachments Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Attachments",
                          style:
                              context
                                  .textStyle(palette: ColorPalete.white)
                                  .medium
                                  .bold,
                        ),
                        TextButton(
                          onPressed: _showAttachmentOptions,
                          child: Text(
                            "Add New",
                            style:
                                context
                                    .textStyle(palette: ColorPalete.brand)
                                    .medium
                                    .semiBold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Attachments List
                    ...attachments.map(
                      (attachment) => _buildAttachmentItem(attachment),
                    ),

                    const SizedBox(height: 24),

                    // Add Attachment Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildDottedButton(
                            label: "Add Image",
                            icon: Icons.add_a_photo,
                            onPressed: _addImage,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDottedButton(
                            label: "Add File",
                            icon: Icons.attach_file,
                            onPressed: _addFile,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Toolbar
            _buildBottomToolbar(),
          ],
        ),
      ),
    );
  }

  Widget _buildDottedButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.brightSkyMain,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20, color: AppColor.brightSkyMain),
                const SizedBox(width: 8),
                Text(
                  label,
                  style:
                      context
                          .textStyle(palette: ColorPalete.brand, swatch: 700)
                          .medium
                          .semiBold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentItem(Map<String, dynamic> attachment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: attachment['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              attachment['icon'],
              color: attachment['color'],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment['name'],
                  style:
                      context
                          .textStyle(palette: ColorPalete.white)
                          .medium
                          .semiBold,
                ),
                Text(
                  attachment['type'].toUpperCase(),
                  style:
                      context
                          .textStyle(palette: ColorPalete.slate, swatch: 400)
                          .small,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey, size: 18),
            onPressed: () {
              setState(() {
                attachments.remove(attachment);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomToolbar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Expanded(
        child: Row(
          children: [
            _buildToolbarButton(Icons.format_bold, false),
            _buildToolbarButton(Icons.format_italic, false),
            _buildToolbarButton(Icons.format_underlined, false),
            _buildToolbarButton(Icons.format_list_bulleted, false),
            _buildToolbarButton(Icons.format_list_numbered, false),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.brightSkyMain.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "Auto-saved 2 minutes ago",
                style:
                    context
                        .textStyle(palette: ColorPalete.slate, swatch: 400)
                        .small,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarButton(IconData icon, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? AppColor.brightSkyMain : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Attachment",
                  style:
                      context.textStyle(palette: ColorPalete.white).large.bold,
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.blue),
                  title: const Text(
                    "Take Photo",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _addImage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.green),
                  title: const Text(
                    "Photo Library",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _addImage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.attach_file, color: Colors.orange),
                  title: const Text(
                    "File",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _addFile();
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _addImage() {
    // TODO: Implement image picker
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Image picker functionality')));
  }

  void _addFile() {
    // TODO: Implement file picker
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('File picker functionality')));
  }
}
