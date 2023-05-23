import 'package:hive/hive.dart';
import '../data/models/article_model.dart';

class HiveHelper {
  final String boxName = 'articlesBox';

  Future<void> saveArticles(List<ArticleModel> articles) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
    await box.addAll(articles);
    await box.close();
  }

  Future<List<ArticleModel>> getArticles() async {
    final box = await Hive.openBox(boxName);
    final articles = box.values.cast<ArticleModel>().toList();
    await box.close();
    return articles;
  }
}
