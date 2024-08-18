import 'package:flutter/material.dart';

import '../../domain/entites/post.dart';
import '../widget/postDetails/post_details_widget.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        "post Details",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}
