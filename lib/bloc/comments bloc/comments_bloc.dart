import 'package:bloc/bloc.dart';
import 'package:deal_with_api_using_http_package/repository/comment_repository.dart';
import 'package:meta/meta.dart';

import '../../models/comment.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  late CommentsRepository commentsRepository;
  CommentsBloc() : super(CommentsLoadingState()) {
    commentsRepository = CommentsRepository();
    on<FetchCommentsEvent>(_onGetComments);
  }
  Future<void> _onGetComments(
      FetchCommentsEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoadingState());
    try {
      var callResult = await commentsRepository.get({'postId': event.postId});
      if (callResult.isSuccess) {
        var comments = List<Comment>.from(
            callResult.data.map((e) => Comment.fromJson(e)).toList());
        emit(CommentsLoadedState(comments: comments));
      } else {
        emit(CommentsErrorState(errorMessage: callResult.error));
      }
    } catch (e) {
      emit(CommentsErrorState(errorMessage: 'Failed to fetch posts: $e'));
    }
  }
}
