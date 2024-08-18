import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/post_repostiroieas.dart';

import '../../../../core/error/failure.dart';
import '../entites/post.dart';

class GetAllPostsUseCases {
  final PostRepostiroieas repostiroieas;
  GetAllPostsUseCases({required this.repostiroieas});

  Future<Either<Failure, List<Post>>> call() async {
    return await repostiroieas.getAllpost();
  }
}
