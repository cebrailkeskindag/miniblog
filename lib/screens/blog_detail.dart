import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_event.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_state.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});
  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleDetailBloc, ArticlesDetailState>(
        builder: (context, state) {
      if (state is ArticlesDetailInitial) {
        context
            .read<ArticleDetailBloc>()
            .add(FetchArticleDetail(id: widget.id));
        return const Text("İstek atılmalı..");
      }
      if (state is ArticlesDetailLoading) {
        return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()));
      }

      if (state is ArticlesDetailLoaded) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.blog.title!),
          ),
          body: Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: 4 / 2,
                      child: Container(
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: Center(
                              child: Image.network(state.blog.thumbnail!)))),
                  ListTile(
                    title: Text(state.blog.content!),
                    subtitle: Text(state.blog.author!),
                  )
                ],
              ),
            ),
          ),
        );
      }

      if (state is ArticlesDetailError) {
        return const Center(
          child: Text("Bloglar yüklenirken bir hata oluştu."),
        );
      }
      return Center(
        child: Text(widget.id),
      );
    });
  }
}
