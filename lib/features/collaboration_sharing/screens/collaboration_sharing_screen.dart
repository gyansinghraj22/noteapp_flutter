import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';

class CollaborationSharingScreen extends StatefulWidget {
  const CollaborationSharingScreen({super.key});

  @override
  State<CollaborationSharingScreen> createState() =>
      _CollaborationSharingScreenState();
}

class _CollaborationSharingScreenState
    extends State<CollaborationSharingScreen> {
  List<Map<String, dynamic>> collaborators = [
    {
      "name": "Sarah Williams",
      "email": "sarah.williams@example.com",
      "avatar": "assets/images/saarah_williams.png",
      "role": "Editor",
      "status": "online",
    },
    {
      "name": "Emily Johnson",
      "email": "emily.johnson@example.com",
      "avatar": "assets/images/emily_center.png",
      "role": "Viewer",
      "status": "offline",
    },
    {
      "name": "Michael Chen",
      "email": "michael.chen@example.com",
      "avatar": "assets/images/profile_avatar.jpg",
      "role": "Editor",
      "status": "online",
    },
  ];

  String selectedAccessLevel = "Can edit";

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
                // Share Link Section
                SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverToBoxAdapter(
                    child: _buildShareLinkSection(context),
                  ),
                ),

                // Access Level Section
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverToBoxAdapter(
                    child: _buildAccessLevelSection(context),
                  ),
                ),

                // Collaborators Section Header
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 24.h,
                    bottom: 12.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Collaborators",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "${collaborators.length} people have access",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Collaborators List
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildCollaboratorCard(
                          context,
                          collaborators[index],
                        ),
                      );
                    }, childCount: collaborators.length),
                  ),
                ),

                // Add Collaborator Section
                SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverToBoxAdapter(
                    child: _buildAddCollaboratorButton(context),
                  ),
                ),

                // Bottom Padding
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
            "Sharing & Access",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),

          // Settings Button
          GestureDetector(
            onTap: () {
              // TODO: Show sharing settings
            },
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔗 SHARE LINK SECTION
  Widget _buildShareLinkSection(BuildContext context) {
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 18.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Share Link",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Link Display
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "https://noteapp.com/share/abc123xyz",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    // Copy link
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied!')),
                    );
                  },
                  child: Icon(
                    Icons.copy,
                    size: 18.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: _buildShareButton(
                  context,
                  Icons.check_circle_outline,
                  "Confirm",
                  () {},
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildShareButton(
                  context,
                  Icons.link_off,
                  "Disable",
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔐 ACCESS LEVEL SECTION
  Widget _buildAccessLevelSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          "Access Level",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        SizedBox(height: 12.h),
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
            value: selectedAccessLevel,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            items: [
              DropdownMenuItem(
                value: "Can edit",
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 16.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text("Can edit"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "Can view",
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 16.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text("Can view"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "Can comment",
                child: Row(
                  children: [
                    Icon(
                      Icons.comment,
                      size: 16.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text("Can comment"),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedAccessLevel = value;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  // 👥 COLLABORATOR CARD
  Widget _buildCollaboratorCard(
    BuildContext context,
    Map<String, dynamic> collaborator,
  ) {
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
          // Avatar
          Stack(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(collaborator["avatar"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Status indicator
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        collaborator["status"] == "online"
                            ? const Color(0xFF34F5C6)
                            : Colors.grey,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collaborator["name"],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  collaborator["email"],
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Role Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color:
                  collaborator["role"] == "Editor"
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Theme.of(context).colorScheme.outline.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              collaborator["role"],
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color:
                    collaborator["role"] == "Editor"
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // More Options
          GestureDetector(
            onTap: () {
              _showCollaboratorOptions(context, collaborator);
            },
            child: Icon(
              Icons.more_horiz,
              size: 18.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  // ➕ ADD COLLABORATOR BUTTON
  Widget _buildAddCollaboratorButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddCollaboratorDialog(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 20.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: 8.w),
            Text(
              "Add Collaborator",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog for adding collaborator
  void _showAddCollaboratorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(
              "Add Collaborator",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter email address:",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  decoration: InputDecoration(
                    hintText: "example@email.com",
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invitation sent!')),
                  );
                },
                child: Text(
                  "Send",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  // Bottom sheet for collaborator options
  void _showCollaboratorOptions(
    BuildContext context,
    Map<String, dynamic> collaborator,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "Change Role",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Show role change dialog
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    "Remove Access",
                    style: TextStyle(fontSize: 13.sp, color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      collaborators.remove(collaborator);
                    });
                  },
                ),
              ],
            ),
          ),
    );
  }
}
