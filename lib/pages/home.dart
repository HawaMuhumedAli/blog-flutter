import 'package:blog_app/controllers/blogController.dart';
import 'package:blog_app/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/app_scaffold.dart';
import 'package:timeago/timeago.dart' as timeago;
////////

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final blogController = Get.put(BlogController());

  @override
  void initState() {
    super.initState();
    blogController.getBlogPost();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false, // This removes back arrow

      ),
      body: Obx(() {
        if (blogController.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (blogController.data.isEmpty) {
          return const Center(child: Text('No blogs found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: blogController.data.length,
          itemBuilder: (context, index) {
            final blog = blogController.data[index];
            return BlogItem(
              blog: blog,
              onTap: () => Get.to(() => BlogDetailsPage(blog: blog)),
            );
          },
        );
      }),
    );
  }
}

class BlogItem extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;

  const BlogItem({
    Key? key,
    required this.blog,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogController = Get.find<BlogController>();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.image.isNotEmpty)
              Image.network(
                blog.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          blog.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Obx(() => IconButton(
                        icon: Icon(
                              blogController.isBookmarked(blog)
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: blogController.isBookmarked(blog)
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                            onPressed: () =>
                                blogController.toggleBookmark(blog),
                          )),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'Posted by ${blog.user.email}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeago.format(DateTime.parse(blog.createdAt)),
                    style: Theme.of(context).textTheme.bodySmall,
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

class BlogDetailsPage extends StatelessWidget {
  final Blog blog;

  const BlogDetailsPage({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.image.isNotEmpty)
              Image.network(
                blog.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 4),
                      Text(blog.user.email),
                      const Spacer(),
                      Text(
                        timeago.format(DateTime.parse(blog.createdAt)),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    blog.story,
                    style: Theme.of(context).textTheme.bodyLarge,
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
