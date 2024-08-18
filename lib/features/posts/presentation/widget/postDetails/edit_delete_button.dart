import 'package:flutter/material.dart';

import '../../../domain/entites/post.dart';

class EditDeleteButton extends StatelessWidget {
  const EditDeleteButton(
      {super.key, required this.isedit, this.post, required this.onPressed});
  final bool isedit;
  final Post? post;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(isedit ? Colors.blue : Colors.red)),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(isedit ? Icons.edit : Icons.delete),
            Text(isedit ? "Edit" : "delete")
          ],
        ));
  }
}
