import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/widget/postDetails/delete_dialog_widget.dart';
import '../../../../../core/utils/snackbar.dart';
import '../../../../../core/widget/loading_widget.dart';
import '../../bloc/add_delete_update/add_delete_update_post_cubit.dart';
import 'edit_delete_button.dart';

class DeletePostBtnWidget extends StatelessWidget {
  const DeletePostBtnWidget({super.key, required this.postid});
  final int postid;
  @override
  Widget build(BuildContext context) {
    return EditDeleteButton(
        isedit: false, onPressed: () => deleteDialog(context));
  }

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostCubit, AddDeleteUpdatePostState>(
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
              Navigator.of(context).pop();
              SnackbarMessage().showSnackBar(
                  context: context,
                  message: state.errormessage,
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdateState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postid: postid);
          },
        );
      },
    );
  }
}
