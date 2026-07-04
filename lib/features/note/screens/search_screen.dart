import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  List<CustomFormFieldConfig> formFields = [];

  String selectedSearchType = "All";

  final List<Map<String, dynamic>> recentSearches = [
    {"title": "Project X Plan", "icon": Icons.description},
    {"title": "Grocery List for Weekend", "icon": Icons.shopping_cart},
    {"title": "Meeting Notes Q3", "icon": Icons.notes},
  ];

  final List<Map<String, dynamic>> searchTypes = [
    {"title": "Images", "icon": Icons.image, "color": AppColor.brightSkyMain},
    {"title": "Links", "icon": Icons.link, "color": AppColor.brightSkyMain},
    {
      "title": "Checklists",
      "icon": Icons.checklist,
      "color": AppColor.brightSkyMain,
    },
    {
      "title": "Audio",
      "icon": Icons.audio_file,
      "color": AppColor.brightSkyMain,
    },
    {
      "title": "Pinned",
      "icon": Icons.push_pin,
      "color": AppColor.brightSkyMain,
    },
    {
      "title": "Documents",
      "icon": Icons.description,
      "color": AppColor.brightSkyMain,
    },
  ];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _initializeFormFields(context);
    super.didChangeDependencies();
  }

  void _initializeFormFields(BuildContext context) {
    formFields = [
      CustomFormFieldConfig(
        fieldType: FieldType.searchField,
        id: 'search',
        label: '',
        showLabel: false,
        isRequired: false,
        hintText: 'Project X',
        prefixIcon: Icon(Icons.search),
      ),
    ];
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      bodyColor: Theme.of(context).scaffoldBackgroundColor,
      showAppBar: false,

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 4.h,
                bottom: 0.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 20.sp),
                    SizedBox(width: 12.w),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Search',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // CustomAppBar(),
            // Search Form Field
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 0.h),
              sliver: SliverToBoxAdapter(
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

            // Recent Searches Section
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 4.h),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.brightSkyMain,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recent Searches List
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildRecentSearchItem(context, recentSearches[index]),
                  childCount: recentSearches.length,
                ),
              ),
            ),

            // Search by Type Section
            SliverPadding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 24.h,
                bottom: 12.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Search by Type',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),

            // Search Type Grid
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildSearchTypeCard(context, searchTypes[index]),
                  childCount: searchTypes.length,
                ),
              ),
            ),

            // Bottom padding
            SliverPadding(
              padding: EdgeInsets.only(bottom: 24.h),
              sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchItem(
    BuildContext context,
    Map<String, dynamic> search,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(
            Icons.history,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              search['title'],
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Remove from recent searches
            },
            child: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTypeCard(BuildContext context, Map<String, dynamic> type) {
    return GestureDetector(
      onTap: () {
        // Handle search type selection
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: type['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(type['icon'], color: type['color'], size: 28.sp),
            ),
            SizedBox(height: 12.h),
            Text(
              type['title'],
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
