import 'package:deal_with_api_using_http_package/views/post_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts bloc/posts_bloc.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  int selectedCardIndex = -1;
  @override
  void initState() {
    super.initState();
    activateBloc();
  }

  void activateBloc() {
    context.read<PostsBloc>().add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: const Center(child: Text('Posts')),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadedState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    color: selectedCardIndex == index
                        ? Colors.purple.shade200
                        : Colors.white,
                    surfaceTintColor: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          post.title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(post.body,
                            style: const TextStyle(
                              color: Colors.black54,
                            )),
                      ),
                      onTap: () {
                        setState(() {
                          selectedCardIndex = index;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetailsView(post: post)));
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is PostsErrorState) {
            //print(state.errorMessage);
            return Center(
                child: Text('Error fetching posts: ${state.errorMessage}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
