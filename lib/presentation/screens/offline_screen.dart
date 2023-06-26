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
            // Display a loading indicator while waiting for the data to be fetched
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if there was an error fetching the offline articles
            return const Center(child: Text('Failed to load offline articles'));
          } else {
            // Retrieve the offline articles from the snapshot data
            final offlineArticles = snapshot.data ?? [];

            // Display the offline articles using the ArticleList widget
            return ArticleList(articles: offlineArticles);
          }
        },
      ),
    );
  }
}
 