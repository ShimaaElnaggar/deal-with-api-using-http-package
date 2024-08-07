import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {

  static Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Post> posts = data.map((item) => Post.fromJson(item)).toList();
        return posts;
      }
    } catch (e) {
      //print(e);
      throw Exception('Failed to load data $e');
    }
    return [];
  }

  Future<dynamic> fetchPost(int id) async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post $id');
    }
  }

  Future<List<dynamic>> fetchPostComments(int postId) async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId/comments'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load comments for post $postId');
    }
  }

  Future<List<dynamic>> fetchCommentsByPostId(int postId) async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load comments with postId $postId');
    }
  }
}
