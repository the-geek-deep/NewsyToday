import 'package:flutter/material.dart';
import '../../presentation/widgets/article_list.dart';
import '../../utils/hive_helper.dart';

class OfflineScreen extends StatelessWidget {
  final HiveHelper hiveHelper;

   const OfflineScreen({super.key, required this.hiveHelper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Articles'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: hiveHelper.getArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load offline articles'));
          } else {
            final offlineArticles = snapshot.data ?? [];
            return ArticleList(articles: offlineArticles);
          }
        },
      ),
    );
  }
}
