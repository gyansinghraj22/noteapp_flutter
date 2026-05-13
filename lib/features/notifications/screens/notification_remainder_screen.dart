import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';

class NotificationRemainderScreen extends StatefulWidget {
  const NotificationRemainderScreen({super.key});

  @override
  State<NotificationRemainderScreen> createState() =>
      _NotificationRemainderScreenState();
}

class _NotificationRemainderScreenState
    extends State<NotificationRemainderScreen> {
  bool autoSyncNotes = true;
  bool wifiOnly = false;
  bool syncMediaFiles = true;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      title: Text(
        'Cloud Sync',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),
      showBackButton: true,
      body: CustomScrollView(
        slivers: [
          // Status Section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Cloud Icon with checkmark
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.healingGreenMain.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.cloud_done,
                        size: 48.sp,
                        color: AppColor.healingGreenMain,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Backup is up to date',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Last backup was today at 6:30 PM',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Cloud Storage Section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CLOUD STORAGE',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
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
                              '1.2 GB',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'of 5GB',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: LinearProgressIndicator(
                            value: 0.24,
                            minHeight: 8.h,
                            backgroundColor:
                                Theme.of(context).colorScheme.outlineVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.healingGreenMain,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '24% used',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Configuration Section
          SliverPadding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 32.h,
              bottom: 16.h,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                'CONFIGURATION',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Configuration Items
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  // Auto-sync notes
                  _buildConfigurationTile(
                    context,
                    icon: Icons.sync,
                    title: 'Auto-sync notes',
                    subtitle: 'Sync changes automatically',
                    value: autoSyncNotes,
                    onChanged: (value) {
                      setState(() => autoSyncNotes = value);
                    },
                  ),
                  SizedBox(height: 12.h),

                  // WiFi only
                  _buildConfigurationTile(
                    context,
                    icon: Icons.wifi,
                    title: 'Wi-Fi only',
                    subtitle: 'Only sync on Wi-Fi networks',
                    value: wifiOnly,
                    onChanged: (value) {
                      setState(() => wifiOnly = value);
                    },
                  ),
                  SizedBox(height: 12.h),

                  // Sync media files
                  _buildConfigurationTile(
                    context,
                    icon: Icons.image,
                    title: 'Sync media files',
                    subtitle: 'Images and recordings',
                    value: syncMediaFiles,
                    onChanged: (value) {
                      setState(() => syncMediaFiles = value);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Sync Now Button
          SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.cloud_sync, size: 20.sp),
                      label: Text(
                        'Sync Now',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.healingGreenMain,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        // Handle sync action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Syncing your data...')),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Using data on a metered connection?',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColor.healingGreenMain.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: AppColor.healingGreenMain, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColor.healingGreenMain,
          ),
        ],
      ),
    );
  }
}
