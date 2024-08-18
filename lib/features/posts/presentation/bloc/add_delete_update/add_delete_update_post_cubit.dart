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
  AddDeleteUpdatePostCubit({required this.addPostcase,required this.deletePostcase,required this.updatePostcase})
      : super(AddDeleteUpdatePostInitial());
  final AddPost addPostcase;
  final DeletePost deletePostcase;
  final UpdatePost updatePostcase;
  addpost(Post post) async {
    emit(LoadingAddDeleteUpdateState());
    final failureOrSuces = await addPostcase(post);
    emit(_eitherDoneMessageOrErrorState(failureOrSuces, Add_Sucess_Message));
  }

  updatePost(Post post) async {
    emit(LoadingAddDeleteUpdateState());
    final failureOrSuces = await updatePostcase(post);
    emit(_eitherDoneMessageOrErrorState(failureOrSuces, Update_Sucess_Message));
  }

  deletePost(int id) async {
    emit(LoadingAddDeleteUpdateState());
    final failureOrSuces = await deletePostcase(id);
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
