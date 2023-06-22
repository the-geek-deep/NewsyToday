import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/authentication/authentication_event.dart';
import '/bloc/news/news_bloc.dart';
import '../../bloc/news/news_state.dart';
import '../../presentation/widgets/article_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Dispatch LogoutEvent when logout button is pressed
              BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            // Show a loading indicator while news is being loaded
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoadedState) {
            // Display the list of articles when news is loaded
            return ArticleList(articles: state.articles);
          } else if (state is NewsErrorState) {
            // Show an error message if there is a failure in loading news
            return const Center(child: Text('Failed to load news'));
          } else {
            // Empty container if no specific state is matched
            return Container();
          }
        },
      ),
    );
  }
}
