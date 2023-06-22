import 'package:flutter/material.dart';
import '../../data/models/article_model.dart';

class ArticleList extends StatelessWidget {
  final List<ArticleModel> articles;

  ArticleList({required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ListTile(
          title: Text(article.title),
          subtitle: Text(article.description),
        );
      },
    );
  }
}
