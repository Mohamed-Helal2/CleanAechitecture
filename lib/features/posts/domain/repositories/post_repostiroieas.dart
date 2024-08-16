import '../entites/post.dart';

abstract class PostRepostiroieas {
  Future<List<Post>> getAllpost();
  Future<bool> deletePost(int id);
  Future<bool> updatepost(Post post);
  Future<bool> addpost(Post post);
}
