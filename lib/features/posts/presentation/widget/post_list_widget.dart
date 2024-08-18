import 'package:flutter/material.dart';

import '../../domain/entites/post.dart';

class postListWidget extends StatelessWidget {
  const postListWidget({super.key, required this.posts});
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            posts[index].id.toString(),
          ),
          title: Text(
            posts[index].title.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(thickness: 1,);
      },
    );
  }
}
