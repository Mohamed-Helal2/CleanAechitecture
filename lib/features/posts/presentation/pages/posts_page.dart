import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/getPost_cubit/posts_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/post_add_update.dart';

import '../../../../core/widget/loading_widget.dart';
import '../widget/postsPage/message_display_widget.dart';
import '../widget/postsPage/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappBar(),
      body: _buildbody(),
      floatingActionButton: _buildfloatingactionButton(context),
    );
  }

  Widget _buildbody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is SucessPostsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: postListWidget(posts: state.posts));
          } else if (state is failurePostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    return await context.read<PostsCubit>().refreshPosts();
  }

  Widget _buildfloatingactionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>const PostAddUpdate(isUpdatPost: false),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  PreferredSizeWidget _buildappBar() {
    return AppBar(
      title: const Text(
        "posts",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
