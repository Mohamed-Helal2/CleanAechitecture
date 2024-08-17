import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/post_repostiroieas.dart';

import '../../../../core/error/failure.dart';

class DeletePost {
  final PostRepostiroieas postRepostiroieas;
  DeletePost(this.postRepostiroieas);

  Future<Either<Failure, Unit>> call(int id) async {
    return await postRepostiroieas.deletePost(id);
  }
}
