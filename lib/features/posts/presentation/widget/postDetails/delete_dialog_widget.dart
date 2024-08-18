import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_post_cubit.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({super.key, required this.postid});
  final int postid;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are U  ?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No")),
        TextButton(
            onPressed: () {
              context.read<AddDeleteUpdatePostCubit>().deletePost(postid);
            },
            child: const Text("Yes"))
      ],
    );
  }
}
