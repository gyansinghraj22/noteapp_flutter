import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedCategory = "All";
  String selectedDateRange = "All Time";
  bool isFavoriteOnly = false;

  final List<String> categories = [
    "All",
    "Work",
    "Personal",
    "Ideas",
    "Travel",
    "Fitness",
  ];

  final List<String> dateRanges = [
    "All Time",
    "Today",
    "This Week",
    "This Month",
    "This Year",
  ];

  final List<Map<String, dynamic>> searchResults = [
    {
      "title": "Project Alpha Launch",
      "desc": "Finalize marketing assets and design mockups...",
      "category": "Work",
      "time": "2 mins ago",
      "isFavorite": true,
    },
    {
      "title": "Grocery List",
      "desc": "Bread, Avocados, Milk, Eggs, Butter...",
      "category": "Personal",
      "time": "1 hour ago",
      "isFavorite": false,
    },
    {
      "title": "App Improvement Ideas",
      "desc": "Dark mode, sync across devices, offline mode...",
      "category": "Ideas",
      "time": "4 hours ago",
      "isFavorite": true,
    },
    {
      "title": "Weekend Trip Plans",
      "desc": "Hotels, flights, itinerary, budget breakdown...",
      "category": "Travel",
      "time": "1 day ago",
      "isFavorite": false,
    },
  ];

  List<Map<String, dynamic>> get filteredResults {
    return searchResults.where((note) {
      final matchesCategory =
          selectedCategory == "All" || note["category"] == selectedCategory;
      final matchesFavorite = !isFavoriteOnly || note["isFavorite"];
      final searchText = searchController.text.toLowerCase();
      final matchesSearch = searchText.isEmpty ||
          note["title"].toLowerCase().contains(searchText) ||
          note["desc"].toLowerCase().contains(searchText);

      return matchesCategory && matchesFavorite && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildCustomAppBar(context),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverToBoxAdapter(child: _buildSearchBar(context)),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverToBoxAdapter(child: _buildFilterSection(context)),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 24.h,
                    bottom: 12.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "${filteredResults.length} results found",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                if (filteredResults.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: _buildResultCard(context, filteredResults[index]),
                        ),
                        childCount: filteredResults.length,
                      ),
                    ),
                  )
                else
                  SliverFillRemaining(
                    child: Center(child: _buildEmptyState(context)),
                  ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
            ),
          ),
          Text(
            "Search & Filters",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                searchController.clear();
                selectedCategory = "All";
                selectedDateRange = "All Time";
                isFavoriteOnly = false;
              });
            },
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.close,
                  color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.15),
        ),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: "Search notes...",
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          prefixIcon: Icon(Icons.search,
              color: Theme.of(context).colorScheme.primary, size: 20.sp),
          suffixIcon: searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    searchController.clear();
                    setState(() {});
                  },
                  child: Icon(Icons.clear,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                      size: 18.sp),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        ),
        style: TextStyle(fontSize: 13.sp, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          "Category",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 32.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;
              return GestureDetector(
                onTap: () => setState(() => selectedCategory = category),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Date Range",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.15),
            ),
          ),
          child: DropdownButton<String>(
            value: selectedDateRange,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            items: dateRanges
                .map((range) => DropdownMenuItem(value: range, child: Text(range)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => selectedDateRange = value);
            },
          ),
        ),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () => setState(() => isFavoriteOnly = !isFavoriteOnly),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isFavoriteOnly
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isFavoriteOnly
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withOpacity(0.15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isFavoriteOnly ? Icons.favorite : Icons.favorite_outline,
                  size: 18.sp,
                  color: isFavoriteOnly
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Show Favorites Only",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isFavoriteOnly
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: isFavoriteOnly
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: isFavoriteOnly
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: isFavoriteOnly
                      ? Icon(Icons.check,
                          size: 14.sp,
                          color: Theme.of(context).colorScheme.onPrimary)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(BuildContext context, Map<String, dynamic> result) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  result["title"],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  result["isFavorite"] ? Icons.favorite : Icons.favorite_outline,
                  size: 18.sp,
                  color: result["isFavorite"]
                      ? Colors.red
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            result["desc"],
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  result["category"],
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(
                result["time"],
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search,
            size: 64.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
        SizedBox(height: 16.h),
        Text(
          "No results found",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Try adjusting your search or filters",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
