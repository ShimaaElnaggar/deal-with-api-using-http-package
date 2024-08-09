import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/post.dart';
import '../../repository/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  late PostsRepository postRepository;
  PostsBloc() : super(PostsLoadingState()) {
    postRepository = PostsRepository();
    on<PostsEvent>(_onGetPost);
  }

  Future<void> _onGetPost(PostsEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    try {
      var callResult = await postRepository.get();
      if (callResult.isSuccess) {
        var posts = List<Post>.from(
            callResult.data.map((e) => Post.fromJson(e)).toList());
        emit(PostsLoadedState(posts: posts));
      } else {
        emit(PostsErrorState(errorMessage: callResult.error));
      }
    } catch (e) {
      emit(PostsErrorState(errorMessage: 'Failed to fetch posts: $e'));
    }
  }
}
