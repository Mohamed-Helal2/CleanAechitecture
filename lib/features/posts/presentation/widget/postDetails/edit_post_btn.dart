import 'package:flutter/material.dart';

import '../../../domain/entites/post.dart';
import '../../pages/post_add_update.dart';
import 'edit_delete_button.dart';

class EditPostBtn extends StatelessWidget {
  const EditPostBtn({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return EditDeleteButton(
      isedit: true,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostAddUpdate(
            isUpdatPost: true,
            post: post,
          ),
        ));
      },
    );
  }
}
