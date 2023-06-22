import '../../data/models/article_model.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<ArticleModel> articles;

  NewsLoadedState({required this.articles, required news});

  get news => null;
}

class NewsErrorState extends NewsState {
  NewsErrorState(String s);
}
