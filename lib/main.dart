import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './bloc/authentication/authentication_bloc.dart';
import './bloc/authentication/authentication_event.dart';
import './bloc/authentication/authentication_state.dart';
import './bloc/news/news_bloc.dart';
import './bloc/news/news_event.dart';
import './bloc/news/news_state.dart';
import './data/repositories/news_repository.dart';
import './presentation/screens/home_screen.dart';
import './presentation/screens/login_screen.dart';
import './presentation/screens/offline_screen.dart';
import './services/news_api_service.dart';
import './utils/hive_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final HiveHelper hiveHelper = HiveHelper();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) =>
              AuthenticationBloc(firebaseAuth: firebaseAuth)
                ..add(AppStartedEvent()),
        ),
        BlocProvider<NewsBloc>(
          create: (BuildContext context) => NewsBloc(
            newsRepository: NewsRepository(
              newsApiService: NewsApiService(apiKey: 'API_KEY', apiUrl: ''),
              hiveHelper: hiveHelper,
            ),
          )..add(FetchNewsEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticatedState) {
            return BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadedState) {
                  return HomeScreen(articles: state.articles);
                } else if (state is NewsErrorState) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Failed to fetch news'),
                    ),
                  );
                } else {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          } else if (state is OfflineScreenState) {
            return OfflineScreen(hiveHelper: HiveHelper());
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

class OfflineScreenState {
}
