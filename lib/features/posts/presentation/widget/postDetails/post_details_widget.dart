import 'package:flutter/material.dart';
import '../../../domain/entites/post.dart';
import 'delete_post_btn_widget.dart';
import 'edit_post_btn.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          const Divider(
            height: 50,
          ),
          Text(post.body,
              style: const TextStyle(
                  color: Color.fromARGB(255, 26, 26, 26),
                  fontSize: 20,
                  fontWeight: FontWeight.w100)),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EditPostBtn(post: post),
              DeletePostBtnWidget(postid: post.id!)
            ],
          )
        ],
      ),
    );
  }
}
