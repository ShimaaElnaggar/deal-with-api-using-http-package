
import 'package:flutter/material.dart';

import '../models/comment.dart';

class AllComments extends StatelessWidget {
  final List<Comment> comments;
  final int  postId;
  const AllComments({required this.comments,required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Comments'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(comments[index].name),
            subtitle: Text(comments[index].body),
          );
        },
      ),
    );
  }
}
