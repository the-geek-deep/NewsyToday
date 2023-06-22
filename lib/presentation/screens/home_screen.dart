import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/authentication/authentication_event.dart';
import '/bloc/news/news_bloc.dart';
import '../../bloc/news/news_state.dart';
import '../../presentation/widgets/article_list.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoadedState) {
            return ArticleList(articles: state.articles);
          } else if (state is NewsErrorState) {
            return Center(child: Text('Failed to load news'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
