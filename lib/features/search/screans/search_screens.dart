import 'package:flutter/material.dart';

class SearchScreens extends StatefulWidget {
  final List<String> searchItems;
  final Function(String) onItemSelected;

  const SearchScreens({
    super.key,
    required this.searchItems,
    required this.onItemSelected,
  });

  @override
  State<SearchScreens> createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        widget.searchItems
            .where(
              (item) => item.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(item),
            onTap: () {
              widget.onItemSelected(item);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
