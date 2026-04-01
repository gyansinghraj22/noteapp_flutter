import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
// import 'package:noteapp/features/note/screens/add_note.dart';
import 'package:noteapp/features/note/screens/list_note.dart';
import 'package:noteapp/core/config/theme_toggle_widgets.dart';
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
    const Center(child: Text("Insights")),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bodyColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: _buildBottomNavigationBar(),
      // floatingActionButton: _buildFloatingActionButton(),
      // fabLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Widget _buildFloatingActionButton() {
  //   return Container(
  //     width: 56,
  //     height: 56,
  //     margin: const EdgeInsets.only(bottom: 10),
  //     child: FloatingActionButton(
  //       onPressed: () async {
  //         FocusScope.of(context).unfocus();
  //         final result = await Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const AddNoteScreen()),
  //         );

  //         // Refresh notes list if a note was added
  //         if (result == true ) {
  //           // Refresh the notes list by calling setState
  //           setState(() {});
  //         }
  //       },
  //       backgroundColor: Theme.of(context).colorScheme.primary,
  //       elevation: 4,
  //       child: const Icon(Icons.add, color: Colors.white, size: 28),
  //     ),
  //   );
  // }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70.h,
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

// Insights Screen
class _InsightsScreen extends StatelessWidget {
  const _InsightsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Insights',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const ThemeToggleButton(),
                ],
              ),
              const SizedBox(height: 32),
              const _InsightCard(
                title: 'Total Notes',
                value: '127',
                icon: Icons.note_alt,
                color: Color(0xFF1DC7F2),
              ),
              const SizedBox(height: 16),
              const _InsightCard(
                title: 'Notes This Week',
                value: '12',
                icon: Icons.trending_up,
                color: Color(0xFF22C55E), // Softer green
              ),
              const SizedBox(height: 16),
              _InsightCard(
                title: 'Categories Used',
                value: '5',
                icon: Icons.category,
                color: Color(0xFFF59E0B), // Warmer orange
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _InsightCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Search Screen
class _SearchScreen extends StatefulWidget {
  const _SearchScreen();

  @override
  State<_SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  final List<Map<String, dynamic>> _allNotes = [
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

  void _performSearch(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults =
            _allNotes.where((note) {
              return note['title'].toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  note['desc'].toLowerCase().contains(query.toLowerCase()) ||
                  note['category'].toLowerCase().contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Notes',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _performSearch,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search your notes...',
                    hintStyle: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child:
                    _isSearching
                        ? _searchResults.isNotEmpty
                            ? ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                final note = _searchResults[index];
                                return _buildSearchResultItem(note);
                              },
                            )
                            : const Center(
                              child: Text(
                                'No notes found',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            )
                        : Center(
                          child: Text(
                            'Start typing to search your notes',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultItem(Map<String, dynamic> note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  note['title'],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                note['time'],
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            note['desc'],
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1DC7F2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              note['category'],
              style: const TextStyle(
                color: Color(0xFF1DC7F2),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
