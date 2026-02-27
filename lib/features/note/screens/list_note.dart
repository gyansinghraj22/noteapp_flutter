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
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSearchSection(),
          _horizontalFilterSection(),
          _buildNotesList(),
        ],
      ),
    );
  }

  // 🔍 SEARCH
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

  // 🏷️ FILTER CHIPS
  SliverToBoxAdapter _horizontalFilterSection() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 30.h,
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
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppColor.brightSkyMain
                          : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 📄 NOTES LIST
  SliverList _buildNotesList() {
    final data = filteredNotes;

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
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: _horizontalPadding.w,
              vertical: 6.h,
            ),
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
                    Text(
                      note["time"],
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Description
                Text(
                  note["desc"],
                  style: const TextStyle(color: Colors.white70),
                ),

                SizedBox(height: 8.h),

                // Category Tag
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.brightSkyMain.withAlpha(30),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    note["category"],
                    style: TextStyle(
                      color: AppColor.brightSkyMain,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: data.length),
    );
  }
}
