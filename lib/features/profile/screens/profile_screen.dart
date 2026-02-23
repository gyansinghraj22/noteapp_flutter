import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/core/common/app_single_child_scroll_view/app_single_child_scroll_view.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      bodyColor: const Color(0xFFF5F5F5),
      body: AppSingleChildScrollView(
        child: Column(
          children: [
            // Safe area spacing
            SizedBox(height: MediaQuery.of(context).padding.top),

            // Title
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A0A0A),
                  fontFamily: "Satoshi",
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Profile Picture and Info Section
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  // Profile Picture with Edit Button
                  Stack(
                    children: [
                      // Profile Picture
                      Container(
                        width: 202.w,
                        height: 202.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE5E7EB),
                          image: DecorationImage(
                            image: AssetImage(AppImages.avatarImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Edit Button
                      Positioned(
                        bottom: 0,
                        right: 28.w,
                        child: GestureDetector(
                          onTap: () {
                            // Handle edit profile picture
                          },
                          child: Container(
                            width: 34.w,
                            height: 34.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF34F4C6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Name
                  Text(
                    'Daniel Martinez',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0A0A0A),
                      fontFamily: "Satoshi",
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Phone Number
                  Text(
                    '+123 856479683',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF737373),
                      fontFamily: "Satoshi",
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Menu Section
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    label: 'Edit Profile',
                    onTap: () {
                      // Navigate to edit profile
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    label: 'Favorite',
                    onTap: () {
                      // Navigate to favorites
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.notifications_none,
                    label: 'Notifications',
                    onTap: () {
                      // Navigate to notifications
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () {
                      // Navigate to settings
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    label: 'Help and Support',
                    onTap: () {
                      // Navigate to help
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.shield_outlined,
                    label: 'Terms and Conditions',
                    onTap: () {
                      // Navigate to terms
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.logout,
                    label: 'Log Out',
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    showArrow: false,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: const Color(0xFF737373)),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF737373),
                  fontFamily: "Satoshi",
                ),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: const Color(0xFF737373),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1.h, color: const Color(0xFFF5F5F5));
  }

  void _showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A3128),
                  fontFamily: "Satoshi",
                ),
              ),
              SizedBox(height: 16.h),

              // Separator
              Container(height: 1.h, color: const Color(0xFFF5F5F5)),
              SizedBox(height: 16.h),

              // Text
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF737373),
                  fontFamily: "Satoshi",
                ),
              ),
              SizedBox(height: 24.h),

              // Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.r),
                          border: Border.all(
                            color: const Color(0xFFF5F5F5),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF737373),
                            fontFamily: "Satoshi",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  MyCustomTextButton(
                    text: "Log Out",
                    backgroundColor: Color(0xFF34F4C6),
                    textColor: Color(0xFF0A3128),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
