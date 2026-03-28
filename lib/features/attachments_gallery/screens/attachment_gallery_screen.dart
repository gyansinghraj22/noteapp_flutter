import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentGalleryScreen extends StatefulWidget {
  const AttachmentGalleryScreen({super.key});

  @override
  State<AttachmentGalleryScreen> createState() =>
      _AttachmentGalleryScreenState();
}

class _AttachmentGalleryScreenState extends State<AttachmentGalleryScreen> {
  String selectedFilter = "All";

  final List<Map<String, dynamic>> recentMediaItems = [
    {
      "type": "image",
      "path": "assets/images/Pasted image.png",
      "name": "alert_dialog_image.png",
    },
    {
      "type": "image",
      "path": "assets/images/app_image.png",
      "name": "app_image.png",
    },
    {"type": "image", "path": "assets/images/avatar.png", "name": "avatar.png"},
    {
      "type": "image",
      "path": "assets/images/banner_vet1.png",
      "name": "banner_vet1.png",
    },
  ];

  final List<Map<String, dynamic>> documentsAndAudio = [
    {
      "type": "pdf",
      "icon": Icons.picture_as_pdf,
      "name": "Project Roadmap 2024.pdf",
      "subtitle": "Note: Product Strategy",
    },
    {
      "type": "audio",
      "icon": Icons.music_note,
      "name": "Interview Snippet_01.m4a",
      "subtitle": "0:45 / 2:30",
    },
    {
      "type": "doc",
      "icon": Icons.description,
      "name": "Technical Specs V1.docx",
      "subtitle": "Note: Feature Request #102",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar
        // SliverAppBar(
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   elevation: 0,
        //   title: Text(
        //     'Attachments',
        //     style: TextStyle(
        //       color: Theme.of(context).colorScheme.onBackground,
        //       fontWeight: FontWeight.w700,
        //       fontSize: 20.sp,
        //     ),
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: Icon(
        //         Icons.search,
        //         color: Theme.of(context).colorScheme.onBackground,
        //       ),
        //       onPressed: () {
        //         // TODO: Implement search functionality
        //       },
        //     ),
        //     IconButton(
        //       icon: Icon(
        //         Icons.more_vert,
        //         color: Theme.of(context).colorScheme.onBackground,
        //       ),
        //       onPressed: () {

        //       },
        //     ),
        //   ],
        //   pinned: true,
        //   floating: true,
        // ),
        SliverPadding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  'Attachments',
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
          sliver: SliverToBoxAdapter(child: _buildFilterChips(context)),
        ),

        // Recent Media Section
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RECENT MEDIA',
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
              ],
            ),
          ),
        ),

        // Recent Media Grid
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return _buildImageCard(context, recentMediaItems[index]);
            }, childCount: recentMediaItems.length),
          ),
        ),

        // Documents & Audio Section Header
        SliverPadding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 32.h,
            bottom: 12.h,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              'DOCUMENTS & AUDIO',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),

        // Documents & Audio List
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _buildDocumentCard(context, documentsAndAudio[index]),
              );
            }, childCount: documentsAndAudio.length),
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

  Widget _buildFilterChips(BuildContext context) {
    final List<String> filters = ["All", "Images", "PDFs", "Audio", "Sketch"];

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;
          return FilterChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                selectedFilter = filter;
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
              side: BorderSide(
                color:
                    isSelected
                        ? Colors.transparent
                        : Theme.of(
                          context,
                        ).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          );
        },
      ),
    );
  }

  Widget _buildImageCard(
    BuildContext context,
    Map<String, dynamic> attachment,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: AssetImage(attachment["path"]!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Image name overlay (optional - at bottom)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
              padding: EdgeInsets.all(8.w),
              child: Text(
                attachment["name"]!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(
    BuildContext context,
    Map<String, dynamic> document,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(document["type"]),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                document["icon"],
                color: _getIconColor(document["type"]),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    document["name"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    document["subtitle"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
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
            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconBackgroundColor(String type) {
    switch (type) {
      case "pdf":
        return const Color(0xFFFFEBEE);
      case "audio":
        return const Color(0xFFF3E5F5);
      case "doc":
        return const Color(0xFFE3F2FD);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case "pdf":
        return const Color(0xFFE53935);
      case "audio":
        return const Color(0xFF7B1FA2);
      case "doc":
        return const Color(0xFF1565C0);
      default:
        return const Color(0xFF757575);
    }
  }
}
