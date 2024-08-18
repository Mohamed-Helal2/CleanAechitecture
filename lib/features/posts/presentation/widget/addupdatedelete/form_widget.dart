import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_post_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/widget/addupdatedelete/button.dart';
import '../../../domain/entites/post.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, required this.isupdatePost, this.post});
  final bool isupdatePost;
  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isupdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void onPressed() {
    if (_formkey.currentState!.validate()) {
      final editAddpost = Post(
          id: widget.isupdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);
      if (widget.isupdatePost) {
        context.read<AddDeleteUpdatePostCubit>().updatePost(editAddpost);
      } else {
        context.read<AddDeleteUpdatePostCubit>().addpost(editAddpost);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                hint: "Title", multilines: false, controller: _titleController),
            TextFormFieldWidget(
                hint: "Body", multilines: true, controller: _bodyController),
            Button(
              isupdated: widget.isupdatePost,
              onPressed: onPressed,
            ),
          ],
        ));
  }
}
