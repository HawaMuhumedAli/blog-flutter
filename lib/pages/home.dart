import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyBlogs.length,
        itemBuilder: (context, index) {
          final blog = dummyBlogs[index];
          return BlogItem(
            date: blog.date,
            title: blog.title,
            imageUrl: blog.imageUrl,
            isBookmarked: blog.isBookmarked,
          );
        },
      ),
    );
  }
}

class BlogItem extends StatefulWidget {
  final String date;
  final String title;
  final String imageUrl;
  final bool isBookmarked;

  const BlogItem({
    super.key,
    required this.date,
    required this.title,
    required this.imageUrl,
    required this.isBookmarked,
  });

  @override
  State<BlogItem> createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailsPage(
              title: widget.title,
              imageUrl: widget.imageUrl,
              date: widget.date,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                widget.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
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
                      Text(
                        widget.date,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: _isBookmarked ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isBookmarked = !_isBookmarked;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
  final String title;
  final String imageUrl;
  final String date;

  const BlogDetailsPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      height: 1.5,
                    ),
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

// Dummy data model
class Blog {
  final String date;
  final String title;
  final String imageUrl;
  final bool isBookmarked;

  const Blog({
    required this.date,
    required this.title,
    required this.imageUrl,
    this.isBookmarked = false,
  });
}

// Dummy data
final List<Blog> dummyBlogs = [
  Blog(
    date: 'Jan 26',
    title: 'How to become master in colour palette?',
    imageUrl: 'https://picsum.photos/seed/1/800/400',
  ),
  Blog(
    date: 'Jan 25',
    title: 'Design systems that people want to use',
    imageUrl: 'https://picsum.photos/seed/2/800/400',
  ),
  Blog(
    date: 'Jan 24',
    title: 'The future of UX/UI design in 2024',
    imageUrl: 'https://picsum.photos/seed/3/800/400',
  ),
];
