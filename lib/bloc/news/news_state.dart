import '../../data/models/article_model.dart';

// Base class for news states
abstract class NewsState {}

// Initial state indicating that the news state is not determined yet
class NewsInitialState extends NewsState {}

// State indicating that news loading is in progress
class NewsLoadingState extends NewsState {}

// State indicating that news has been successfully loaded
class NewsLoadedState extends NewsState {
  final List<ArticleModel> articles;

  NewsLoadedState({required this.articles, required news});

  // Placeholder method, can be removed or updated as per implementation
  get news => null;
}

// State indicating that an error occurred while fetching news
class NewsErrorState extends NewsState {
  NewsErrorState(String s);
}
