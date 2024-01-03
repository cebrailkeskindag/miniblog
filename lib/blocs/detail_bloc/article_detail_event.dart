abstract class ArticleDetailEvent {}

class FetchArticleDetail extends ArticleDetailEvent {
 final String id;

  FetchArticleDetail({required this.id});
}

class ResetDetailEvent extends ArticleDetailEvent {}
