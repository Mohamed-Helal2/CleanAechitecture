import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/Strings/messages.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/update_post.dart';
import '../../../../../core/Strings/failures.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entites/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';

part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostCubit extends Cubit<AddDeleteUpdatePostState> {
  AddDeleteUpdatePostCubit(this._addPost, this._deletePost, this._updatePost)
      : super(AddDeleteUpdatePostInitial());
  final AddPost _addPost;
  final DeletePost _deletePost;
  final UpdatePost _updatePost;
  addpost(Post post) async {
    emit(LoadingAddDeleteUpdateState());
    final failureOrSuces = await _addPost(post);
    emit(_eitherDoneMessageOrErrorState(failureOrSuces, Add_Sucess_Message));
  }

  updatePost(Post post) async {
    emit(LoadingAddDeleteUpdateState());
    final failureOrSuces = await _updatePost(post);
    emit(_eitherDoneMessageOrErrorState(failureOrSuces, Update_Sucess_Message));
  }

  deletePost(int id) async {
    emit(LoadingAddDeleteUpdateState());
    final failureOrSuces = await _deletePost(id);
    emit(_eitherDoneMessageOrErrorState(failureOrSuces, Delete_Sucess_Message));
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String Message) {
    return either.fold(
      (l) {
        return FailureAddDeleteUpdateState(
            errormessage: _mapFailutrToMessage(l));
      },
      (_) {
        return SucessAddDeleteUpdateState(sucessmessage: Message);
      },
    );
  }

  String _mapFailutrToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure():
        return Server_Failure_Message;
      case EmptyCacheFailure():
        return Empty_Cached_Failure_Message;
      case OffLineFailure():
        return Offline_Failed_Message;
      default:
        return 'Un Expected Error';
    }
  }
}
