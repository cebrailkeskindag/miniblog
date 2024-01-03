import 'package:miniblog/models/blog.dart';

abstract class ArticlesDetailState {}

class ArticlesDetailInitial extends ArticlesDetailState {}

class ArticlesDetailLoading extends ArticlesDetailState {}

class ArticlesDetailLoaded extends ArticlesDetailState {
  final Blog blog;
  ArticlesDetailLoaded({required this.blog});
}

class ArticlesDetailError extends ArticlesDetailState {}
