import 'package:flutter/cupertino.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../../domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  const BlogCard({required this.blog, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(blog.title, style: context.theme.textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(
            blog.summary,
            style: context.theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
