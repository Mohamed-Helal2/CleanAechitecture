import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/widget/loading_widget.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_post_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/posts_page.dart';

import '../../domain/entites/post.dart';
import 'package:flutter_clean_architecture/core/utils/snackbar.dart';

import '../widget/addupdatedelete/form_widget.dart';

class PostAddUpdate extends StatelessWidget {
  const PostAddUpdate({super.key, this.post, required this.isUpdatPost});
  final Post? post;
  final bool isUpdatPost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappBar(),
      body: _builbody(),
    );
  }

  AppBar _buildappBar() {
    return AppBar(
      title: Text(
        isUpdatPost ? "Edit Post" : "Add Post",
        style: const TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }

  Widget _builbody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostCubit, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is SucessAddDeleteUpdateState) {
              SnackbarMessage().showSnackBar(
                  context: context,
                  message: state.sucessmessage,
                  color: Colors.green);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const PostsPage(),
                ),
                (route) => false,
              );
            } else if (state is FailureAddDeleteUpdateState) {
              SnackbarMessage().showSnackBar(
                  context: context,
                  message: state.errormessage,
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdateState) {
              return const LoadingWidget();
            }
            return FormWidget(
              isupdatePost: isUpdatPost,
              post: isUpdatPost ? post : null,
            );
          },
        ),
      ),
    );
  }
}
