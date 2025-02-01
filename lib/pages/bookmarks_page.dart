import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/blogController.dart';
import '../widgets/app_scaffold.dart';
import 'home.dart';

class BookmarksPage extends GetView<BlogController> {
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
        automaticallyImplyLeading: false, // This removes back arrow
      ),
      body: Obx(() {
        if (controller.bookmarkedPosts.isEmpty) {
          return const Center(
            child: Text('No bookmarked posts yet'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.bookmarkedPosts.length,
          itemBuilder: (context, index) {
            final blog = controller.bookmarkedPosts[index];
            return BlogItem(
              blog: blog,
              onTap: () => Get.toNamed('/blog-details', arguments: blog),
            );
          },
        );
      }),
    );
  }
}
