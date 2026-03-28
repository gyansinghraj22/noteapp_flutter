import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
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

  void getInitialData() {
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
    if (formFields.isEmpty) {
      getInitialData();
    }

    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeaderSection(),
          _buildSearchSection(),
          _buildCategorySection(),
          _buildNotesList(),
          _verticalSpace(64),
        ],
      ),
    );
  }

  // -------------------- Layout Helpers --------------------

  SliverToBoxAdapter _verticalSpace(double height) {
    return SliverToBoxAdapter(child: SizedBox(height: height.h));
  }

  // 📋 HEADER SECTION
  SliverToBoxAdapter _buildHeaderSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding.w,
          vertical: 8.h,
        ),
        child: Text(
          'My Notes',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  // 🔍 SEARCH SECTION
  SliverToBoxAdapter _buildSearchSection() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 90.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
          child: CustomFormFieldGenerator(
            onFieldSubmitted: (data) {
              formData = data ?? {};
              setState(() {});
            },
            formKey: _formKey,
            formFields: formFields,
          ),
        ),
      ),
    );
  }

  // 🏷️ CATEGORY FILTER SECTION
  SliverToBoxAdapter _buildCategorySection() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategory == category;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppColor.brightSkyMain
                          : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                  border:
                      !isSelected
                          ? Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withOpacity(0.2),
                            width: 1,
                          )
                          : null,
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color:
                        isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 📄 NOTES LIST SECTION
  SliverList _buildNotesList() {
    final data = filteredNotes;

    if (data.isEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Text(
                'No notes found',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          childCount: 1,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final note = data[index];

        return Dismissible(
          key: Key(note["title"]),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            setState(() {
              notes.remove(note);
            });
          },
          background: Container(
            margin: EdgeInsets.symmetric(
              horizontal: _horizontalPadding.w,
              vertical: 6.h,
            ),
            padding: EdgeInsets.only(right: 20.w),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: _buildNoteCard(note),
        );
      }, childCount: data.length),
    );
  }

  // 🎴 INDIVIDUAL NOTE CARD
  Widget _buildNoteCard(Map<String, dynamic> note) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _horizontalPadding.w,
        vertical: 6.h,
      ),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Text(
                note["time"],
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Description
          Text(
            note["desc"],
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),

          SizedBox(height: 12.h),

          // Category Tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColor.brightSkyMain.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              note["category"],
              style: TextStyle(
                color: AppColor.brightSkyMain,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
