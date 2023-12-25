import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/screens/blog_detail.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key, required this.blog}) : super(key: key);
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => BlogDetail(id: blog.id!)));
      },
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
                  color: Colors.grey,
                  child: Center(child: Image.network(blog.thumbnail!)),
                ),
              ),
              ListTile(
                title: Text(blog.title!),
                subtitle: Text(blog.author!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
