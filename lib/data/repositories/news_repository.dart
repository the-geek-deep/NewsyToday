import '../../services/news_api_service.dart';
import '../../utils/hive_helper.dart';
import '../models/article_model.dart';


class NewsRepository {
  final NewsApiService newsApiService;
  final HiveHelper hiveHelper;

  NewsRepository({required this.newsApiService, required this.hiveHelper});

  Future<List<ArticleModel>> getNews() async {
    // Check if articles are available in Hive
    final offlineArticles = await hiveHelper.getArticles();

    if (offlineArticles.isNotEmpty) {
      return offlineArticles;
    } else {
      // Fetch news from the API
      final articles = await newsApiService.fetchNews();

      // Map the API response to ArticleModel objects
      final news = articles
          .map((article) => ArticleModel(
                title: article['title'],
                description: article['description'],
              ))
          .toList();

      // Save articles to Hive for offline access
      await hiveHelper.saveArticles(news);

      return news;
    }
  }

  fetchNews() {}
}
