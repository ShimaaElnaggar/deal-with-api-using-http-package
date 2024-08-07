import 'dart:async';

import 'package:deal_with_api_using_http_package/views/all_comments_view.dart';
import 'package:deal_with_api_using_http_package/services/post_services.dart';

import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../models/post.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  late Future<List<Post>> posts;
int postId = 0;
  @override
  void initState() {
    super.initState();
    posts = PostService.fetchPosts();
  }

  Future<void> loadCommentsForPost(int postId) async {
    try {
      List<dynamic> commentsData = await PostService().fetchPostComments(postId);
      List<Comment> comments = commentsData.map((item) => Comment.fromJson(item)).toList();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Comments for Post $postId' , style: const TextStyle(fontWeight: FontWeight.bold),),
            content: SizedBox(
              height: 500, // Adjust height as needed
              width: 300, // Adjust width as needed
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments[index].name, style: TextStyle(color: Colors.purple.shade200,fontWeight: FontWeight.w700),),
                    subtitle: Text(comments[index].body),
                  );
                },
              ),
            ),
          );
        },
      );
    } catch (e) {
      print('Error loading comments: $e');
    }
  }

  Future<void> loadAllPostsCommentsByPostId( int postId) async {
    try {
      List<dynamic> commentsData = await PostService().fetchCommentsByPostId(postId);
      List<Comment> comments = commentsData.map((item) => Comment.fromJson(item)).toList();
     if(mounted){
       Navigator.of(context).push(
         MaterialPageRoute(builder: (context) => AllComments( postId: postId, comments: comments)),
       );
     }
    } catch (e) {
      print('Error loading comments by post ID: $e');
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: const Text('Show Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.comment),
            onPressed: () async {
              if (postId != 0) {
                await loadAllPostsCommentsByPostId(postId);
              } else {
                print('No post selected');
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
          future: posts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error.toString()}');
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    color: Colors.purple.shade100,
                    child: ListTile(
                      title: Text(
                        snapshot.data![index].title,
                        style: TextStyle(
                            color: Colors.purple.shade200,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      subtitle: Text(snapshot.data![index].body),
                      onTap: () {
                        int postId = snapshot.data![index].id;
                        loadCommentsForPost(postId);
                      },
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
