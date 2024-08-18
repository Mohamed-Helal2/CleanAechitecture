import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/Strings/failures.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';

import '../../../domain/entites/post.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required this.getAllPostsUseCases}) : super(PostsInitial());
  final GetAllPostsUseCases getAllPostsUseCases;

  getallpost() async {
    emit(LoadingPostsState());
    final failureOrPosts = await getAllPostsUseCases();
    emit(_mapfaliureOrSucessState(failureOrPosts));
  }

  refreshPosts() async {
    emit(LoadingPostsState());
    final failureOrPosts = await getAllPostsUseCases();
  emit(_mapfaliureOrSucessState(failureOrPosts));
  }

  PostsState _mapfaliureOrSucessState(Either<Failure, List<Post>> either) {
  return  either.fold(
      (l) {
        return failurePostsState(
          message: _mapFailutrToMessage(l),
        );
      },
      (r) {
        return SucessPostsState(posts: r);
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
