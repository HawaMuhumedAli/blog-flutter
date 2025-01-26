import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      initialIndex: 3,
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('Search Page'),
      ),
    );
  }
}
