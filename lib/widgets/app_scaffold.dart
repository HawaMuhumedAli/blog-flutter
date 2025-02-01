import 'package:blog_app/pages/add_blog.dart';
import 'package:blog_app/pages/bookmarks_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home.dart';
import '../pages/profile.dart';
import '../pages/search.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final String? title;
  final bool showBackButton;
  final PreferredSizeWidget? appBar;
  final int initialIndex;

  const AppScaffold({
    Key? key,
    required this.body,
    this.title,
    this.showBackButton = false,
    this.appBar,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    // Handle the "Add Blog" button separately
    if (index == 2) {
      Get.toNamed('/addBlog'); // Navigate to the "Add Blog" page
      return; // Exit the function to avoid updating the selected index
    }

    // Update the selected index
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the corresponding route
    String route = '';
    switch (index) {
      case 0:
        route = '/';
        break;
      case 1:
        route = '/bookmarks';
        break;
      case 3:
        route = '/profile';
        break;
    }

    if (route.isNotEmpty) {
      Get.toNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: Colors.grey[50],
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
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