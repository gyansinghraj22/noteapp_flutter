import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';

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

  String selectedCategory = "Work";

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
        showLabel: false,
        controller: TextEditingController(
          text: widget.noteData?["title"] ?? "Q4 Project Requirements",
        ),
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.multiLine,
        id: "content",
        label: "Note Content",
        showLabel: false,
        maxLines: 15,
        controller: TextEditingController(
          text:
              widget.noteData?["content"] ??
              "The primary objective for the Q4 sprint is to finalize the core architecture for the cross-platform synchronization engine.\n\nKey deliverables include:\n• End-to-end encryption for all user notes\n• Offline-first support for mobile clients\n• Real-time collaborative editing using CRDTs\n\nWe need to review the attached contract for the cloud storage provider and ensure it meets our data residency requirements",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Custom App Bar
          _buildCustomAppBar(context),

          // Main Content
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Last Modified Info
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text(
                      "Modified on 2 | 10:45 AM",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Form Content
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Form Fields (Title & Content)
                        CustomFormFieldGenerator(
                          onFieldSubmitted: (data) {
                            formData = data;
                            setState(() {});
                          },
                          formKey: _formKey,
                          formFields: formFields,
                        ),

                        SizedBox(height: 24.h),

                        // Category Section
                        Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildCategoryChips(context),

                        SizedBox(height: 32.h),

                        // Attachments Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Attachments",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            TextButton(
                              onPressed: _showAttachmentOptions,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "Add New",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        // Attachments List
                        ...attachments.map(
                          (attachment) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: _buildAttachmentItem(attachment),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Add Attachment Buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildDottedButton(
                                label: "Add Image",
                                icon: Icons.add_a_photo,
                                onPressed: _addImage,
                                context: context,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildDottedButton(
                                label: "Add File",
                                icon: Icons.attach_file,
                                onPressed: _addFile,
                                context: context,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Toolbar
          _buildBottomToolbar(context),
        ],
      ),
    );
  }

  // 🎨 CUSTOM APP BAR
  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20.sp,
              ),
            ),
          ),

          // Title
          Text(
            "Edit Note Detail",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),

          // Action Buttons
          Row(
            children: [
              _buildActionButton(context, Icons.pin_drop, () {}),
              SizedBox(width: 8.w),
              _buildActionButton(context, Icons.bookmark_border, () {}),
              SizedBox(width: 8.w),
              _buildActionButton(context, Icons.share, () {}),
              SizedBox(width: 8.w),
              _buildActionButton(context, Icons.history, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 18.sp,
        ),
      ),
    );
  }

  // 🏷️ CATEGORY CHIPS
  Widget _buildCategoryChips(BuildContext context) {
    final categories = [
      {"label": "Work", "icon": Icons.work},
      {"label": "Personal", "icon": Icons.person},
      {"label": "Ideas", "icon": Icons.lightbulb},
      {"label": "To-Do", "icon": Icons.check_box},
      {"label": "Other", "icon": Icons.label},
    ];

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children:
          categories.map((category) {
            final isSelected = category["label"] == selectedCategory;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category["label"] as String;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color:
                        isSelected
                            ? Colors.transparent
                            : Theme.of(
                              context,
                            ).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category["icon"] as IconData,
                      size: 16.sp,
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      category["label"] as String,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildDottedButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
            style: BorderStyle.solid,
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentItem(Map<String, dynamic> attachment) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: attachment['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              attachment['icon'],
              color: attachment['color'],
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // File Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment['name'],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  attachment['type'].toUpperCase(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),

          // Delete Button
          GestureDetector(
            onTap: () {
              setState(() {
                attachments.remove(attachment);
              });
            },
            child: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomToolbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          _buildToolbarButton(context, Icons.format_bold, false),
          _buildToolbarButton(context, Icons.format_italic, false),
          _buildToolbarButton(context, Icons.format_underlined, false),
          _buildToolbarButton(context, Icons.format_list_bulleted, false),
          _buildToolbarButton(context, Icons.format_list_numbered, false),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              "Auto-saved 2 minutes ago",
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton(
    BuildContext context,
    IconData icon,
    bool isActive,
  ) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () {
          // TODO: Implement toolbar functionality
        },
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color:
                isActive
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color:
                isActive
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Attachment",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 24.h),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 24.sp,
                  ),
                  title: Text(
                    "Take Photo",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _addImage();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Colors.green,
                    size: 24.sp,
                  ),
                  title: Text(
                    "Photo Library",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _addImage();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.attach_file,
                    color: Colors.orange,
                    size: 24.sp,
                  ),
                  title: Text(
                    "File",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Image picker functionality')));
  }

  void _addFile() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('File picker functionality')));
  }
}
