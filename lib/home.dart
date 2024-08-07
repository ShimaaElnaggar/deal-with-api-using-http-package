import 'dart:async';

import 'package:deal_with_api_using_http_package/services/post_service.dart';

import 'package:flutter/material.dart';

import 'models/post.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = PostService.fetchPosts();
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
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
