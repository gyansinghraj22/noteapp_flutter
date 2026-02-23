import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/features/note/screens/add_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    Container(color: Colors.red),
    Container(color: Colors.green),
    AddNoteScreen(),
    Container(color: Colors.yellow),
  ];
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x40082720),
            blurRadius: 24.7,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            Icon(Icons.note),
            Icon(Icons.note, size: 24.sp, color: const Color(0xFF1DC7F2)),
            0,
          ),

          _buildNavItem(
            Icon(Icons.insights_outlined),
            Icon(
              Icons.insights_outlined,
              size: 24.sp,
              color: const Color(0xFF1DC7F2),
            ),

            1,
          ),

          _buildCenterButton(), // Keep this as-is

          _buildNavItem(
            Icon(Icons.search_sharp),
            Icon(
              Icons.search_sharp,
              size: 24.sp,
              color: const Color(0xFF1DC7F2),
            ),
            // "Insights",
            2,
          ),

          _buildNavItem(
            Icon(Icons.person_sharp),
            Icon(
              Icons.person_sharp,
              size: 24.sp,
              color: const Color(0xFF1DC7F2),
            ),
            3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    Icon icon,
    Icon activeIcon,
    // String label,
    int index,
  ) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when changing tabs
        FocusScope.of(context).unfocus();
        setState(() => _currentIndex = index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isActive ? activeIcon : icon,

          SizedBox(height: 2.h),
          // Text(
          //   label,
          //   style: TextStyle(
          //     fontSize: 12.sp,
          //     fontWeight: FontWeight.w500,
          //     color: isActive ? const Color(0xFF1DC7F2) : Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard before navigation
        FocusScope.of(context).unfocus();
        Navigator.pushNamed(context, '/addCase');
      },
      child: Container(
        width: 42.w,
        height: 42.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.add_circle_outline, size: 42.sp, color: Colors.black),
      ),
    );
  }
}
