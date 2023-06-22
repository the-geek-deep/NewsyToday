import 'package:hive/hive.dart';
import '../data/models/article_model.dart';

class HiveHelper {
  final String boxName = 'articlesBox';

  Future<void> saveArticles(List<ArticleModel> articles) async {
    // Open the Hive box for storing articles
    final box = await Hive.openBox(boxName);
    
    // Clear the box to remove any existing articles
    await box.clear();
    
    // Add all the articles to the box
    await box.addAll(articles);
    
    // Close the box
    await box.close();
  }

  Future<List<ArticleModel>> getArticles() async {
    // Open the Hive box for retrieving articles
    final box = await Hive.openBox(boxName);
    
    // Retrieve all the articles from the box as a list
    final articles = box.values.cast<ArticleModel>().toList();
    
    // Close the box
    await box.close();
    
    // Return the list of articles
    return articles;
  }
}
