import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';

import '../entites/post.dart';

abstract class PostRepostiroieas {
  Future<Either<Failure, List<Post>>> getAllpost();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatepost(Post post);
  Future<Either<Failure, Unit>> addpost(Post post);
}
