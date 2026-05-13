import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  String selectedPeriod = "Week";

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverPadding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  'Insights',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ),
        ),

        // Period Selector
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  ["Week", "Month", "Year"].map((period) {
                    final isSelected = selectedPeriod == period;
                    return GestureDetector(
                      onTap: () => setState(() => selectedPeriod = period),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColor.brightSkyMain
                                  : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          period,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                isSelected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),

        // Key Stats Section
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: "TOTAL NOTES",
                    value: "1,248",
                    subtitle: "+32",
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: "ATTACHMENTS",
                    value: "432",
                    subtitle: "+15",
                  ),
                ),
              ],
            ),
          ),
        ),

        // Storage Section
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "STORAGE USED",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "2.4 GB / 5 GB",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: LinearProgressIndicator(
                      value: 0.48,
                      minHeight: 8.h,
                      backgroundColor:
                          Theme.of(context).colorScheme.outlineVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.brightSkyMain,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Upgrade storage only 4 of 2 year",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.brightSkyMain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Notes Created Per Week Section
        SliverPadding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notes created per week",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),

        // Activity Chart
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverToBoxAdapter(child: _buildActivityChart(context)),
        ),

        // Recent Activity
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "42 notes",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "+ 8%",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.healingGreenMain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Tag Distribution Section Header
        SliverPadding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: 12.h,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tag distribution",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tag Distribution Chart
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverToBoxAdapter(
            child: _buildTagDistributionChart(context),
          ),
        ),

        // View full breakdown link
        SliverPadding(
          padding: EdgeInsets.all(16.w),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: Text(
                "View full breakdown",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.brightSkyMain,
                ),
              ),
            ),
          ),
        ),

        // Weekly Insight Card
        SliverPadding(
          padding: EdgeInsets.all(16.w),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.brightSkyMain,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weekly Insight",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Saturday 10:30",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "You created 42 notes this week. Your most productive time was in the morning. Keep up the great work! Get your weekly average Today the momentum.",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
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

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.healingGreenMain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChart(BuildContext context) {
    final List<double> data = [0.3, 0.5, 0.7, 0.4, 0.8, 0.6, 0.9];
    final List<String> labels = ["M", "T", "W", "T", "F", "S", "S"];

    return Container(
      height: 150.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              data.length,
              (index) => Column(
                children: [
                  Container(
                    width: 28.w,
                    height: data[index] * 100.h,
                    decoration: BoxDecoration(
                      color: AppColor.brightSkyMain,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagDistributionChart(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Pie chart representation
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.brightSkyMain.withOpacity(0.1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.4,
                  strokeWidth: 12.w,
                  backgroundColor: Theme.of(context).colorScheme.outlineVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.brightSkyMain,
                  ),
                ),
                Text(
                  "40%",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          // Legend
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(context, "Work", 40),
                SizedBox(height: 8.h),
                _buildLegendItem(context, "Personal", 30),
                SizedBox(height: 8.h),
                _buildLegendItem(context, "Ideas", 20),
                SizedBox(height: 8.h),
                _buildLegendItem(context, "Drafts", 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, int percentage) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.brightSkyMain,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        Text(
          "$percentage%",
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
