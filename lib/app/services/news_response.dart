import 'package:tickertape_assignment/app/model/news_article_model.dart';

class NewsResponse {
  final List<NewsArticle> articles;
  final int currentPage;
  final bool hasMore;

  NewsResponse({
    required this.articles,
    required this.currentPage,
    required this.hasMore,
  });
}
