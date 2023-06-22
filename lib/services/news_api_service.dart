import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsApiService {
  final String apiKey;
  final String apiUrl;

  NewsApiService({required this.apiKey, required this.apiUrl});

  Future<List<dynamic>> fetchNews() async {
    // Send an HTTP GET request to the API URL
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // If the response is successful (status code 200), parse the response body
      final body = jsonDecode(response.body);
      
      // Extract the 'articles' list from the response body, or an empty list if it's not available
      return body['articles'] ?? [];
    } else {
      // If the response is not successful, throw an exception with an error message
      throw Exception('Failed to fetch news');
    }
  }
}
