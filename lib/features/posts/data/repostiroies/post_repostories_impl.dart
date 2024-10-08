import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_clean_architecture/features/posts/data/model/post_model.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entites/post.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/post_repostiroieas.dart';

import '../../../../core/error/excepetion.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef Future<Unit> deleteOrAddOrUpdate();

class PostsRepostoriesImpl implements PostRepostiroieas {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepostoriesImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllpost() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachedPosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return right(localPosts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addpost(Post post) async {
    final PostModel postModel =
        PostModel(title: post.title, body: post.body);
    return await _getMessage(
      () {
        return remoteDataSource.addpost(postModel);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(
      () {
        return remoteDataSource.deletepost(id);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updatepost(Post post) async {
    final PostModel postmodel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(
      () {
        return remoteDataSource.updatePost(postmodel);
      },
    );
  }

  Future<Either<Failure, Unit>> _getMessage(
    deleteOrAddOrUpdate delteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await delteOrUpdateOrAddPost();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }
}
