import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/news/news_event.dart';
import '../../data/repositories/news_repository.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitialState());

  // Map NewsEvent to NewsState
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNewsEvent) {
      yield* _mapFetchNewsEventToState();
    }
  }

  // Handle FetchNewsEvent and update the state accordingly
  Stream<NewsState> _mapFetchNewsEventToState() async* {
    // Notify that news loading is in progress
    yield NewsLoadingState();

    try {
      // Fetch news from the news repository
      final news = await newsRepository.getNews();

      // Update the state with the loaded news
      yield NewsLoadedState(news: news, articles: []);
    } catch (error) {
      // Notify that an error occurred while fetching news
      yield NewsErrorState('Failed to fetch news');
    }
  }
}
