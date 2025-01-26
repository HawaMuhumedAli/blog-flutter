import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      initialIndex: 1,
      appBar: AppBar(
        title: const Text('Bookmarks'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('Bookmarks Page'),
      ),
    );
  }
}
