import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsApiService {
  final String apiKey;
  final String apiUrl;

  NewsApiService({required this.apiKey, required this.apiUrl});

  Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['articles'] ?? [];
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
