import 'package:blog_app/controllers/userController.dart';
import 'package:blog_app/pages/auth/signin/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/app_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    // Dummy user data
    const String username = "hawa luul";
    const String email = "hawa@example.com";
    final String initial =
        username.isNotEmpty ? username[0].toUpperCase() : "?";

    return AppScaffold(
      initialIndex: 4,
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        initial,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Username
                  const Text(
                    username,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Email
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        userController.logout();
                        // Add logout functionality
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Log Out'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // My Blogs Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Blogs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Blog List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dummyUserBlogs.length,
                    itemBuilder: (context, index) {
                      final blog = dummyUserBlogs[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              blog.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            blog.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            blog.date,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 20),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.red[700],
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (value) {
                              // Handle edit/delete
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy blog data
class UserBlog {
  final String title;
  final String date;
  final String imageUrl;

  const UserBlog({
    required this.title,
    required this.date,
    required this.imageUrl,
  });
}

final List<UserBlog> dummyUserBlogs = [
  UserBlog(
    title: 'How to become master in colour palette?',
    date: 'Jan 26, 2024',
    imageUrl: 'https://picsum.photos/seed/1/800/400',
  ),
  UserBlog(
    title: 'Design systems that people want to use',
    date: 'Jan 25, 2024',
    imageUrl: 'https://picsum.photos/seed/2/800/400',
  ),
  UserBlog(
    title: 'The future of UX/UI design in 2024',
    date: 'Jan 24, 2024',
    imageUrl: 'https://picsum.photos/seed/3/800/400',
  ),
];
