import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';

class ListNoteScreen extends StatefulWidget {
  const ListNoteScreen({super.key});

  @override
  State<ListNoteScreen> createState() => ListNoteScreenState();
}

class ListNoteScreenState extends State<ListNoteScreen> {
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();

  List<CustomFormFieldConfig> formFields = [];

  static const double _horizontalPadding = 24;

  String selectedCategory = "All";

  final List<String> categories = [
    "All",
    "Work",
    "Personal",
    "Ideas",
    "Travel",
    "Fitness",
  ];

  List<Map<String, dynamic>> notes = [
    {
      "title": "Project Alpha Launch",
      "desc": "Finalize marketing assets...",
      "category": "Work",
      "time": "2 mins ago",
    },
    {
      "title": "Grocery List",
      "desc": "Bread, Avocados...",
      "category": "Personal",
      "time": "1 hour ago",
    },
    {
      "title": "App Improvement Ideas",
      "desc": "Dark mode, sync...",
      "category": "Ideas",
      "time": "4 hours ago",
    },
  ];

  List<Map<String, dynamic>> get filteredNotes {
    return notes.where((note) {
      final matchesCategory =
          selectedCategory == "All" || note["category"] == selectedCategory;

      final searchText = (formData["search"] ?? "").toString().toLowerCase();

      final matchesSearch = note["title"].toLowerCase().contains(searchText);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getInitialData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  getInitialData() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "search",
        label: "Search notes...",
        showLabel: false,
        isRequired: false,
        prefixIcon: Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  'Notes',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ),
        ),

        // Filter Chips Section
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          sliver: SliverToBoxAdapter(child: _horizontalFilterSection()),
        ),

        // Notes List Section
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final note = filteredNotes[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _buildNoteCard(note),
              );
            }, childCount: filteredNotes.length),
          ),
        ),

        // Bottom padding
        SliverPadding(
          padding: EdgeInsets.only(bottom: 24.h),
          sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
        ),
      ],
    );
  }

  Widget _horizontalFilterSection() {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                selectedCategory = category;
              });
            },
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoteCard(Map<String, dynamic> note) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  note["title"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(note["time"], style: const TextStyle(color: Colors.white54)),
            ],
          ),

          SizedBox(height: 8.h),

          // Description
          Text(note["desc"], style: const TextStyle(color: Colors.white70)),

          SizedBox(height: 8.h),

          // Category Tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColor.brightSkyMain.withAlpha(30),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              note["category"],
              style: TextStyle(color: AppColor.brightSkyMain, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
