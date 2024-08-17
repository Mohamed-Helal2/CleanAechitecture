part of 'posts_cubit.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class LoadingPostsState extends PostsState {}

final class SucessPostsState extends PostsState {
  final List<Post> posts;
  @override
  List<Object> get props => [posts];

  SucessPostsState({required this.posts});
}

final class failurePostsState extends PostsState {
  final String message;
  @override
  List<Object> get props => [message];
  failurePostsState({required this.message});
  
}
