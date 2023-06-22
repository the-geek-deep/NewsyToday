import '../../services/news_api_service.dart';
import '../../utils/hive_helper.dart';
import '../models/article_model.dart';

// Repository for fetching news data
class NewsRepository {
  final NewsApiService newsApiService;
  final HiveHelper hiveHelper;

  NewsRepository({required this.newsApiService, required this.hiveHelper});

  // Fetch news from the API or local storage
  Future<List<ArticleModel>> getNews() async {
    // Check if articles are available in Hive
    final offlineArticles = await hiveHelper.getArticles();

    if (offlineArticles.isNotEmpty) {
      // Return articles from local storage
      return offlineArticles;
    } else {
      // Fetch news from the API
      final articles = await newsApiService.fetchNews();

      // Map the API response to ArticleModel objects
      final news = articles.map((article) => ArticleModel(
            title: article['title'],
            description: article['description'],
          )).toList();

      // Save articles to Hive for offline access
      await hiveHelper.saveArticles(news);

      return news;
    }
  }

  // Placeholder method, can be removed or implemented as per requirement
  fetchNews() {}
}
