
import 'package:blog_app/controllers/userController.dart';
import 'package:blog_app/middleware/auth_middleware.dart';
import 'package:blog_app/pages/add_blog.dart';
import 'package:blog_app/pages/auth/signin/loginScreen.dart';
import 'package:blog_app/pages/auth/signup/signupScreen.dart';
import 'package:blog_app/pages/bookmarks.dart';
import 'package:blog_app/pages/home.dart';
import 'package:blog_app/pages/profile.dart';
import 'package:blog_app/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(UserController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = GetStorage();

  MyApp({super.key});

  String _getInitialRoute() {
    final token = storage.read('token');
    return (token != null && token.isNotEmpty) ? '/' : '/signin';
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Exchange App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: _getInitialRoute(),
      getPages: [
        GetPage(
          name: '/signup',
          page: () =>  SignupScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/signin',
          page: () =>  LoginScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/',
          page: () =>  HomePage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/bookmarks',
          page: () =>  BookmarksPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
          middlewares: [AuthMiddleware()],
        ),
 
        GetPage(
          name: '/search',
          page: () => SearchPage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/add-blog',
          page: () => AddBlogPage(),
          middlewares: [AuthMiddleware()],
        ),
      ],
    );
  }
}


 