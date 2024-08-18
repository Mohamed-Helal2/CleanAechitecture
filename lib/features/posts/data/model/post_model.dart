import '../../domain/entites/post.dart';

class PostModel extends Post {
 const PostModel({ super.id, required super.title, required super.body});


  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
      };
}
