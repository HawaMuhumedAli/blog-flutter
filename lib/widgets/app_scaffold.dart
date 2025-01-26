import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/bookmarks.dart';
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
  final List<Widget> _pages = [
    const HomePage(),
    const BookmarksPage(),
    const SizedBox(), // Placeholder for add button
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    // Handle add button separately
    if (index == 2) {
      Navigator.pushNamed(context, '/add-blog');
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // Use the current route name to avoid unnecessary navigation
    String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
    String targetRoute = _getRouteForIndex(index);
    
    if (currentRoute != targetRoute) {
      Navigator.pushReplacementNamed(context, targetRoute);
    }
  }

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/bookmarks';
      case 3:
        return '/search';
      case 4:
        return '/profile';
      default:
        return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: Colors.grey[50],
      body: widget.body,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              activeIcon: Icon(Icons.bookmark),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
