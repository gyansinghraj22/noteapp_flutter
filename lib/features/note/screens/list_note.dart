import 'package:flutter/material.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';

class ListNoteScreen extends StatefulWidget {
  const ListNoteScreen({super.key});

  @override
  State<ListNoteScreen> createState() => ListNoteScreenState();
}

class ListNoteScreenState extends State<ListNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: SafeArea(
        child: Column(
          children: [
            const Text('List Note'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-note');
              },
              child: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
