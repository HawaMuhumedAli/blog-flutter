import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/bookmarks.dart';
import 'pages/profile.dart';
import 'pages/add_blog.dart';
import 'pages/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog UI Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/bookmarks': (context) => const BookmarksPage(),
        '/profile': (context) => const ProfilePage(),
        '/add-blog': (context) => const AddBlogPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
