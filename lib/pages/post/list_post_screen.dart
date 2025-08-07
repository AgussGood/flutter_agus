import 'package:flutter/material.dart';
import 'package:flutter_agus/models/post_model.dart';
import 'package:flutter_agus/services/post_service.dart';

class ListPostScreen extends StatelessWidget {
  const ListPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Posts"),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<PostModel>>(
        future: PostService.listPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final dataPost = snapshot.data ?? [];
          if (dataPost.isEmpty) {
            return Center(child: Text('No posts available.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: dataPost.length,
            itemBuilder: (context, index) {
              final post = dataPost[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(post.id.toString()),
                    backgroundColor: Colors.amber,
                  ),
                  title: Text(
                    post.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(post.body),
                      SizedBox(height: 4),
                      Text('User ID: ${post.userId}',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () {
                    // TODO: Navigasi ke detail jika diperlukan
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
