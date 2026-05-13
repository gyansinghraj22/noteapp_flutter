import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/features/home/insight_screen.dart';
import 'package:noteapp/features/note/screens/add_note.dart';
// import 'package:noteapp/features/note/screens/add_note.dart';
import 'package:noteapp/features/note/screens/list_note.dart';
import 'package:noteapp/features/profile/screens/profile_screen.dart';
import 'package:noteapp/features/attachments_gallery/screens/attachment_gallery_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ListNoteScreen(),
    const AttachmentGalleryScreen(),
    InsightScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bodyColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
      // fabLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      width: 56,
      height: 56,
      margin: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );

          // Refresh notes list if a note was added
          if (result == true) {
            // Refresh the notes list by calling setState
            setState(() {});
          }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withOpacity(0.6),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_file_outlined),
            activeIcon: Icon(Icons.attach_file),
            label: 'Attachments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open_sharp),
            activeIcon: Icon(Icons.folder_open_sharp),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
