import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_event.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticlesDetailState> {
  final ArticleRepository articleRepository;

  ArticleDetailBloc({required this.articleRepository})
      : super(ArticlesDetailInitial()) {
    on<FetchArticleDetail>(_onFetchDetailArticle);
    on<ResetDetailEvent>(_onResetDetailArticle);
  }

  void _onFetchDetailArticle(
      FetchArticleDetail event, Emitter<ArticlesDetailState> emit) async {
    emit(ArticlesDetailLoading());
    try {
      final article = await articleRepository.fetchBlogById(event.id);
      emit(ArticlesDetailLoaded(blog: article));
    } catch (e) {
      emit(ArticlesDetailError());
    }
  }

  void _onResetDetailArticle(
      ResetDetailEvent event, Emitter<ArticlesDetailState> emit) async {
    emit(ArticlesDetailInitial());
  }
}
