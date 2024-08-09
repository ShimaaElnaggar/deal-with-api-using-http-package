import 'package:deal_with_api_using_http_package/bloc/comments%20bloc/comments_bloc.dart';
import 'package:deal_with_api_using_http_package/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailsView extends StatefulWidget {
  final Post post;
  const PostDetailsView({required this.post, super.key});

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  bool isExpand = false;
  @override
  void initState() {
    init();

    super.initState();
  }

  void init() async {
    context.read<CommentsBloc>().add(FetchCommentsEvent(widget.post.id));
    if (isExpand) {
      isExpand = false;
      setState(() {});
    }
    await Future.delayed(const Duration(milliseconds: 300));
    isExpand = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text('Post ${widget.post.id.toString()}')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedContainer(
              height: isExpand ? 180 : 0,
              duration: const Duration(milliseconds: 400),
              child: SingleChildScrollView(
                child: PhysicalModel(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(widget.post.body,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.purple.shade100,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.post.userId.toString(),
                                style: TextStyle(color: Colors.purple.shade200),
                              )
                            ],
                          )

                          // post details
                        ],
                      ),
                    )),
              ),
            ),
            const SizedBox(height: 15),
            const Text('  Comments:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            Expanded(child:
                BlocBuilder<CommentsBloc, CommentsState>(builder: (ctx, state) {
              if (state is CommentsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CommentsErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is CommentsLoadedState) {
                return ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        color: Colors.purple.shade50,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.comments[index].body,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.comments[index].email,
                              style: TextStyle(color: Colors.purple.shade200),
                            ),
                          ),
                        ),
                      );
                    });
              }
              return const Text('No State Detected');
            }))
          ],
        ),
      ),
    );
  }
}
