import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/excepetion.dart';
import 'package:flutter_clean_architecture/features/posts/data/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachedPosts(List<PostModel> postmodel);
}

const Cached_posts = 'Cashed_posts';

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachedPosts(List<PostModel> postmodel) {
    List postModelToJson = postmodel
        .map<Map<String, dynamic>>(
          (e) => e.toJson(),
        )
        .toList();
    sharedPreferences.setString(Cached_posts, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final jsonString = sharedPreferences.getString(Cached_posts);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel = decodeJsonData
          .map<PostModel>(
            (e) => PostModel.fromJson(e),
          )
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
