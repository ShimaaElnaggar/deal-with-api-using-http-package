part of 'comments_bloc.dart';

@immutable
sealed class CommentsState {}

final class CommentsLoadingState extends CommentsState {}

final class CommentsLoadedState extends CommentsState {
  final List<Comment> comments;

  CommentsLoadedState({required this.comments });
}

final class CommentsErrorState extends CommentsState {
  final String errorMessage;

  CommentsErrorState({required this.errorMessage });
}
