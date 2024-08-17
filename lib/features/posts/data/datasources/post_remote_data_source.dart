import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/excepetion.dart';
import 'package:flutter_clean_architecture/features/posts/data/model/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletepost(int id);
  Future<Unit> addpost(PostModel postmodel);
  Future<Unit> updatePost(PostModel postmodel);
}

const BaseUrl = 'https://jsonplaceholder.typicode.com/';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;
  PostRemoteDataSourceImpl(this.client);
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(BaseUrl + 'posts'),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postmodels = decodedJson
          .map<PostModel>(
            (e) => PostModel.fromJson(e),
          )
          .toList();
      return postmodels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addpost(PostModel postmodel) async {
    final Map<String, dynamic> body = {
      "title": postmodel.title,
      'body': postmodel.body
    };
    final response =
        await client.post(Uri.parse(BaseUrl + 'posts'), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletepost(int id) async {
    final response = await client.delete(Uri.parse("${BaseUrl}posts/$id"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postmodel) async {
    final postid = postmodel.id;
    final Map<String, dynamic> body = {
      "title": postmodel.title,
      "body": postmodel.body
    };
    final response = await client
        .put(Uri.parse("${BaseUrl}posts$postid"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
