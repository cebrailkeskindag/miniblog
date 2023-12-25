import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogDetail extends StatefulWidget {
  final String id;

  BlogDetail({required this.id});

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late Future<Blog> futureBlog;

  @override
  void initState() {
    super.initState();
    futureBlog = fetchBlogById(widget.id);
  }

  Future<Blog> fetchBlogById(String blogId) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$blogId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Blog.fromJson(jsonData);
    } else {
      throw Exception('Failed to load blog details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detayı'),
      ),
      body: FutureBuilder<Blog>(
        future: futureBlog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final blog = snapshot.data!;
            return SizedBox(
              height: 360,
              child: Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 2,
                        child: Container(
                          width: double.infinity,
                          color: Colors.blueGrey,
                          child: Center(child: Image.network(blog.thumbnail!)),
                        ),
                      ),
                      ListTile(
                        title: Column(
                          children: [
                            Text(blog.title!),
                            Divider(),
                            Text(blog.content!)
                          ],
                        ),
                        subtitle: Text(blog.author!),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
