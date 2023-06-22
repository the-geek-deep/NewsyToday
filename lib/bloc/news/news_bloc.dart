import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/news/news_event.dart';
import '../../data/repositories/news_repository.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitialState());

  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNewsEvent) {
      yield* _mapFetchNewsEventToState();
    }
  }

  Stream<NewsState> _mapFetchNewsEventToState() async* {
    yield NewsLoadingState();

    try {
      final news = await newsRepository.fetchNews();
      yield NewsLoadedState(news: news, articles: []);
    } catch (error) {
      yield NewsErrorState( 'Failed to fetch news');
    }
  }
}
