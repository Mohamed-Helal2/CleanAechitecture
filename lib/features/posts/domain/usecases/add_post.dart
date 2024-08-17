import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/post_repostiroieas.dart';

import '../../../../core/error/failure.dart';
import '../entites/post.dart';

class AddPost {
  final PostRepostiroieas postRepostiroieas;
  AddPost(this.postRepostiroieas);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepostiroieas.addpost(post);
  }
}
