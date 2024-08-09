part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsLoadingState extends PostsState {}

final class PostsErrorState extends PostsState {
  final String errorMessage;

  PostsErrorState({required this.errorMessage });
}

final class PostsLoadedState extends PostsState {
  final List<Post> posts;

  PostsLoadedState({required this.posts });
}


